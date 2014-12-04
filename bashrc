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

# Prompt
alias  long_prompt="export PS1=\"\n[ \@ :: \\w\\\$(__git_ps1 ' :: %s') ]\n$ \""
alias short_prompt="export PS1=\"\n[ \\w\\\$(__git_ps1 ' :: %s') ]\n$ \""
alias  tiny_prompt="export PS1=\"$ \""
long_prompt
