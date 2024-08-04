# My Dotfiles
 This repo contains my setup for [EndeavourOS](https://endeavouros.com/) with the [i3](https://i3wm.org/) window manager. 

 Basically, this replaces your current `.config` directory with the contents of this repo's `config` using `stow`. 

 It also install a bunch of packages and remove packages I don't use from a standard EndeavourOS installation.

  If you are only interested in my setup for specific software (say `nvim` or `wezterm`) you can fetch it directly from the `config` directory.

  Here's the directory structure for this repo:

  ```
├── assets/
|    └── // Contains a list of packages to install (dependencies) and to be removed (bloat)
├── bin/
|     └── // Custom scripts that I want available system-wide. Includes the setup script.
└── config/
|     └── // Config files I want backed up
  ```
 
> #### ⚠️ This repository is is maintained FOR ME and is poorly tested since I don't change machines too often.
> #### ⚠️ USE IT AT YOUR OWN RISK, and definetely do not use it if you don't even now what a `.config` directory is.

# How to Use
## First Usage
Clone this repo directly on your home directory without giving it a custom name (the scripts rely on access to these files via `$HOME/dotfiles/`). 

On your home directory:

```bash
git clone git@github.com:edbar42/dotfiles.git
```

Then, run the installation script under `bin/setup`. If you're still on your home directory:

```bash
./dotfiles/bin/setup
```
The script assumes you are on a brand new installation and will install all necessary packages, change your user's shell and remove bloat. If it ran with no errors, you should be prompted to login again so i3 can be properly restarted. 

The contents of your previous `.config` directory will have been moved to `./old-config`.

## Updating
Whenever you want to update your system with changes you made to `config` or `bin` just run:

```bash
setup sync
```

After the first installation `setup` should be available system-wide because the contents of `bin` are on your `$PATH` under `$HOME/.bin/`.
