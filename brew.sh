#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
echo "Installing applications specified in the Brewfile"
brew bundle

# Accept the Xcode license agreement
echo "Accepting the Xcode license agreement"
/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild -license accept

# Initialize rbenv for bash
echo "Initializing rbenv for bash"
file="~/.bash_profile"
if [ -f "$file" ]
then
	grep -q 'eval "$(rbenv init -)"' ~/.bash_profile || echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
else
	echo 'eval "$(rbenv init -)"' > ~/.bash_profile
fi
source ~/.bash_profile

# Install ruby using rbenv
if rbenv versions | grep "*" | grep -q "system"
then
	echo "Installing ruby 2.3.1 using rbenv"
	rbenv install 2.3.1
	rbenv global 2.3.1 
fi

# Remove outdated versions from the cellar.
brew cleanup