export EDITOR='vim'

# Include stuff
source ~/dotfiles/bash/path
source ~/dotfiles/bash/aliases
if [ -f ~/dotfiles/bash/private_aliases ]; then
	source ~/dotfiles/bash/private_aliases
fi
source ~/dotfiles/bash/completion
source ~/dotfiles/bash/history_sharing
source ~/dotfiles/bash/ruby-fu

# Prompt (see http://ezprompt.net for hints)
alias  long_prompt="export PS1=\"\n\[\e[30;102m\][ \@ :: \\w\\\$(__git_ps1 ' :: %s') ]\[\e[m\]\n$ \""
alias short_prompt="export PS1=\"\n\[\e[30;102m\][ \\w\\\$(__git_ps1 ' :: %s') ]\[\e[m\]\n$ \""
alias  tiny_prompt="export PS1=\"$ \""
long_prompt
