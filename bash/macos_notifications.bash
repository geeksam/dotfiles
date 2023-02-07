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

