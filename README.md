# My Dotfiles
 This repo contains my setup for [EndeavourOS](https://endeavouros.com/) with the [i3](https://i3wm.org/) window manager.

 Basically, this replaces your current `.config` directory with the contents of this repo's `config` using `stow`.

 It also installs a bunch of packages and removes some from a standard EndeavourOS installation.

  If you are only interested in my setup for specific software (say `nvim` or `wezterm`) you can fetch it directly from the `config` directory.

  Here's the directory structure for this repo:

  ```
├── assets/
|    └── // Contains a list of packages to install (dependencies) and to be removed (bloat)
├── bin/
|     └── // Custom scripts that I want available system-wide. Includes the setup script.
└── config/
|     └── // Config files for specific software I use
  ```

 > [!WARNING]
 > These are meant to work on my machines. Use it at your own risk.

# How to Use
## First Usage
Clone this repo directly on your home directory without giving it a custom name (the scripts rely on access to these files via `$HOME/dotfiles/`).

Simply put, run this from your home directory:

```bash
git clone git@github.com:edbar42/dotfiles.git
```

Then, run the installation script under `bin/setup`.

If you're still on your home directory:

```bash
./dotfiles/bin/setup
```
The script assumes you are on a brand new installation and will install all necessary packages, change your user's shell and remove bloat. If it ran with no errors, you should be prompted to login again on your desktop environment.

The contents of your previous `.config` directory will have been moved to `.old-config`.

## Updating
Whenever you want to update your system with changes you made to `config` or `bin` just run:

```bash
setup sync
```

After the first installation `setup` should be available system-wide because the contents of `bin` are on your `$PATH` under `$HOME/.bin/`.

The `sync` routine will check for missing dependencies and update any missing links using stow.
# References
Some useful references that helped me setup this repo.

- [kickstart](https://github.com/nvim-lua/kickstart.nvim)
- [ThePrimeagen's NeoVim config](https://github.com/ThePrimeagen/init.lua)
- [LARBS](https://github.com/LukeSmithxyz/LARBS)
- [EndeavourOS i3wm setup](https://github.com/endeavouros-team/endeavouros-i3wm-setup)
