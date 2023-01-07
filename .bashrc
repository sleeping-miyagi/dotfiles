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
export NNN_BMS="b:/mnt/media;d:$HOME/documents;D:$HOME/downloads;h:$HOME;s:$HOME/pictures/screenshots"

# transfer.sh
transfer(){
    if [ $# -eq 0 ];then echo "No arguments specified.\nUsage:\n  transfer <file|directory>\n  ... | transfer <file_name>">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null,;else cat "$file"|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;}

# flac2opus beet import
flac2opus() {
    for file in *.flac; do
        ffmpeg -i "${file}" -b:a 128k -vbr on "${file}".opus
    done
    
    rm *.flac && beet update && beet import .
}

# environment variables
#export TERM=st-256color
export EDITOR=vim
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
alias deploy='rsync -rvh _public/ lain@maky.me:/var/www/maky.me --delete'
alias todo='vim ~/documents/todo.txt'
alias yt='ytfzf -tc yt'
alias yay='paru'
alias bookmarks='vim ~/.local/share/bookmarks'
alias notes='vim ~/documents/notes.md'
alias translate='trans'
