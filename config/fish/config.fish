# aliases
. ~/.config/fish/aliases.fish

# Disable fish greeting
set fish_greeting ""

# Jekyll
set -gx JEKYLL_ENV development

# Set locale for SSH connections
set -gx LC_ALL en_US.UTF-8  
set -gx LANG en_US.UTF-8

# Don't activate HIGGS Homebrew updater
set -gx SKIP_HOMEBREW_UPDATER 1

# GO
set -gx GOPATH ~/Development/go
set -gx PATH $PATH /usr/local/opt/go/libexec/bin $GOPATH/bin

# yarn
set -gx PATH $PATH $HOME/.config/yarn/global/node_modules/.bin

# Python
set -gx PATH $PATH (python -m site --user-base)/bin (python3 -m site --user-base)/bin

# Initialize rbenv
status --is-interactive; and . (rbenv init -|psub)

# /usr/local/sbin -- for zmap
set -gx PATH $PATH /usr/local/sbin

test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
