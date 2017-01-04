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
- khd

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

## Using GNU Stow to manage your dotfiles

I'll describe how to manage the various configuration files in your OSX home directory (aka "dotfiles" like .bashrc) using GNU Stow.

The procedure is simple. I created the ${HOME}/Dotfiles directory and then inside it I made subdirectories for all the programs whose cofigurations I wanted to manage. Inside each of those directories, I moved in all the appropriate files, maintaining the directory structure of my home directory. So, if a file normally resides at the top level of your home directory, it would go into the top level of the program's subdirectory. If a file normally goes in the default ${XDG_CONFIG_HOME}/${PKGNAME} location (${HOME}/.config/${PKGNAME}), then it would instead go in ${HOME}/dotfiles/${PKGNAME}/.config/${PKGNAME} and so on. Finally, from the dotfiles directory, you just run $ stow $PKGNAME and Stow will symlink all the package's configuration files to the appropriate locations. It's then easy to make the dotfiles a VCS repository so you can keep track of changes you make (plus it makes it so much easier to share configurations between different computers, which was my main reason to do it).

For example, let's say you want to manage the configuration for Bash, VIM and Uzbl. Bash has a couple files in the top-level directory; VIM typically has your .vimrc file on the top-level and a .vim directory; and Uzbl has files in ${XDG_CONFIG_HOME}/uzbl and ${XDG_DATA_HOME}/uzbl. So, your home directory looks like this:

    home/
    brandon/
        .config/
            uzbl/
                [...some files]
        .local/
            share/
                uzbl/
                    [...some files]
        .vim/
            [...some files]
        .bashrc
        .bash_profile
        .bash_logout
        .vimrc

You would then create a dotfiles subdirectory and move all the files there:

    home/
        /brandon/
            .config/
            .local/
                .share/
            dotfiles/
                bash/
                    .bashrc
                    .bash_profile
                    .bash_logout
                uzbl/
                    .config/
                        uzbl/
                            [...some files]
                    .local/
                        share/
                            uzbl/
                                [...some files]
                vim/
                    .vim/
                        [...some files]
                    .vimrc

Then, perform the following commands:

    $ cd ~/dotfiles
    $ stow bash
    $ stow uzbl
    $ stow vim

And, voila, all your config files (well, symbolic links to them) are all in the correct place, however disorganized that might be, while the actual files are all neatly organized in your dotfiles directory, which is easily turned into a VCS repo. One handy thing is that if you use multiple computers, which may not have the same software installed on them, you can pick and choose which configurations to install when you need them. All of your dotfiles are always available in your dotfiles directory, but if you don't need the configuration for one program, you simply don't Stow it and thus it does not clutter your home directory.

