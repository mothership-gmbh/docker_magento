# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

alias p='cd /var/www/share/dev/htdocs'
alias m='cd /var/www/share/dev/htdocs/www'
alias t='cd /tmp'
alias search='grep -rnw -C 100 . -e'
alias ..='cd ..'
alias ll='ls -lisah'
alias h='history'
alias hg='history |grep'
alias ports='netstat -tulanp'
export EDITOR='vim'
alias cl='rm -rf /var/www/share/dev/htdocs/www/var/cache/* && magerun cache:clean && varnishadm "ban.url ."'