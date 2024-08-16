// This tool deletes local branches that have been merged in the remote
// repository.
package main

import (
	"bufio"
	"errors"
	"flag"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"sort"
	"strings"
	"sync"
)

var (
	defaultBranch = flag.String("base", "", `Base branch name (if "", use default from remote)`)
	remoteName    = flag.String("remote", "origin", "Remote repository name")
	confirm       = flag.Bool("dry-run", false, "Confirm before deleting branches")
	verbose       = flag.Bool("verbose", false, "Verbose output")
)

func init() {
	flag.Usage = func() {
		fmt.Fprintf(os.Stderr, `Usage: %[1]s [flags]

Delete local branches that have been merged into the 'main' branch of a remote
git repository, handling squash and rebase merges too.

If you'd like to list branches before deleting, pass the --dry-run flag.

Options:
`, filepath.Base(os.Args[0]))
		flag.PrintDefaults()
	}
}

func main() {
	flag.Parse()
	// Change working directory to the root of the repository.
	root, err := repoRoot()
	if err != nil {
		if strings.Contains(err.Error(), "not a git repository") {
			fatalf("Error: not inside a git repository\n")
		}
		fatalf("Error finding repository root: %v\n", err)
	} else if err := os.Chdir(root); err != nil {
		fatalf("Error changing directories to repository root: %v\n", err)
	}
	// Find the default branch based on the repository settings.
	baseBranch, err := findBaseBranch()
	if err != nil {
		if errors.Is(err, ErrNoDefaultBranch) {
			fatalf("Error: %v\nSet a base branch by running:\n\n  git remote set-head origin --auto\n\n", err)
		}
		fatalf("Error finding base branch: %v\n", err)
	}
	// Find all branches that have been merged into the default branch.
	merged, err := mergedBranches(baseBranch)
	if err != nil {
		fatalf("Error finding merged branches: %v\n", err)
	}
	if len(merged) == 0 {
		printf("No stale branches merged into %s\n", baseBranch)
		os.Exit(0)
		return
	}
	// Confirm the list of branches to delete.
	count := len(merged)
	noun := "branches"
	if count == 1 {
		noun = "branch"
	}
	if *confirm {
		printf("%d %s merged into %s:\n", count, noun, baseBranch)
		printf("  %s\n", strings.Join(merged, "\n  "))
		if ok := prompt(fmt.Sprintf("Delete %d %s?", count, noun), false); !ok {
			os.Exit(0)
			return
		}
	}
	// Checkout the default branch and delete the branches.
	if _, err := git("checkout", baseBranch); err != nil {
		fatalf("Error checking out %q: %v\n", baseBranch, err)
	}
	printf("Deleting %d %s merged into %s:\n", count, noun, baseBranch)
	for _, br := range merged {
		_, err := git("branch", "-D", br)
		if err != nil {
			printf("Error deleting %q: %v\n", br, err)
			continue
		}
		printf("  %s\n", br)
	}
}

// mergedBranches returns a list of all local branches that have been merged
// into the given baseBranch.
func mergedBranches(baseBranch string) ([]string, error) {
	branches, err := listBranchNames(baseBranch)
	if err != nil {
		return nil, fmt.Errorf("listing branches: %v", err)
	}
	var merged []string
	var wg sync.WaitGroup
	var mu sync.Mutex
	for _, br := range branches {
		wg.Add(1)
		br := br
		go func(branch string) {
			defer wg.Done()
			m, err := mergedBranch(baseBranch, branch)
			if err != nil {
				printf("Skipping %q: %v\n", br, err)
				return
			}
			if !m {
				return
			}
			mu.Lock()
			merged = append(merged, br)
			mu.Unlock()
		}(br)
	}
	wg.Wait()
	sort.Slice(merged, func(i, j int) bool { return merged[i] < merged[j] })
	return merged, nil
}

