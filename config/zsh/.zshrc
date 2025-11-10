# fzf integration
source <(fzf --zsh)

# zsh plugins
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# Zoxide as a replacement to cd
eval "$(zoxide init --cmd cd zsh)"

# Manage SSH sessions through keychain
eval $(keychain -q --eval $HOME/personal/auth/ssh/github)

# Activate mise-en-place
eval "$(mise activate zsh)"

# starship prompt
eval "$(starship init zsh)"

# fzf integration

# Proper key mappings (HyperX Alloy Origins 60)
bindkey '^[[3' prefix-2
bindkey '^[[3~' delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

autoload -Uz compinit && compinit

# ----------------------------- ALIASES -----------------------------------
# Base aliases
alias rm="rm -Iv"
alias cp="cp -irv"
alias mv="mv -iv"
alias mkdir="mkdir -pv"
alias vim="nvim"

# Colors
alias diff="diff --color=auto"
alias ip="ip --color=auto"
alias bat="bat --theme='TwoDark' --color=always"

# Terminal tools
alias ls="lsd"
alias la="lsd -A"
alias ll="lsd -l"
alias lla="lsd -la"
alias lt="lsd --tree"
alias vim="nvim -u NONE"
alias lzd="oxker"

# Go aliases
alias gotst="go test -v -cover ./..."

# Wezterm image viewer
alias see="wezterm imgcat"

alias fix-mirrors="sudo reflector -c BR,CL,MX,US --protocol https --sort score --latest 10 --save /etc/pacman.d/mirrorlist"

# ------------------------ STARTUP CALLS --------------------------
wezterm imgcat /home/edbar/personal/Pictures/assets/edbar.png

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
