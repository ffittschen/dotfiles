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

# Workaround for fish 3.1.0 breaking $PATH (see https://github.com/fish-shell/fish-shell/issues/6594)
set -gx PATH $PATH /usr/local/bin

# yarn
set -gx PATH $PATH $HOME/.config/yarn/global/node_modules/.bin

# Initialize rbenv
status --is-interactive; and source (rbenv init -|psub)

# /usr/local/sbin -- for zmap
set -gx PATH $PATH /usr/local/sbin

# Skip fastlane update check
set -gx FASTLANE_SKIP_UPDATE_CHECK 1

# test -e ~/.iterm2_shell_integration.fish; and source ~/.iterm2_shell_integration.fish

# Add OpenJDK installation to user paths
set -g fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths

# Add VS Code cli to PATH
set -g fish_user_paths "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" $fish_user_paths
