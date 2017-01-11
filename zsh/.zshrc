zmodload zsh/zprof
# run 'zprof' to profile

##############################################################################
# Antigen setup
# source /usr/local/share/antigen/antigen.zsh
# antigen use oh-my-zsh

# Antigen Bundles
# antigen bundle git
# antigen bundle zsh-users/zsh-syntax-highlighting
# antigen bundle zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh

# Theme
# antigen theme pure

# Apply requests
# antigen apply
##############################################################################

# autoload -Uz compinit
# autoload -Uz compaudit

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="sorin"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git osx common-aliases python sudo history-substring-search vi-mode wd)

# PJC configuration
export PATH="//anaconda/bin:$PATH"

# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
source $HOME/.aliases 

unsetopt correct_all
setopt correct

# vim mode
bindkey -v

# To compile with gcc-4.9 from homebrew
# used in compiling libeemd
export PATH="/usr/local/bin:$PATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

source /Users/pablo/.iterm2_shell_integration.zsh

export SHELL="/usr/local/bin/zsh"

export PATH="$PATH:$HOME/bins"

# for using MATLAB in jupyter notebooks
export MATLAB_EXECUTABLE=/Applications/MATLAB_R2014b.app/bin/matlab

# Search backwards and forwards with a pattern (matlab-like)
# using oh-my-zsh history-substring-search plugin
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# The following line allows for mouse navigation in lnav
# (experimental feature)
# export LNAV_EXP='mouse'

# The following makes it possible to pipe ls colors to any CLI command
export CLICOLOR_FORCE=1

# For Base16 by Chris Kempson
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Redefine configuration variables for history-substring-search zsh plugin
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=,fg=blue,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=,fg=red,bold'
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

# Quick change to command mode (on vi-mode) when pressing ESC
export KEYTIMEOUT=1

# For using tmuxifier
# export PATH="$HOME/.tmuxifier/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $ZSH/oh-my-zsh.sh

base16_onedark


