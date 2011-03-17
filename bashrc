# Use TextMate, thank you;
export EDITOR='mate -w'

# Include stuff
source ~/command_line_fu/path
source ~/command_line_fu/aliases
source ~/command_line_fu/completion
source ~/command_line_fu/history_sharing

# Prompt
export PS1="\n[ \@ :: \w\$(__git_ps1 ' :: %s') ]\n$ "
