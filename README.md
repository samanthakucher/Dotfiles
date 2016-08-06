Dotfiles 
----

My dot files for:
- bash
- zsh
- oh my zsh!
- tmux
- tmuxinator
- vim
- htop
- inputrc
- matplotlib
- jupyter (former known as ipython notebook)
- less
- hammerspoon 

## Requirements

Only GNU `stow` is required to manage this dotfiles repo.

## Usage

    git clone https://github.com/pablocobelli/Dotfiles.git
    cd Dotfiles
    stow bash
    stow zsh
    ...
    stow vim

## Usage for particular dotfiles

### .config

The `.config` holds a github submodule, `base16-shell`. So, in this case,
the installation steps are:

    git clone https://github.com/pablocobelli/Dotfiles.git
    cd Dotfiles
    git submodule init
    git submodule update

and only after that we can issue

    stow config

## To remove configurations

The best usage case is when one uses stow temporarily, e.g. when using 
someone else's computer or a remote generic one. Then one would `stow`
the proper modules. When leaving, `stow` provides for a quick and nice
way to un-stow those files:

    stow -D bash

to un-stow bash. 

### How to restore iTerm2 preferences

After stowing them, the workflow is as follows. Go to Preferences, General.
Click on "Load preferences from a custom folder or URL". Select the folder
where the settings are (where you stowed them!). Once selected, you can click
on "Save settings to Folder". I can confirm this procedure **does not
overwrite** the settings (as it might seem from the names of the buttons,
etc.). 
