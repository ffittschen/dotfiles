# aliases
. ~/.config/fish/aliases.fish

# Disable fish greeting
set fish_greeting ""

# rbenv init
status --is-interactive; and . (rbenv init -|psub)

# Jekyll
set -gx JEKYLL_ENV development

# Set locale for SSH connections
set -gx LC_ALL en_US.UTF-8  
set -gx LANG en_US.UTF-8

test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
