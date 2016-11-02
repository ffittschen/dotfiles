# aliases
. ~/.config/fish/aliases.fish

# z config
set -gx Z_SCRIPT_PATH /usr/local/etc/profile.d/z.sh

# Fisherman config and init
set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish

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
