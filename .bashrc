# Brandon's .dotfiles Bash Configuration
#
DOTFILES_REPO_PATH=$(dirname -- "$(readlink "${BASH_SOURCE[0]}")")

# Bash Prompt
if [[ -f "${DOTFILES_REPO_PATH}/.bash_prompt" ]]; then
	source "${DOTFILES_REPO_PATH}/.bash_prompt"
fi

# Environment Variables
if [ -f "${DOTFILES_REPO_PATH}/.bash_vars" ]; then
	source "${DOTFILES_REPO_PATH}/.bash_vars"
fi

# Aliases
if [ -f "${DOTFILES_REPO_PATH}/.bash_aliases" ]; then
	source "${DOTFILES_REPO_PATH}/.bash_aliases"
fi

# Completion
if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

export HISTSIZE=2000
export HISTCONTROL=erasedups
export HISTIGNORE="ls:ll:cd:vim"

export EDITOR=vim
export GPG_TTY=`tty`

# configure man page highlighting
export MANPAGER=less
export LESS_TERMCAP_us=$'\e[4;1;36m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_me=$'\e[0m'
export GROFF_NO_SGR=1

# Open Vim right NOW (F1 function key)
bind -x '"OP":"vim"'
