# Use TextMate, thank you;
export EDITOR='mate -w'

# Include stuff
source ~/command_line_fu/path
source ~/command_line_fu/aliases
if [ -f ~/command_line_fu/private_aliases ]; then
	source ~/command_line_fu/private_aliases
fi
source ~/command_line_fu/completion
source ~/command_line_fu/history_sharing

# Prompt
export PS1="\n[ \@ :: \w\$(__git_ps1 ' :: %s') :: rvm: (\$(~/.rvm/bin/rvm-prompt)) ]\n$ "
