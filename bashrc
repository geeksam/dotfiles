export EDITOR='vim'

# Include stuff
source ~/dotfiles/bash/path
source ~/dotfiles/bash/aliases
if [ -f ~/dotfiles/private/aliases.bash ]; then
	source ~/dotfiles/private/aliases.bash
fi
source ~/dotfiles/bash/completion
source ~/dotfiles/bash/history_sharing
source ~/dotfiles/bash/ruby-fu
source ~/dotfiles/bash/twitter-gif-tools.bash

# Notification for long-running processes
function _sys_notify_status() {
  local notification_command="display notification \"That thing you asked for is done.\" with title \"$1\""
  osascript -e "$notification_command"
  # NOTE: if you want a 'close' button, change 'Script Editor' to
  # use alerts in System Preferences -> Notifications.
}
function holler() {
  if [ "$?" -eq 0 ] ;
  then _sys_notify_status "Succeeded" ; say 'Process Succeeded' ;
  else _sys_notify_status "Failed"    ; say 'Process Failed'    ;
  fi
}

# Prompt (see http://ezprompt.net for hints)
alias  long_prompt="export PS1=\"\n\[\e[30;102m\][ \@ :: \\w\\\$(__git_ps1 ' :: %s') ]\[\e[m\]\n$ \""
alias short_prompt="export PS1=\"\n\[\e[30;102m\][ \\w\\\$(__git_ps1 ' :: %s') ]\[\e[m\]\n$ \""
alias  tiny_prompt="export PS1=\"$ \""
long_prompt

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
