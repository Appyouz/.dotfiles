alias ls='ls --color=auto'
alias nv='nvim'
alias push='git push -u origin main'
alias lf='lf-ueberzug'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias lf='lf-ueberzug'
alias spd='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3'





# PATH="$HOME/.local/bin${PATH:+:${PATH}}"

# export CC=gcc-11 CXX=g++-11
export TERM="xterm-256color"                      # getting proper colors

export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export XINITRC="$HOME/.xinitrc"
export PATH=$PATH:$HOME/.local/bin



export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"


# [[ -f ~/.config/zsh ]] && . ~/.config/zsh
# [ -z "$DISPLAY" ] && [ $XDG_VTNR -eq 1 ] && exec startx
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
