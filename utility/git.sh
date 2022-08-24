#!/usr/bin/env sh
#
# This script should be run via curl:
#   sh -c "$(curl -fsSL https://easy.jayson.org/utility/git.sh)"
#
set -e

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

add_global_option() {
  git config --global "$1" "$2"
}

if ! command_exists git; then
  echo "git is not installed"
  exit 1
fi

# change the default text editor to vim if it exists
#  see https://git-scm.com/docs/git-config#Documentation/git-config.txt-coreeditor
if command_exists vim; then
  add_global_option core.editor vim
fi

# overriding the default branch name to main
#  see https://git-scm.com/docs/git-config#Documentation/git-config.txt-initdefaultBranch
add_global_option init.defaultBranch main

# rebase branches on top of the fetched branch, instead of merging
# the default branch from the default remote when "git pull" is run
#  see https://git-scm.com/docs/git-config#Documentation/git-config.txt-pullrebase
add_global_option pull.rebase true

# automatically create a temporary stash before the operation begins, and
# apply it after the operation ends
#  see https://git-scm.com/docs/git-config#Documentation/git-config.txt-rebaseautoStash
add_global_option rebase.autoStash true

# automatically clean Git objects in repository locally
# whenever you fetch changes from remote
#  see https://git-scm.com/docs/git-config#Documentation/git-config.txt-fetchprune
add_global_option fetch.prune true

# adds extra colors when running git diff to show blocks of lines
# that remain unchanged but have moved in the file
#  see https://git-scm.com/docs/git-config#Documentation/git-config.txt-diffcolorMoved
add_global_option diff.colorMoved zebra

# pushes the current branch with the same name on the remote
#  see https://git-scm.com/docs/git-config#Documentation/git-config.txt-pushdefault
add_global_option push.default simple

# add some aliases to some of git's common commands
#  see https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases
#  and https://git-scm.com/docs/git-config#Documentation/git-config.txt-alias
add_global_option alias.p "push"
add_global_option alias.c "commit"
add_global_option alias.s "status"
add_global_option alias.aa "add ."
add_global_option alias.amend "commit --amend"
add_global_option alias.sl "log --graph --decorate --pretty=oneline --abbrev-commit --all"
add_global_option alias.gl "log --color --graph --pretty=format:'%Cred%h%Creset %C(bold blue)<%an>%Creset ---%C(yellow)%d%Creset %s %Cgreen(%cr)' --abbrev-commit"

printf "🎉  Congratulations, you can now save 5 minutes a day to slacking off.\n"
