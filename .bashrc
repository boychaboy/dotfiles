# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

 #Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

alias dotman="/home1/irteam/dot/dotman/dotman.sh"

export DOT_DEST="dot"
export DOT_REPO="git@github.com:boychaboy/dotfiles"
