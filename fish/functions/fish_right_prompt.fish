# function fish_right_prompt -d "Write out the right prompt with non zero exit status and date/time"
#   __git_status
# end

# function __git_status
#   set git_branch (command git rev-parse --abbrev-ref HEAD 2> /dev/null)

#   set -l submodule_syntax
#   set submodule_syntax "--ignore-submodules=dirty"
#   set git_dirty (command git status -s $submodule_syntax  2> /dev/null)

#   if [ -n "$git_branch" ]
#     if [ -n "$git_dirty" ]
#       set_color yellow  # dirty, yellow
#     else
#       set_color brblack  # clean, gray
#     end
#     echo $git_branch
#     set_color normal
#   end
# end
