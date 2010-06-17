# Include stuff
source ~/command_line_fu/environment_variables
source ~/command_line_fu/path
source ~/command_line_fu/aliases
source ~/command_line_fu/completion
source ~/command_line_fu/history_sharing

# Prompt
export PS1="\n[ \@ :: \w\$(__git_ps1 ' :: %s') ]\n$ "
