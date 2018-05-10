# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export EDITOR=vim


function s {
   subl $@ &
}

function processes {
    px aux | grep $@
}

function move_tax_pdf {
    mv ~/cbdt-*.pdf ~/Dropbox/tax_payments/
    mv ~/tds-*.pdf ~/Dropbox/tax_payments/
}

python_source () {
        cmd="import $1 as a ; print a.__file__.endswith('.pyc') and a.__file__[:-1] or a.__file__"
        file=$(/usr/bin/env python -c $cmd)
        echo $file
        subl $file
}


#alias subl="subl &"
source ~/.local/bin/virtualenvwrapper.sh
export PIP_DOWNLOAD_CACHE=$HOME/.pip_download_cache
export DROPBOX=$HOME/Dropbox
export DOWNLOADS=$HOME/Downloads
export AGILIQ_REPO=$HOME/repos/agiliqdotcom/agiliqdotcom/agiliqcom
export PATH=$PATH:$HOME/bin/android-studio/android-studio/bin
PATH=$PATH:$HOME/bin/android-studio/android-studio/sdk/tools
export ANDROID_HOME=$HOME/bin/android-studio/android-studio

alias today='git log --pretty=format:"%h %s" --since=24hour --branches --no-merges --author=shabda@agiliq.com'
alias pms="python manage.py shell"
alias pmsp="python manage.py shell_plus"
alias pmr="python manage.py runserver"
alias copy_invoices="mv $DOWNLOADS/Invoice-*.pdf $DROPBOX/invoices/"
alias untar="tar -xvzf"
alias e="vim"
alias plz="sudo"
alias open=gnome-open
alias git-ignore="git update-index --assume-unchanged"
alias git-no-ignore="git update-index --no-assume-unchanged"
alias smartgit="~/bin/smartgit/bin/smartgithg.sh &"
alias delete-branch="git branch -d"
alias delete-merged-branches='git branch --merged | egrep -v "(^\*|master|develop)" | xargs git branch -d'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=$PATH:~/bin:/opt/bin
