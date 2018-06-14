export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/dsa_id"
export SHELL="/usr/local/bin/bash"
# export TERM=xterm

# for using MATLAB in jupyter notebooks
export MATLAB_EXECUTABLE=/Applications/MATLAB_R2014b.app/bin/matlab

# To syntax-hightlight man pages
export PAGER="less"   
# Use colors for less, man, etc.
[[ -f ~/.less_termcap ]] && . ~/.less_termcap

export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting


# Load RVM into a shell session *as a function*
# I disabled it because this takes 0.14 seconds on startup
# it can be loaded afterwards if needed
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

# BASE16 colors
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# In completion, if many files apply, they are listed inmediately
set show-all-if-ambiguous on
# In completion, ignore case
set completion-ignore-case on

# Color at the command line
export CLICOLOR=1

# Source .bash_aliases
if [ -f $HOME/.bash_aliases ]
then
  source $HOME/.bash_aliases
fi

# Timeout for changing vi cmd-ins modes
export KEYTIMEOUT=1

# Junegunn fuzzy-finder (fzf)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# fzf config
#  FZF in a TMUX split of 20 lines height
export FZF_TMUX=1
export FZF_TMUX_HEIGHT=20
#  FZF default options
export FZF_DEFAULT_OPTS='
    --bind alt-j:down,alt-k:up
    --color=16
    --extended
    '
# Redefine fzf default command to ignore 'anaconda' and 'Library' folders
#  so that files in those folders do not get indexed and listed 
#  (those are massive folders where one is not going in through fuzzy finding!
export FZF_DEFAULT_COMMAND='ag -g ""'
# If preview is needed
# export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_OPTS="--preview 'cat {}'"
# Change default CTRL-T command action
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# iTerm2 shell integration IS EVIL
# test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Function for shortening directory in prompt fish-style!
short_pwd() {
    cwd=$(dirs -0 | perl -F/ -ane 'print join( "/", map { $i++ < @F - 1 ?  substr $_,0,1 : $_ } @F)')
    echo -ne $cwd
}
# Function for counting number of files/folders in directory
count_files() {
    nof=$(ls -l | tail -n +2 | grep -v '^d' | wc -l)
    echo -ne $nof
}
count_dirs() {
    nod=$(ls -ltr | grep ^d | wc -l)
    echo -ne $nod
}

# Arrows for history navigation
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# jk for beginning substring history search
bind -m vi-command 'k: history-search-backward'
bind -m vi-command 'j: history-search-forward'

# Indicate vi-mode in bash prompt
bind 'set show-mode-in-prompt on'
bind 'set vi-ins-mode-string \001\e[1m\e[38;5;16m\002>>>\001\e[0m\002'
bind 'set vi-cmd-mode-string \001\e[1m\e[38;5;17m\002<<<\001\e[0m\002'
# \001 = \[ 
# \002 = \]
# these are codes to prevent bash from counting the color as characters on the
# prompt, which eventually lead to errors in wrapping text in long lines 
# (typically, text will overwrite current line)

# ANSI CODES for text formatting
# echo -e "\e[1mbold\e[0m"
# echo -e "\e[3mitalic\e[0m"
# echo -e "\e[4munderline\e[0m"
# echo -e "\e[9mstrikethrough\e[0m"
# echo -e "\e[31mHello World\e[0m"
# echo -e "\x1B[31mHello World\e[0m"

# shopt -s checkwinsize


# PROMPT
PS1=' \[\e[38;5;12m\]$(short_pwd) \[\e[0m\e[0;30m\]$(count_files)f:\[\e[0m\e[0;30m\]$(count_dirs)d\[\e[0m\] \$ '
# PS1=' $(short_pwd) $(count_files)f:$(count_dirs)d \$ '

# Navigate TAB completion in bash
bind '"\t":menu-complete'
# bind '"\t":menu-complete-backward'
# list candidates and completes with first one
bind 'set show-all-if-ambiguous on'
bind 'set completion-query-items 150'
# just lists candidates without completing 
# bind 'set menu-complete-display-prefix on' 

# enables color for tab completion
bind 'set colored-stats on'

# History configuration
export HISTCONTROL=ignoreboth:erasedups

# CD reminder!
# use cd to change to directory and echo the contents of .cd-reminder on screen
reminder_cd() {
    builtin cd "$@" && { [ ! -f .cd-reminder ] || cat .cd-reminder 1>&2; }
}

alias cd=reminder_cd

# ctrl-s for cycling through reverse-i-search
[[ $- == *i* ]] && stty -ixon


export PATH=$PATH:~/bin
export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"

# For using homebrew bash_completion, 
# installed using "brew install bash-completion"
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Disable autocompletion of *.pdf files when calling vim + TAB
# and the same for *.log, *.aux *.ps, *.dvi
#   First we turn on 'Extended Globs'
shopt -s extglob
#   Then we apply the rules
complete -f -X '*.@(pdf|log|aux|ps|dvi)' vim

cdf() {
   local file
   local dir
   file=$(fzf-tmux +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# added by Anaconda3 5.0.1 installer
export PATH="/Users/pablo/anaconda3/bin:$PATH"

# to avoid silly error display when running spyder from command line
export EVENT_NOKQUEUE=1
export PATH="/usr/local/sbin:$PATH"

# set iTerm2 window title to nothing (text between " ")
echo -ne "\033]0;" "\007"

# LEAVE THIS AT THE BOTTOM
# Intelligent use of history through different tmux sessions
# ONLY caveat: press enter (null command) to make it happen on destination
# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# After each command, append to the history file and reread it
# export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
export PROMPT_COMMAND=""
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# For displaying minimal git information on the prompt
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\$(parse_git_branch)$PS1"

# Add extra empty line between commands so clutter is separated from commands
PS1="\n$PS1"

# added by Anaconda3 5.2.0 installer
export PATH="/Users/pablo/anaconda3/bin:$PATH"
