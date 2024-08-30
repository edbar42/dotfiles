# Setting environment variables
export XDG_CONFIG_HOME="$HOME/.config"

# zsh config file path
export ZDOTDIR=$XDG_CONFIG_HOME/zsh/

# Use nvim for everything
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"

# pnpm settings
export PNPM_HOME="/home/edbar/.local/share/pnpm"

export SHELL="/bin/zsh"
export PATH="$PATH:$HOME/.bin:$HOME/go/bin/:$PNPM_HOME"

