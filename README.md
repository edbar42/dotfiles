# Dotfiles

### ⚠️ This repository is still under construction. ⚠️

This is where I keep my configs and dotfiles for my linux system. At the moment, these are aimed to work for a fresh install of [EndeavourOS](https://endeavouros.com/) with the [i3](https://i3wm.org/) window manager. Since I use [stow](https://www.gnu.org/software/stow/) to handle actually linking my dotfiles to my system, the configuration is stored in a `dot-config` directory with a `dot-zshrc` file outside of that.

>   This repo contains submodules. When cloning it, use the `--recursive` flag:

```
git clone --recursive git@github.com:edbar42/dotfiles.git
```

# Installation
Once cloned, just run `setup.sh`. Make sure you have execution privileges for it.

If you only wish to update the links to your dotfiles, run `setup.sh sync` instead.

# Software that I use for these config files:
### [kitty](https://github.com/kovidgoyal/kitty)
  With a slight variation of [Japanesque](https://github.com/kovidgoyal/kitty-themes/blob/master/themes/Japanesque.conf) and no need for `tmux`.
  
### [mpv](https://mpv.io/)
  [The based gigachad's video player.](https://www.youtube.com/watch?v=w-g04TLp0tg)
  
### [neovim](https://neovim.io/)
  More than an IDE, a [PDE](https://www.youtube.com/watch?v=QMVIJhC9Veg).
  
  My config heavily relies on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), an amazing project to get started with configuring neovim for your needs.

### [ranger](https://github.com/ranger/ranger)
  For all my file managing needs that don't involve click-and-drag.

  Support for NerdFont icons provided by [ranger_devicons](https://github.com/alexanderjeurissen/ranger_devicons).
### [vim](https://www.vim.org/)
  In case I break NeoVim while tinkering with the config files. 
  
### [zathura](https://pwmt.org/projects/zathura/)
  Minimalist and efficient document reader.
  
### [zsh](https://www.zsh.org/)
  With nothing on it other than [powerlevel10k](https://github.com/romkatv/powerlevel10k) (you don't need `oh-my-zsh`, like, trust me bro)
