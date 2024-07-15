# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/richard/.zshrc'
zstyle ':completion:*' menu select

autoload -Uz compinit
compinit
# End of lines added by compinstall
# === ALIASES ===
alias vi="nvim"
alias vim="nvim"
alias ls="ls --color=auto --group-directories-first"
alias la="ls -a"
alias bup="brightnessctl set +5% -e"
alias bdown="brightnessctl set 5%- -e"
alias i3conf="nvim ~/.config/i3/config"
alias zshconf="nvim ~/.zshrc"
alias spt="spotify_player"
alias -s txt=nvim
# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
