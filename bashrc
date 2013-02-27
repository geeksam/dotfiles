export EDITOR='vim'

# Include stuff
source ~/command_line_fu/bash/path
source ~/command_line_fu/bash/aliases
if [ -f ~/command_line_fu/bash/private_aliases ]; then
	source ~/command_line_fu/bash/private_aliases
fi
source ~/command_line_fu/bash/completion
source ~/command_line_fu/bash/history_sharing
source ~/command_line_fu/bash/ree_gc_settings

# Prompt
alias  long_prompt="export PS1=\"\n[ \@ :: \\w\\\$(__git_ps1 ' :: %s') :: rvm: (\\\$(~/.rvm/bin/rvm-prompt)) ]\n$ \""
alias short_prompt="export PS1=\"\n[ \\w\\\$(__git_ps1 ' :: %s') ]\n$ \""
alias  tiny_prompt="export PS1=\"$ \""
long_prompt
