# fzf options
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

# Proper key mappings (HyperX Alloy Origins 60)
bindkey '^[[3' prefix-2
bindkey '^[[3~' delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# enables native autocomplete
autoload -U compinit; compinit

# ----------------------------- ALIASES -----------------------------------
# Useful aliases
alias rm="rm -Iv" 
alias cp="cp -irv" 
alias mv="mv -iv" 
alias mkdir="mkdir -pv"
alias less="less -N"
alias lzd="lazydocker"

# Colors in output
alias diff="diff --color=auto"
alias ip="ip -color=auto"
alias bat="bat --theme='TwoDark' --color=always"

# Moves to non-default terminal utils
alias ls="lsd"
alias la="lsd -A"
alias ll="lsd -l"
alias lt="lsd --tree"
alias lla="lsd -la"
alias procs="procs --tree"
alias vim="nvim -u NONE"
alias bc="better-commits"

# Go aliases
alias gotst="go test -v -cover ./..."

# Wezterm aliases
alias see="wezterm imgcat"

# Fix mirrors in EndeavourOS
alias fix-mirrors="sudo reflector -c BR,CL,MX,US --protocol https --sort score --latest 10 --save /etc/pacman.d/mirrorlist"

# ------------------------ ADDITIONAL PROGRAMS --------------------------
# Better vim mode for zsh
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# Zoxide as a replacement to cd
eval "$(zoxide init --cmd cd zsh)"

# Manage SSH sessions through keychain
eval $(keychain -q --eval --agents ssh $HOME/personal/auth/ssh/github)

# Activate mise-en-place
eval "$(mise activate zsh)"

# starship prompt
eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/home/edbar/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
