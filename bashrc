export EDITOR='vim'

# Include stuff
if [ -f ~/dotfiles/private/bashrc ]; then
  source ~/dotfiles/private/bashrc
fi

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

source ~/dotfiles/bash/git-completion.bash
source ~/dotfiles/bash/git-prompt.sh
source ~/dotfiles/bash/history_sharing.bash
source ~/dotfiles/bash/js-fu.bash
source ~/dotfiles/bash/kubernetes-fu.bash
source ~/dotfiles/bash/macos_notifications.bash
source ~/dotfiles/bash/misc-fu.bash

source ~/dotfiles/bash/aliases.bash


# Homebrew
# NB: as of 2023, homebrew uses different prefixes on different platforms.
# This may change again in future.
# - /usr/local for Intel/Rosetta stuff
# - /opt/homebrew on Apple CPUs; this may change in future
# HOMEBREW_PREFIX=$(brew --prefix)
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/local/sbin:$PATH"

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
alias  long_prompt="export PS1=\"\n\[\e[30;102m\][ \@ | \\w\\\$(__git_ps1 ' | (git: %s)') ]\[\e[m\]\n$ \""
alias short_prompt="export PS1=\"\n\[\e[30;102m\][ \\w\\\$(__git_ps1 ' | %s') ]\[\e[m\]\n$ \""
alias  tiny_prompt="export PS1=\"$ \""
long_prompt



### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/sam.livingston-gray/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)



# make sure my path stuff is first, period KTHXBYE
source ~/dotfiles/bash/path.bash
