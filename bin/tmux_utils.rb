#!/usr/bin/env ruby

module TmuxUtils
  extend self

  class OutOfWindows < StandardError ; end

  def next_n_adjacent_windows(n)
    windows_in_use = `tmux list-windows`.lines.map(&:to_i)

    start_after = ->(start) {
      a = start + 1
      b = start + n
      (a..b).to_a
    }

    # Start from the beginning (if I have [1,2,9], give me [3,4])
    windows_in_use.each_cons(2) do |a,b|
      gap = b - a - 1
      return start_after.(a) if gap >= n
    end

    # If that failed, and there's room, put them at the end
    last = windows_in_use.max
    if last + n - 1 < 9
      return start_after.(last)
    end

    # Out of single-digit windows? Silly human. Take a break.
    raise OutOfWindows, <<-EOF
      Unable to locate n adjacent windows. (In use: #{windows_in_use.inspect})
      Reminder: humans don't multitask well. Step away from the computer.
    EOF
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

  def window_numbers
    `tmux list-windows`.lines.map { |line| line.split(":", 2).first.to_i }.sort
  end

  # TODO: make this less janky (yeah, right)
  def last_window_number
    `tmux last-window` # ugh
    n = TmuxUtils.active_window_number
    `tmux last-window` # ugh
    n
  end

  def active_window_number
    active_line = `tmux list-windows`.lines.detect { |line| line =~ / \(active\)/ }
    raise 'wtf' if active_line.nil?
    active_line.split(":", 2).first.to_i
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

  SWAP_OFFSET = 100
  def swap_windows(a, b)
    x = a + SWAP_OFFSET
    move_window from: a, to: x
    move_window from: b, to: a
    move_window from: x, to: b
  end

  def move_window(from:, to:)
    tmux_run %Q( move-window -s #{from} -t #{to} )
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
end
