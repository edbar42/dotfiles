# Dotfiles

### ⚠️ This repository is still under construction. ⚠️

This is where I keep my configs and dotfiles for my linux system. 

At the moment, these are aimed to work for a fresh installation of [EndeavourOS](https://endeavouros.com/) with the [i3](https://i3wm.org/) window manager. 

Since I use [stow](https://www.gnu.org/software/stow/) to handle actually linking my dotfiles to my system, the configuration is stored in a `dot-config` directory with a `dot-zshrc` file outside of that.

# Installation
Once cloned, just run the setup script. Make sure you have execution privileges for it.

```
setup.sh 
```
If you only wish to update the links to your dotfiles, run the script with the `sync` flag.
```
setup.sh sync
```

# Software that I use for these config files:
  
### [NeoVim](https://neovim.io/)
  More than an IDE, a [PDE](https://www.youtube.com/watch?v=QMVIJhC9Veg).

  My config heavily relies on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), an amazing project to get started with configuring NeoVim for your needs.

### [WezTerm](https://wezfurlong.org/wezterm/)
  Because I'm using Lua for nvim anyways.

### [mpv](https://mpv.io/)
  [The based gigachad's video player.](https://www.youtube.com/watch?v=w-g04TLp0tg)

### [yazi](https://yazi-rs.github.io/)
  For all my file managing needs that don't involve click-and-drag.

### [vim](https://www.vim.org/)
  Well, sometimes. This is mostly legacy from before I learned about NeoVim.

### [zathura](https://pwmt.org/projects/zathura/)
  Minimalist and efficient document reader.

### [zsh](https://www.zsh.org/)
  With nothing on it other than [powerlevel10k](https://github.com/romkatv/powerlevel10k).
