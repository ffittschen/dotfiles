# Dotfiles

This is my public repo for my dotfiles setup. Basically, this is a mix of scripts, used to install applications on a freshly reinstalled Mac
and dotfiles, which will restore my settings.

These dotfiles are managed using [chezmoi](https://www.chezmoi.io)

## Clean macOS Setup

Follow these install instructions to setup a new Mac.

1. Install Xcode through App Store
2. Launch Terminal.app
3. Install [Homebrew](https://brew.sh)
4. Run the [chezmoi installation command](https://www.chezmoi.io/install/): `sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin" init --apply ffittschen`
5. Open System Preferences > Security & Privacy
6. Allow Full Disk Access for iTerm.app
7. Launch iTerm.app
8. Enable biometric unlock in the 1Password app.
9. Establish 1Password session: `eval (op signin)`
10. Run `chezmoi update` to complete the setup

Your Mac is now ready to use!
