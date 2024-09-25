# Enable Powerlevel10k instant prompt. 
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Loads powerlevel10k
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
alias jobs="jobs -p"

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

# OMEGALUL
alias fastfetch="fastfetch --logo arch"

# Go aliases
alias gotst="go test -v"

#pnpm aliases
alias pnpx="pnpm dlx"

# Wezterm aliases
alias see="wezterm imgcat"

# Fix mirrors in EndeavourOS
alias fix-mirrors="sudo reflector -c BR,CL,MX,US --protocol https --sort score --latest 10 --save /etc/pacman.d/mirrorlist"

# ------------------------ ADDITIONAL PROGRAMS --------------------------
# Zoxide as a replacement to cd
eval "$(zoxide init --cmd cd zsh)"

# Manage SSH sessions through keychain
eval $(keychain --eval --agents ssh id_ed25519)

# pnpm
export PNPM_HOME="/home/edbar/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
