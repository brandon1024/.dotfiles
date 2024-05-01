# Brandon's .dotfiles Bash Configuration
#
# - if you want to use pureline, be sure to install a powerline-patched font
#   (I recommend nerdfonts SourceCodePro)
DOTFILES_REPO_PATH=$(dirname -- "$(readlink "${BASH_SOURCE[0]}")")
DOTFILES_REPO_PURELINE_MODULE="${DOTFILES_REPO_PATH}/pureline"

# Autojump
if [ -f "/usr/share/autojump/autojump.sh" ]; then
	source "/usr/share/autojump/autojump.sh"
fi

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

