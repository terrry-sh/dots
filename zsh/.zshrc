
# If you are not interactive don't run anything below this line
[[ $- != *i* ]] && return

DOTS_DIR="${HOME}/dots"
export PATH="${PATH}:${HOME}/myscripts"

# export LC_ALL=en_IN.UTF-8
# export LANG=en_IN.UTF-8

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

alias gsm="git submodule"

case "$(uname -s)" in
Darwin)
    # BREW STUFF
    if [ -e "/opt/homebrew/bin/brew" ]; then eval "$(/opt/homebrew/bin/brew shellenv)"; fi
    # For NIX - mac defaults to multi-user, uses a daemon
    # This line is placed into bash.bashrc and zsh.zshrc
    # So if the default installation is done this will never need to be run
    # I'll keep it here for reminder
    if [ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then . "${HOME}/.nix-profile/etc/profile.d/nix.sh"; fi
    alias timeout='gtimeout'
    ;;
Linux)
    if [ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then . "${HOME}/.nix-profile/etc/profile.d/nix.sh"; fi
    [[ ! -r /home/ts/.opam/opam-init/init.zsh ]] || source "${HOME}/.opam/opam-init/init.zsh"  > /dev/null 2> /dev/null
    ;;
CYGWIN* | MINGW32* | MSYS* | MINGW*)
    # echo 'MS Windows'
    ;;
*)
    # echo 'Other OS'
    ;;
esac

### PATH is set up now

if ! command -v exa &> /dev/null
then
    echo 'EXA not defined, using ls with color'
    case "$(uname -s)" in

    Darwin)
        # echo 'Mac OS X'
        alias lsal='ls -G -al'
        alias ls='ls -G'
        ;;

    Linux)
        alias lsal='ls --color=auto -al'
        alias ls='ls --color=auto'
        [ -f "/home/ts/.ghcup/env" ] && source "/home/ts/.ghcup/env" # ghcup-env
        ;;

    CYGWIN* | MINGW32* | MSYS* | MINGW*)
        # echo 'MS Windows'
        ;;
    *)
        # echo 'Other OS'
        ;;
    esac
else
    alias lsal='exa --long --color=always --all'
    alias ls='exa --color=always'
fi

if ! command -v zoxide &> /dev/null
then
    #NOOP
else
    eval "$(zoxide init zsh)"
    alias cd='z'
fi


if ! command -v nvim &> /dev/null
then
    echo 'NVIM not defined, using vim'
    export EDITOR='vim'
else
    alias vim='nvim'
    export EDITOR='nvim'
fi


export TERMINAL="alacritty"



# History in cache directory:
export HISTFILESIZE=100000
export HISTSIZE=100000
export SAVEHIST=100000
export HISTTIMEFORMAT="[%F %T] "
HISTFILE=$HOME/.zsh_history


# MAN ZSHOPTIONS to see more
# cd without the need of typing cd
setopt auto_cd nomatch
setopt interactive_comments # enables '#' comments in interactive mode

stty stop undef		# Disable ctrl-s to freeze terminal. -> just annoying

setopt glob_dots # no special treatment for file names with leading dot
setopt no_auto_menu # require an extra TAB press to open the completion menu

# History
# http://zsh.sourceforge.net/Doc/Release/Options.html#History
setopt append_history          # append to history file
setopt extended_history        # write the history file in the ':start:elapsed;command' format
# unsetopt hist_beep             # don't beep when attempting to access a missing history entry
setopt hist_expire_dups_first  # expire a duplicate event first when trimming history
setopt hist_find_no_dups       # don't display a previously found event
setopt hist_ignore_all_dups    # delete an old recorded event if a new event is a duplicate
setopt hist_ignore_dups        # don't record an event that was just recorded again
setopt hist_ignore_space       # don't record an event starting with a space
setopt hist_no_store           # don't store history commands
setopt hist_reduce_blanks      # remove superfluous blanks from each command line being added to the history list
setopt hist_save_no_dups       # don't write a duplicate event to the history file
setopt hist_verify             # don't execute immediately upon history expansion
setopt inc_append_history      # write to the history file immediately, not when the shell exits
unsetopt share_history         # don't share history between all sessions

