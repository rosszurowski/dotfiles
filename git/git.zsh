export GHI_PAGER=less
export GIT_MERGE_AUTOEDIT=no

# wrap git with hub
if [[ -f `command -v hub` ]] ; then alias git=hub ; fi
