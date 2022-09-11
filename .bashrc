#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
alias ls='ls --color=auto'
alias nv='nvim'

PS1="\[\e[1;36m\]\[\033[31m\]\[\033[00m\]\n\w\[\e[1;33m\] \[\e[1;31m\] \[\e[1;37m\] \e[32m\]\[\e[1;37m\] "
# PS1="\[\e[1;36m\]\[\033[31m\]\[\033[00m\]\n\w\[\e[1;37m\] \[\e[1;36m\]\[\e[1;37m\] "
#PS1="\e[00;36m\]┌─[ \e[00;37m\]\T \d \e[00;36m\]]──\e[00;31m\]>\e[00;37m\] \u\e[00;31m\]@\e[00;37m\]\h\n\e[00;36m\]|\n\e[00;36m\]└────\e[00;31m\]> \e[00;37m\]\w \e[00;31m\]\$ \e[01;37m\] "

PATH="$HOME/.local/bin${PATH:+:${PATH}}"
export PATH="$HOME/.dotfiles/bin/:$PATH"
