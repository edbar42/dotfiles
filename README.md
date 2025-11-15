# My Dotfiles

This repo contains my setup for Arch-based distributions with [Hyprland](https://hyprland.org/) window manager and managed using [chezmoi](https://www.chezmoi.io/).

If you are only interested in my setup for specific software (say `nvim` or `wezterm`) you can fetch it directly from the repository.

> [!WARNING]
> These are meant to work on my machines. Use it at your own risk.

# How to Use

## Prerequisites

First, install chezmoi. See the [chezmoi installation guide](https://www.chezmoi.io/install/) for instructions specific to your system.

On Arch-based distributions, you can install it via:

```bash
pacman -S chezmoi
```

## First Usage

Initialize chezmoi with this dotfiles repository:

```bash
chezmoi init git@github.com:edbar42/dotfiles.git
```

Review the changes that will be made:

```bash
chezmoi diff
```

Apply the dotfiles:

```bash
chezmoi apply
```

Or, you can do both initialization and application in one command:

```bash
chezmoi init --apply git@github.com:edbar42/dotfiles.git
```

## Syncing Changes

To update your dotfiles from the repository and apply any changes:

```bash
chezmoi update
```

Or, if you want to review changes before applying:

```bash
chezmoi git pull
chezmoi diff
chezmoi apply
```

# References

- [kickstart](https://github.com/nvim-lua/kickstart.nvim)
- [ThePrimeagen's NeoVim config](https://github.com/ThePrimeagen/init.lua)
- [LARBS](https://github.com/LukeSmithxyz/LARBS)
- [EndeavourOS i3wm setup](https://github.com/endeavouros-team/endeavouros-i3wm-setup)
- [Omarchy's dotfiles](https://github.com/Omarchy)
