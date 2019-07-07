#!/bin/sh
# shellcheck disable=SC2155

# Colourful manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Set to avoid `env` output from changing console colour
export LESS_TERMEND=$'\E[0m'

# Print field by number
field() {
  ruby -ane "puts \$F[$1]"
}

# Setup paths
remove_from_path() {
  [ -d "$1" ] || return
  # Doesn't work for first item in the PATH but I don't care.
  export PATH=${PATH//:$1/}
}

add_to_path_start() {
  [ -d "$1" ] || return
  remove_from_path "$1"
  export PATH="$1:$PATH"
}

add_to_path_end() {
  [ -d "$1" ] || return
  remove_from_path "$1"
  export PATH="$PATH:$1"
}

force_add_to_path_start() {
  remove_from_path "$1"
  export PATH="$1:$PATH"
}

quiet_which() {
  command -v "$1" >/dev/null
}

add_to_path_end "/sbin"
add_to_path_end "$HOME/.rbenv/bin"
add_to_path_end "$HOME/.dotfiles/bin"
add_to_path_start "/usr/local/bin"
add_to_path_start "/usr/local/sbin"

# Setup Go development
#export GOPATH="$HOME/.gopath"
#add_to_path_end "$GOPATH/bin"

# Run rbenv if it exists
quiet_which rbenv && add_to_path_start "$(rbenv root)/shims"

# Aliases
alias mkdir="mkdir -vp"
alias df="df -H"
alias rm="rm -iv"
alias mv="mv -iv"
alias cp="cp -irv"
alias du="du -sh"
alias make="nice make"
alias less="less --ignore-case --raw-control-chars"
alias rsync="rsync --partial --progress --human-readable --compress"
alias be="bundle exec"
alias sha256="shasum -a 256"

# Platform-specific stuff
if quiet_which brew
then
  export HOMEBREW_PREFIX="$(brew --prefix)"
  export HOMEBREW_REPOSITORY="$(brew --repo)"
  export HOMEBREW_AUTO_UPDATE_SECS=3600

  # Output whether the dependencies for a Homebrew package are bottled.
  brew_bottled_deps() {
    for DEP in "$@"; do
      echo "$DEP deps:"
      brew deps --include-build "$DEP" | xargs brew info | grep stable
      [ "$#" -ne 1 ] && echo
    done
  }
fi

if [ "$MACOS" ]
then
  export GREP_OPTIONS="--color=auto"
  export CLICOLOR=1

  if quiet_which diff-highlight
  then
    # shellcheck disable=SC2016
    export GIT_PAGER='diff-highlight | less -+$LESS -RX'
  else
    # shellcheck disable=SC2016
    export GIT_PAGER='less -+$LESS -RX'
  fi

  if quiet_which exa
  then
    alias ls="exa -Fg"
  else
    alias ls="ls -F"
  fi

  add_to_path_end "$HOMEBREW_PREFIX/opt/git/share/git-core/contrib/diff-highlight"
  add_to_path_end "$HOME/Library/Python/2.7/bin"
  add_to_path_end "/Applications/Fork.app/Contents/Resources"
  add_to_path_end "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  add_to_path_end "/Applications/Sketch.app/Contents/Resources/sketchtool/bin"
  add_to_path_end "/Applications/Xcode.app/Contents/Developer/usr/bin"
  add_to_path_end "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin"

  alias ql="qlmanage -p 1>/dev/null"
  alias locate="mdfind -name"
  alias finder-hide="setfile -a V"
  alias fork="fork_cli"

  rbenv-sync-homebrew-rubies
elif [ "$LINUX" ]
then
  quiet_which keychain && eval "$(keychain -q --eval --agents ssh id_rsa)"

  add_to_path_end "/data/github/shell/bin"

  alias su="/bin/su -"
  alias ls="ls -F --color=auto"
  alias open="xdg-open"
elif [ "$WINDOWS" ]
then
  alias ls="ls -F --color=auto"

  open() {
    # shellcheck disable=SC2145
    cmd /C"$@"
  }
fi

# Set up editor
if quiet_which code
then
  export EDITOR="code"
  export GIT_EDITOR="$EDITOR -w"
  export SVN_EDITOR="$GIT_EDITOR"
elif quiet_which vim
then
  export EDITOR="vim"
elif quiet_which vi
then
  export EDITOR="vi"
fi
alias e="$EDITOR"

# Pretty-print JSON files
json() {
  [ -n "$1" ] || return
  jsonlint "$1" | jq .
}

# Move files to the Trash folder
trash() {
  mv "$@" "$HOME/.Trash/"
}

# Look in ./bin but do it last to avoid weird `which` results.
force_add_to_path_start "bin"
