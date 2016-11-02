#!/usr/bin/env bash

# Configure fish shell and set it as default.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# We installed the fish shell, now we have to activate it
echo "Adding the installed fish shell to the list of allowed shells"
sudo bash -c "grep -q '/usr/local/bin/fish' /etc/shells || echo '/usr/local/bin/fish' >> /etc/shells"
# Change to the new shell, prompts for password
chsh -s $(which fish)

# Install fisherman (http://fisherman.sh)
if test ! $(which fisher); then
	echo "Install fisherman"
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
fi

# Initialize fisher (This downloads all plugins specified in the fishfile)
echo "Initializing fisher"
fish -c "fisher"

