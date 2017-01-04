# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="$PATH:/usr/local/opt/fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */usr/local/opt/fzf/man* && -d "/usr/local/opt/fzf/man" ]]; then
  export MANPATH="$MANPATH:/usr/local/opt/fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# cdf - cd into the directory of the selected file
cdf() {
    local file
    local dir
    file=$(fzf-tmux +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# Change ctrl-jk to alt-jk in finder, because ctrl-jk are already used by tmux
export FZF_DEFAULT_OPTS='
    --bind alt-j:down,alt-k:up
    --color=16
    '