// mergedBranch returns true if the given branch has completely merged with
// the baseBranch.
func mergedBranch(baseBranch, branch string) (bool, error) {
	ancestorHash, err := git("merge-base", baseBranch, branch)
	if err != nil {
		return false, fmt.Errorf("finding merge base for %q: %v", branch, err)
	}
	treeID, err := git("rev-parse", branch+"^{tree}")
	if err != nil {
		return false, fmt.Errorf("finding tree ID for %q: %v", branch, err)
	}
	danglingCommitID, err := git("commit-tree", treeID, "-p", ancestorHash, "-m", "Temp commit for "+branch)
	if err != nil {
		return false, fmt.Errorf("creating temporary commit for %q: %v", branch, err)
	}
	output, err := git("cherry", baseBranch, danglingCommitID)
	if err != nil {
		return false, fmt.Errorf("checking for cherry-pick of %q: %v", branch, err)
	}
	if !strings.HasPrefix(output, "-") {
		return false, nil
	}
	return true, nil
}

var ErrNoDefaultBranch = errors.New("no default branch")

// findBaseBranch returns the name of the default branch for the repository.
func findBaseBranch() (string, error) {
	remotePrefix := fmt.Sprintf("refs/remotes/%s/", *remoteName)
	if *defaultBranch != "" {
		_, err := git("rev-parse", "--verify", remotePrefix+*defaultBranch)
		if err != nil {
			if strings.HasSuffix(err.Error(), "a single revision") {
				return "", fmt.Errorf("remote %q has no %q branch", *remoteName, *defaultBranch)
			}
			return "", fmt.Errorf("checking for %q: %v", *defaultBranch, err)
		}
		return *defaultBranch, nil
	}
	originHead, err := git("symbolic-ref", remotePrefix+"HEAD")
	if err != nil {
		if strings.HasSuffix(err.Error(), "is not a symbolic ref") {
			return "", fmt.Errorf("remote %q has %w set", *remoteName, ErrNoDefaultBranch)
		}
		return "", err
	}
	return strings.TrimPrefix(originHead, remotePrefix), nil
}

// listBranchNames returns a list of all local branch names.
func listBranchNames(baseBranch string) ([]string, error) {
	var result []string
	listOut, err := git("branch", "--list", "--format=%(refname:short)")
	if err != nil {
		return nil, err
	}
	list := strings.Split(strings.TrimSpace(listOut), "\n")
	hasDefault := false
	for _, s := range list {
		if s == baseBranch {
			hasDefault = true
			continue
		}
		result = append(result, strings.TrimSpace(s))
	}
	if !hasDefault {
		return nil, fmt.Errorf("default branch %q not found in local branches", baseBranch)
	}
	return result, nil
}

func repoRoot() (string, error) {
	return git("rev-parse", "--show-toplevel")
}

func git(cmd string, args ...string) (string, error) {
	if *verbose {
		printf("git %s %s\n", cmd, strings.Join(args, " "))
	}
	out, err := exec.Command("git", append([]string{cmd}, args...)...).Output()
	if err != nil {
		var ex *exec.ExitError
		if errors.As(err, &ex) {
			return "", errors.New(strings.SplitN(string(ex.Stderr), "\n", 2)[0])
		}
		return "", err
	}
	return strings.TrimSpace(string(out)), nil
}

// prompt prints a boolean CLI prompt and returns the user's response.
func prompt(label string, def bool) bool {
	choices := "Y/n"
	if !def {
		choices = "y/N"
	}
	r := bufio.NewReader(os.Stdin)
	var s string
	for {
		printf("%s [%s] ", label, choices)
		s, _ = r.ReadString('\n')
		s = strings.TrimSpace(s)
		if s == "" {
			return def
		}
		s = strings.ToLower(s)
		if s == "y" || s == "yes" {
			return true
		}
		if s == "n" || s == "no" {
			return false
		}
	}
}

func printf(format string, args ...interface{}) {
	fmt.Fprintf(os.Stderr, format, args...)
}

func fatalf(format string, args ...interface{}) {
	printf(format, args...)
	os.Exit(1)
}
