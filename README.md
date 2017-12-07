# Brandon's Dotfiles
Here's where I dump all my config files. Maybe you'll find them useful.

Here's what I have configured so far:
- bash (`.bashrc`, `.bash_aliases`, `.bash_vars`)
- pureline (a powerline alternative)
- vim (`.vimrc`)
- git hooks (`git-hooks/`)
- top (`.toprc`)

![](.gitlab/screenshot.png)


## Prerequisites
There are very few prerequisites.
- GNU Make (available in most environments)
- [powerline patched fonts](https://github.com/powerline/fonts) (if you want to use pureline bash prompt)
- [vim-plug](https://github.com/junegunn/vim-plug) (if you want to use the (few) vim plugins I use)


## Installation (basic)
Simple.

```
$ make
```

This will install all dotfiles by creating symlinks to dotfiles in this project. Existing dotfiles/symlinks are overwritten.


## Installation (customized)
### Install (symlinks, no overwrite)
Avoid overwriting existing dotfiles with symlinks to dotfiles in this project.

```
$ DOTFILES_OVERWRITE=yes make
```

### Install (copy)
Overwrite existing files (if they exist) by coping dotfiles from this project.

```
$ make hard
```

### Install All Except
Pick and choose which dotfiles you want to install.

```
$ # list supported variables with:
$ make help

$ DOTFILES_NO_BASHRC=1 DOTFILES_NO_TMUX=1 make
```

