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

