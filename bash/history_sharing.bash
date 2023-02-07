export HISTCONTROL=erasedups    # no duplicate entries
export HISTSIZE=10000           # big history
shopt -s histappend             # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -r; $PROMPT_COMMAND"
