DOTFILES = BASHRC GITCONFIG INPUTRC VIMRC VIM_PLUGINS TOPRC TMUXCONF
DOTFILES_BASHRC = .bashrc
DOTFILES_GITCONFIG = .gitconfig
DOTFILES_INPUTRC = .inputrc
DOTFILES_VIMRC = .vimrc
DOTFILES_VIM_PLUGINS = .vim/pack
DOTFILES_TOPRC = .toprc
DOTFILES_TMUXCONF = .tmux.conf

DOTFILES_TO_INSTALL = $(foreach file, $(DOTFILES), $(if $(DOTFILES_NO_$(file)),,$(DOTFILES_$(file))))

.PHONY: soft
soft:
	@for file in $(DOTFILES_TO_INSTALL); do \
		$(if $(DOTFILES_DRYRUN),echo) ln -s -n $(if $(DOTFILES_NO_OVERWRITE),,-f) $(shell pwd)/$${file} $${HOME}/$${file}; \
	done

.PHONY: hard
hard:
	@for file in $(DOTFILES_TO_INSTALL); do \
		$(if $(DOTFILES_DRYRUN),echo) cp -r $(shell pwd)/$${file} $${HOME}/$${file}; \
	done

.PHONY: help
help:
	@echo 'The following are some valid targets for this Makefile:'
	@echo ' >>> soft: [default] soft install of dotfiles and scripts (symbolic links)'
	@echo ' >>> hard: hard install of dotfiles and scripts (copy)'
	@echo ' >>> help: display targets'
	@echo ''
	@echo 'To see what will be installed, set DOTFILES_DRYRUN=1.'
	@echo ''
	@echo 'To disable installation of a particular dotfile, define one or more'
	@echo 'of the following variables:'
	@for file in $(DOTFILES); do \
		echo "- DOTFILES_NO_$${file}"; \
	done

