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

# Open Vim right NOW
bind -x '"OP":"vim"'
