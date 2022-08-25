# Dotfiles

This is my public repo for my dotfiles setup. Basically, this is a mix of scripts, used to install applications on a freshly reinstalled Mac
and dotfiles, which will restore my settings.

These dotfiles are managed using [chezmoi](https://www.chezmoi.io)

## Clean macOS Setup

Follow these install instructions to setup a new Mac.

1. Launch Terminal.app
2. Run the [chezmoi installation command](https://www.chezmoi.io/install/): `sh -c "$(curl -fsLS chezmoi.io/get)" -- -b "$HOME/.local/bin" init --apply ffittschen`
3. Open System Preferences > Security & Privacy
4. Allow Full Disk Access for iTerm.app
5. Launch iTerm.app
6. Enable biometric unlock in the 1Password app.
7. Establish 1Password session: `eval (op signin)`
8. Run `chezmoi update` to complete the setup

Your Mac is now ready to use!