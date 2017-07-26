export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR='vim'

export SSH_KEY_PATH="~/.ssh/dsa_id"

export SHELL="/usr/local/bin/bash"

# for using MATLAB in jupyter notebooks
export MATLAB_EXECUTABLE=/Applications/MATLAB_R2014b.app/bin/matlab

# To syntax-hightlight man pages
export PAGER="less"   
# Use colors for less, man, etc.
[[ -f ~/.less_termcap ]] && . ~/.less_termcap

# added by Anaconda3 2.3.0 installer
export PATH="//anaconda/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
# Load RVM into a shell session *as a function*

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
export FZF_DEFAULT_OPTS='
    --bind alt-j:down,alt-k:up
    --color=16
    '

# Redefine configuration variables for history-substring-search zsh plugin
#  These definitions should go after sourcing oh-my-zsh.sh 
# HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=,fg=blue,bold'
# HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=,fg=red,bold'
# HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Function for shortening directory in prompt fish-style!
short_pwd() {
    cwd=$(dirs -0 | perl -F/ -ane 'print join( "/", map { $i++ < @F - 1 ?  substr $_,0,1 : $_ } @F)')
    echo -n $cwd
}
# Function for counting number of files/folders in directory
count_files() {
    nof=$(ls -l | wc -l)
    echo -n $nof
}
# later in your .bashrc
PS1='\[\033[0;33m\] $(short_pwd)\[\033[0m\] \[\033[0;30m\]$(count_files)\[\033[0m\] \$ '

# Arrows
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# jk for beginning substring history search
bind -m vi-command 'k: history-search-backward'
bind -m vi-command 'j: history-search-forward'

# Indicate vi-mode in bash prompt
bind 'set show-mode-in-prompt on'
bind 'set vi-ins-mode-string >>'
bind 'set vi-cmd-mode-string <<'
