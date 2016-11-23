# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="fishy"
ZSH_THEME="sorin"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

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
plugins=(git osx common-aliases python sudo history-substring-search vi-mode wd autojump)

# PJC configuration
export PATH="//anaconda/bin:$PATH"

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

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
export KEYTIMEOUT=10

# Avoid problems and use Anaconda's path
# export PATH="/anaconda/bin:$PATH"

# For autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# To compile with gcc-4.9 from homebrew
# used in compiling libeemd
export PATH="/usr/local/bin:$PATH"

# This is for Pelican to work with Anaconda Python 3.4
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Defining function to detect cd to a folder containing
# a README file, and showing it on the terminal.
function chpwd {
  if [[ -e README.DIR ]]; then
      echo
      echo \* Folder contains README.DIR file that states: \*
      echo
      cat README.DIR
      echo
      echo \* End of README.DIR file. \*
      echo
  fi }

source /Users/pablo/.iterm2_shell_integration.zsh

# export PATH="/Users/pablo/anaconda/bin:$PATH"

# Function definition for Base16
# function light() {
    # export BACKGROUND="light" && reload!
# }

# function dark() {
    # export BACKGROUND="dark" && reload!
# }

# My alias and functions
alias vim='/usr/local/bin/mvim -v'
alias viz='vim ~/.zshrc'
alias vix='vim ~/.tmux.conf'
alias vik='vim ~/.kwm/kwmrc'
alias vih='vim ~/.hammerspoon/init.lua'

## Defining 'sk' as a function to open skim and a pdf if called like:
## sk filename.pdf
sk () { open -a Skim -e $1 & }

# export THEME="base16-paraiso"
# export THEME="base16-eighties"

# if [ -z "$BACKGROUND" ]; then
    # export BACKGROUND="dark"
# fi

# Base16 Shell
# BASE16_SHELL="$HOME/.config/base16-shell/$THEME.$BACKGROUND.sh"
# [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
# source $BASE16_SHELL

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
export LNAV_EXP='mouse'

# Base16 Shell
# BASE16_SHELL="$HOME/.config/base16-shell/base16-eighties.dark.sh"
# [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# The following makes it possible to pipe ls colors to any CLI command
export CLICOLOR_FORCE=1

# Colors for tree
# export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:';

# Call my own python3.5 wrapper to ipython3 (located at ~/bin)
#   The "$@" part passes all arguments given to the wrapper ('ipy3')
ipy3 () {
    ipython3 "$@"
}

scd () {
    # SCD: Sync Change Directory; for use within tmux sessions; 
    # [requires 1 argument, the number of the reference tmux session]
    # Usage:  
    #     scd 60 
    # will change current tmux session pwd to that of session #60.
    # Useful when working with python & editing on the same dir/folder.
    remdir=$(/usr/local/bin/tmux display-message -p -F "#{pane_current_path}" -t "$@")
    cd "$remdir"
}


# For Gruvbox palette
source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"

# Redefine configuration variables for history-substring-search zsh plugin
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=,fg=blue,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=,fg=red,bold'
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

