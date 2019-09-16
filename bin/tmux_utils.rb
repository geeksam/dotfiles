#!/usr/bin/env ruby

def next_n_adjacent_windows(n)
  windows = `tmux list-windows`.lines.map(&:to_i)

  # Start from the beginning (if I have [1,2,9], give me [3,4])
  windows.each_cons(n) do |i,j|
    if j-i >= n
      return i+1, i+n
    end
  end

  # If that failed, and there's room, put them at the end
  if (i = windows.max) < 9
    return ( (i+1)..(i+n) ).to_a
  end

  # Out of single-digit windows? Silly human. Take a break.
  puts <<-EOF
    Unable to locate n adjacent windows. (In use: #{windows.inspect})
    Reminder: humans don't multitask well. Step away from the computer.
  EOF
  exit
end

def tmux_run(*cmds, debug: false)
  cmds.each do |cmd|
    tmux_cmd = "tmux #{cmd}"
    puts tmux_cmd if debug
    out = `#{tmux_cmd}`
    if $?.exitstatus.zero?
      puts out if debug
    else
      msg = [
        "Command failed: #{tmux_cmd}",
        "Exit status: #{$?.exitstatus}",
        "stdout: #{out}",
      ]
      fail msg.join("\n")
    end
  end
end

def tmux_send_keys(cmd, window, pane=1)
  tmux_run %Q( send-keys -t #{window}.#{pane} "#{cmd}" C-m )
end

def echo(s, window)
  tmux_send_keys "echo #{s}", window
end

def tmux_select(window, pane = nil)
  tmux_run "select-window -t #{window}"
  tmux_run "select-pane -t #{pane}" if pane
end

def tmux_new_window(window, target_dir, label, *cmds)
  # Create and name the window
  label ||= File.basename(target_dir)
  tmux_run %Q( new-window -t #{window} -n "#{label}" )

  # cd into target_dir and clear the screen
  tmux_send_keys "cd #{target_dir}; clear" , window

  # Run any commands given
  cmds.each do |cmd|
    tmux_send_keys cmd, window
  end
end

# tmux's idea of 'vertical' and 'horizontal' are backward from vim's >.<
def tmux_split(along:, percent: 50)
  flag =
    case along.to_sym
    when :| ; "-h"
    when :- ; "-v"
    end
  cmd = %q( split-window %s -p %d ) % [ flag, percent ]

  tmux_run cmd
end

def tmux_select_pane(n)
  tmux_run "select-pane -t #{n}"
end
