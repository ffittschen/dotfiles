#!/usr/bin/env bash

function runDots() {
    # Ask for the administrator password upfront
    sudo -v

    # Keep-alive: update existing `sudo` time stamp until the script has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    # Run sections based on command line arguments
    for ARG in "$@"
    do
        if [ $ARG == "macosprep" ] || [ $ARG == "all" ]; then
            # Run the macosprep.sh Script
            echo ""
            echo "------------------------------"
            echo "Updating macOS and installing Xcode command line tools"
            echo "------------------------------"
            echo ""
            ./macosprep.sh
        fi
        if [ $ARG == "dotfiles" ] || [ $ARG == "all" ]; then
            # Run the dotfiles.sh Script
            echo ""
            echo "------------------------------"
            echo "Using dotbot to link all dotfiles"
            echo "------------------------------"
            echo ""
            ./dotbot.sh
        fi
        if [ $ARG == "brew" ] || [ $ARG == "all" ]; then
            # Run the brew.sh Script
            echo ""
            echo "------------------------------"
            echo "Installing Homebrew along with some common formulae and apps."
            echo "This also installs some applications from the Mac App Store."
            echo "This might awhile to complete, as some formulae need to be installed from source."
            echo "------------------------------"
            echo ""
            ./brew.sh
        fi
        if [ $ARG == "shell" ] || [ $ARG == "all" ]; then
            # Run the shell.sh Script
            echo ""
            echo "------------------------------"
            echo "Configuring fish shell and setting it as default."
            echo "------------------------------"
            echo ""
            ./shell.sh
        fi
        if [ $ARG == "mackup" ] || [ $ARG == "all" ]; then
            # Run the mackup.sh Script
            echo ""
            echo "------------------------------"
            echo "Restoring application settings using Mackup."
            echo "------------------------------"
            echo ""
            ./mackup.sh
        fi
        if [ $ARG == "macos" ] || [ $ARG == "all" ]; then
            # Run the macos.sh Script
            echo ""
            echo "------------------------------"
            echo "Setting sensible macOS defaults."
            echo "------------------------------"
            echo ""
            ./macos.sh
        fi
    done

    echo "------------------------------"
    echo "Completed running dots.sh, restart your computer to ensure all updates take effect"
    echo "------------------------------"
}

read -p "This script may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    runDots $@
fi;

unset runDots;