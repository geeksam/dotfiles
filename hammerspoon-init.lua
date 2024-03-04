--[[

Hammerspoon docs:  http://www.hammerspoon.org/docs/
Hammerspoon 'Getting Started' guide:  https://www.hammerspoon.org/go/

A few quick snippets:

  Hammerspoon popup alert:
    hs.alert.show("Hello, world!")

  MacOS notification:
    hs.notify.new({title="Hammerspoon", informativeText="Hello, world!"}):send()

  Using a spoon:
    hs.loadSpoon("AClock")
    spoon.AClock:init()
    hs.hotkey.bind(meh, "c", function() spoon.AClock:toggleShow() end)

TODO list:

* turn bluetooth back on (e.g., after sleep)
  * https://github.com/toy/blueutil

* consider moving window management out of Moom and into here
  * http://www.hammerspoon.org/docs/hs.screen.html
  * https://livingissodear.com/posts/using-hammerspoon-for-window-management/

--]]

meh   = {"ctrl", "alt", "shift"}
mash  = {"ctrl", "alt", "cmd"}
hyper = {"ctrl", "alt", "shift", "cmd"}



function focus_app(app_identifier, all_windows)
  return function()
    hs.application.launchOrFocus(app_identifier)
    if all_windows then
      hs.application(app_identifier):selectMenuItem { "Window", "Bring All to Front" }
    end
  end
end

function hermes_cmd(cmd)
  return function()
    local _cmd = 'tell application "Hermes" to ' .. cmd
    hs.applescript.applescript(_cmd)
  end
end

function open_folder(path)
  return function()
    local _cmd = "open " .. path
    hs.execute(_cmd)
  end
end

function shell_cmd(cmd)
  return function()
    hs.alert.show(cmd)
    hs.execute(cmd)
  end
end



-- Pandora/Hermes
-- On the Mac KB, F7=rewind, F8=play/pause, F9=next
-- Since Pandora doesn't do rewind, F7 seems appropriate for activating the app
-- (plus then I don't have to waffle over assigning 'P' or 'H', lol)
hs.hotkey.bind( meh, "F7", focus_app("Hermes") )
hs.hotkey.bind( meh, "F8", hermes_cmd("playpause") )
hs.hotkey.bind( meh, "F9", hermes_cmd("next song") )

-- turn bluetooth on (necessitated by work security policy)
-- (doesn't actually work tho?)
-- hs.hotkey.bind( meh, "a", shell_cmd("blueutil -p 0") )
-- hs.hotkey.bind( meh, "b", shell_cmd("blueutil -p 1") )

hs.hotkey.bind( meh, "c", focus_app("Google Chrome") )
hs.hotkey.bind( meh, "d", focus_app("Dash") )
hs.hotkey.bind( meh, "f", focus_app("Finder") )
hs.hotkey.bind( meh, "g", open_folder("~/Dropbox/GIFs") )
hs.hotkey.bind( meh, "h", focus_app("Hammerspoon") )
hs.hotkey.bind( meh, "k", focus_app("Ergodox EZ Configurator") )
hs.hotkey.bind( meh, "m", focus_app("TextMate") )
hs.hotkey.bind( meh, "p", focus_app("1Password") )
hs.hotkey.bind( meh, "s", focus_app("Slack", true) )
hs.hotkey.bind( meh, "t", focus_app("iTerm") )
hs.hotkey.bind( meh, "v", focus_app("MacVim") ) -- TODO: cycle instances? https://www.hammerspoon.org/Spoons/AppWindowSwitcher.html
hs.hotkey.bind( meh, "w", focus_app("Safari") )
hs.hotkey.bind( meh, "x", focus_app("Camera Settings") ) -- X is next to Z?  ¯\_(ツ)_/¯
hs.hotkey.bind( meh, "z", focus_app("Zoom.us", true) )



-- preload a few things so they don't clutter up the console when a hotkey is invoked
hs.application()
hs.window()
