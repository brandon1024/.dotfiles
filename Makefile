DOTFILES = BASHRC GITCONFIG INPUTRC VIMRC TOPRC TMUXCONF
DOTFILES_BASHRC = .bashrc
DOTFILES_GITCONFIG = .gitconfig
DOTFILES_INPUTRC = .inputrc
DOTFILES_VIMRC = .vimrc
DOTFILES_TOPRC = .toprc
DOTFILES_TMUXCONF = .tmux.conf

DOTFILES_TO_INSTALL = $(foreach file, $(DOTFILES), $(if $(DOTFILES_NO_$(file)),,$(DOTFILES_$(file))))


.PHONY: soft
soft:
	@for file in $(DOTFILES_TO_INSTALL); do \
		ln -s $(if $(DOTFILES_NO_OVERWRITE),,-f) $(shell pwd)/$${file} $${HOME}/$${file}; \
	done

.PHONY: hard
hard:
	@for file in $(DOTFILES_TO_INSTALL); do \
		cp $(shell pwd)/$${file} $${HOME}/$${file}; \
	done

.PHONY: help
help:
	@echo 'The following are some valid targets for this Makefile:'
	@echo ' >>> soft: [default] soft install of dotfiles and scripts (symbolic links)'
	@echo ' >>> hard: hard install of dotfiles and scripts (copy)'
	@echo ' >>> help: display targets'
	@echo ''
	@echo 'To disable installation of a particular dotfile, define one or more'
	@echo 'of the following variables:'
	@for file in $(DOTFILES); do \
		echo "- DOTFILES_NO_$${file}"; \
	done

