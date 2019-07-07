# aliases
. ~/.config/fish/aliases.fish

# Disable fish greeting
set fish_greeting ""

# Set locale for SSH connections
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8

# yarn
set -gx PATH $PATH $HOME/.config/yarn/global/node_modules/.bin

# Python
set -gx PATH $PATH (python -m site --user-base)/bin (python3 -m site --user-base)/bin

# Initialize rbenv
status --is-interactive; and . (rbenv init -|psub)

test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
