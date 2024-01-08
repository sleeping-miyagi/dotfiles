#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1 (keep on top)
export PS1="\[\033[1;38;5;2m\]\u@\h\[\033[0m\]:\[\033[1;38;5;4m\]\w\[\033[0m\]$ "

# nnn config

## cd on quit (https://github.com/jarun/nnn/blob/master/misc/quitcd/quitcd.bash_sh_zsh)

n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn -red "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
}

nnn_cd()                                                                                                   
{
    if ! [ -z "$NNN_PIPE" ]; then
        printf "%s\0" "0c${PWD}" > "${NNN_PIPE}" !&
    fi  
}

trap nnn_cd EXIT


## shell depth indicator (https://github.com/jarun/nnn/wiki/Basic-use-cases#shell-depth-indicator)

[ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"

## plugins

export NNN_PLUG="u:getplugs;m:nmount;c:fixname;x:xdgdefault"

# environment variables

export EDITOR="vim"
export BROWSER="chromium"

# aliases

alias q="exit"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias todo='vim ~/documents/todo'
alias draft="vim /tmp/draft.md"

# run pfetch
PF_INFO="ascii title os kernel uptime pkgs shell wm" pfetch


