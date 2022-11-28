#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "

# nnn config
## cd on quit (https://github.com/jarun/nnn/wiki/Basic-use-cases#configure-cd-on-quit)
## see also: https://wiki.archlinux.org/title/Nnn
if [ -f /usr/share/nnn/quitcd/quitcd.bash_zsh ]; then
    source /usr/share/nnn/quitcd/quitcd.bash_zsh
fi

## sync subshell $PWD (https://github.com/jarun/nnn/wiki/Basic-use-cases#sync-subshell-pwd)
nnn_cd() {
    if ! [ -z "$NNN_PIPE" ]; then
        printf "%s\0" "0c${PWD}" > "${NNN_PIPE}" !&
    fi  
}

trap nnn_cd EXIT

## shell depth indicator (https://github.com/jarun/nnn/wiki/Basic-use-cases#shell-depth-indicator)
[[ -n "$NNNLVL" ]] && PS1="N$NNNLVL $PS1"

## assign plugins (https://github.com/jarun/nnn/tree/master/plugins#configuration)
export NNN_PLUG='b:renamer;s:subshell;i:imgview;u:buttplug;m:nmount;f:xdgdefault'

## hidden files on top (https://github.com/jarun/nnn/wiki/Basic-use-cases#hidden-files-on-top)
export LC_COLLATE="C"

## enable trash and add bookmarks (https://github.com/jarun/nnn/wiki/Usage)
export NNN_TRASH=1
export NNN_BMS="b:/mnt/media;d:$HOME/documents;D:$HOME/downloads;h:$HOME"

# environment variables
export TERM=st-256color
export EDITOR=vim
#export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.local/bin
export BTPD_HOME=$HOME/.config/btpd
export LIBBY_OUTPUT_DIR=~/documents/library
export BROWSER=firefox
export PATH="${PATH}":$HOME/.local/bin

# aliases
alias btadd='btcli add -d /mnt/media/torrent -T'
alias n='n -redx'
alias N='sudo -E nnn -dH'
alias ls='ls --color=auto'
alias ssgr='rssg src/blog/index.md 'maky.me' > src/blog/rss.xml'
alias ssgm='rm -rf dst/.files dst/* && rssg src/blog/index.md 'maky.me' > src/blog/rss.xml && ssg src dst 'maky.me' 'https://maky.me''
alias ssgd='rsync -rvh dst/ lain@maky.me:/var/www/maky.me --delete'
alias todo='vim ~/documents/todo.txt'
alias tuir='tuir --enable-media'
alias yt='ytfzf -tc yt'
alias sci='scitopdf -D ~/documents/library -u sci-hub.ru'
alias yay='paru'
alias bookmarks='vim ~/.local/share/bookmarks'
