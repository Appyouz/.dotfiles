alias ls='ls --color=auto'
alias nv='nvim'
alias push='git push -u origin main'
alias lf='lf-ueberzug'

# PATH="$HOME/.local/bin${PATH:+:${PATH}}"

export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export XINITRC="$HOME/.xinitrc"
export PATH=$PATH:$HOME/.local/bin

# [[ -f ~/.config/zsh ]] && . ~/.config/zsh
# [ -z "$DISPLAY" ] && [ $XDG_VTNR -eq 1 ] && exec startx
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
