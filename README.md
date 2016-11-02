# Dotfiles

This is my public repo for my dotfiles setup. Basically, this is a mix of scripts, used to install applications on a freshly reinstalled Mac
and dotfiles, which will restore my settings.

First of all, I have to thank @donnemartin for his [dev-setup](https://github.com/donnemartin/dev-setup), @anishathalye for [dotbot](https://github.com/anishathalye/dotbot) and his [awesome article](http://www.anishathalye.com/2014/08/03/managing-your-dotfiles/) about managing dotfiles, and @driesvints for another [awesome article](https://driesvints.com/blog/getting-started-with-dotfiles/) about getting started with dotfiles.

Since I am using a mix of the three approaches, I opted not to fork them, but to credit them like this.

## Clean macOS Setup

Follow these install instructions to setup a new Mac.

1. Install the Command Line Developer Tools: `xcode-select --install`
1. Clone this repo: `git clone https://github.com/ffittschen/dotfiles.git`
1. Accept installing the Command Line Developer Tools, in case git is not installed yet.
1. Make sure to provide the storage location of Mackup. (In my case, this is a private GitHub repo, so I have to clone it in this step)
1. Sign in to the Mac App Store, as it is required for `mas` in the `Brewfile`.
1. Run the `dots.sh` script. You can pass parameters to run just parts of the script. Run all: `./dots.sh all`. Run `macosprep.sh`, `dotbot.sh`, `brew.sh`, `shell.sh`, `mackup.sh` and `macos.sh`: `./dots.sh macosprep dotbot brew shell mackup macos`
1. Open the System Preferences and provide Accessibility access to `Alfred`.
1. Copy public and private SSH keys to `~/.ssh` and make sure the permissions are set to `600`
1. Run the `Little Snitch` installer at `/usr/local/Caskroom/little-snitch/#{version}/Little Snitch Installer.app`.
1. Restart your computer to finalize the process

Your Mac is now ready to use!