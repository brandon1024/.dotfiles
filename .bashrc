# Brandon's .dotfiles Bash Configuration
#
# - if you want to use pureline, be sure to install powerline-fonts
DOTFILES_REPO_PATH=$(dirname -- "$(readlink "${BASH_SOURCE[0]}")")
DOTFILES_REPO_PURELINE_MODULE="${DOTFILES_REPO_PATH}/pureline"

# Pureline
if [[ -f "${DOTFILES_REPO_PURELINE_MODULE}/pureline" ]]; then
	source "${DOTFILES_REPO_PURELINE_MODULE}/pureline" "${DOTFILES_REPO_PATH}/.pureline.conf"
fi

# Environment Variables
if [ -f "${DOTFILES_REPO_PATH}/.bash_vars" ]; then
	source "${DOTFILES_REPO_PATH}/.bash_vars"
fi

# Aliases
if [ -f "${DOTFILES_REPO_PATH}/.bash_aliases" ]; then
	source "${DOTFILES_REPO_PATH}/.bash_aliases"
fi

export GPG_TTY=$(tty)