# vi mode
# bindkey -v
# The time the shell waits, in hundredths of seconds, for another key to be pressed when reading bound multi-character sequences.
# Default is 0.4 seconds, your escape press will take forever to register since it will wait for escape
# export KEYTIMEOUT=1

autoload -Uz compinit
zstyle ':completion:*' menu select

    ## I have no idea what this line does so not including it
    #'r:|[._-]=* r:|=*'
    ## This line matches backwards and forwards
zstyle ':completion:*' matcher-list '' '+m:{a-zA-Z}={A-Za-z}' \
    '+l:|=* r:|=*'


zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line

## CONTROL V for VIM
bindkey '^e' edit-command-line


source "${DOTS_DIR}/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2>/dev/null

## Not autocomplete
## For the grey suggestions
source "${DOTS_DIR}/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null




## Doing prompt stuff here:
# Let's have some colors first
autoload -U colors && colors

## SEE here https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
autoload -Uz vcs_info


# enable only git
zstyle ':vcs_info:*' enable git

# # Check the repository for changes so they can be used in %u/%c (see
# # below). This comes with a speed penalty for bigger repositories.
# zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:*' get-revision true

#Alternatively, the following would set only %c, but is faster:
zstyle ':vcs_info:*' check-for-changes false
zstyle ':vcs_info:*' check-for-staged-changes true

# git:
zstyle ':vcs_info:git:*' formats '(%b)' # just branch

# tmux changes
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'


# Episode III: "The justsetitinprecmd way"
# This is the way I prefer. When you see it, you may think "Setting that
# variable in precmd() each time? What a waste..."; but let me assure you,
# you're running vcs_info already, setting one variable is not an issue.
#
# You're getting the benefit of being able to programmatically setting your
# prompt, which is nice especially when you're going to do weird things in
# there anyway. Here goes:
precmd() {
    # As always first run the system so everything is setup correctly.
    vcs_info
    # And then just set PS1, RPS1 and whatever you want to. This $PS1
    # is (as with the other examples above too) just an example of a very
    # basic single-line prompt. See "man zshmisc" for details on how to
    # make this less readable. :-)

    local left_square_bracket="%F{blue}[%f"
    local right_square_bracket="%F{blue}]%f"
    local username="%F{white}%n%f"
    local separator="%F{red}::%f"
    local hostname="%F{white}%M%f"


    # Edit this for showing N paths
    # local currdir="%F{yellow}%(4~|%-1~/…/%2~|%3~)%f"
    local currdir="%F{yellow}%(5~|%-1~/…/%3~|%4~)%f"
    #PS1="%B%{$fg[white]%}%n%{$fg[red]%}@%{$fg[white]%}%M%{$fg[blue]%}] %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$fg[cyan]%}%c%{$reset_color%}"

    if [[ -z ${vcs_info_msg_0_} ]]; then
        # Oh hey, nothing from vcs_info, so we got more space.
        # Let's print a longer part of $PWD...
        #noop
        local git=""
    else
        # vcs_info found something, that needs space. So a shorter $PWD
        # makes sense.
        local git="in %F{cyan}${vcs_info_msg_0_}%f "
    fi

    #TERNARY EXPRESSION
    local jobs="%F{green}%1(j.JOBS=%j .)%f"

    local prompter="%F{magenta}%(!.#.λ)%f"

    PROMPT="%B${left_square_bracket}${username}${separator}${hostname}${right_square_bracket} ${currdir} ${git}${jobs}${prompter}%b "
}


# https://stackoverflow.com/questions/27613209/how-to-automatically-start-tmux-on-ssh-session/43819740#43819740
START_TMUX_SESSION_NAME="start"

__start_default_tmux () {
  tmux attach-session -t $START_TMUX_SESSION_NAME || tmux new-session -s $START_TMUX_SESSION_NAME
}

# automatically start TMUX on SSH
if command -v tmux &> /dev/null && [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
    __start_default_tmux
fi

# disabling this since we want to start normally
# in order to SSh into machines with tmux
# not going to worry about nested tmuxes
# automatically start TMUX
# if command -v tmux &> /dev/null && [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]]; then
#     __start_default_tmux
# fi
