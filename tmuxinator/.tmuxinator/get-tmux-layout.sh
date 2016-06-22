#!/bin/sh 
# Gets tmux current pane layout, useful for tmuxinator config files.
# It outputs it to screen and copies the layout string to the clipboard (MacOS
# only)
# Pablo Cobelli - Oct 2015

tmux list-windows | sed 's/\(^.*layout\)\(.*\)\(] @.*$\)/\2/' 
tmux list-windows | sed 's/\(^.*layout\)\(.*\)\(] @.*$\)/\2/' | pbcopy

