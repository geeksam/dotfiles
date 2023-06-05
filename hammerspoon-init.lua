meh   = {"ctrl", "alt", "shift"}
mash  = {"ctrl", "alt", "cmd"}
hyper = {"ctrl", "alt", "shift", "cmd"}

function focus_app(app_identifier)
  return function()
    hs.application.launchOrFocus(app_identifier)
  end
end

function open_folder(path)
  return function()
    local _cmd = "open " .. path
    hs.execute(_cmd)
  end
end

function hermes_cmd(cmd)
  return function()
    local _cmd = 'tell application "Hermes" to ' .. cmd
    hs.applescript.applescript(_cmd)
  end
end

-- Pandora/Hermes
-- On the Mac KB, F7=rewind, F8=play/pause, F9=next
-- Since Pandora doesn't do rewind, F7 seems appropriate for activating the app
-- (plus then I don't have to waffle over assigning 'P' or 'H', lol)
hs.hotkey.bind( meh, "F7", focus_app("Hermes") )
hs.hotkey.bind( meh, "F8", hermes_cmd("playpause") )
hs.hotkey.bind( meh, "F9", hermes_cmd("next song") )

-- GIFs
hs.hotkey.bind( meh, "g", open_folder("~/Dropbox/GIFs") )

-- Apps
hs.hotkey.bind( meh, "c", focus_app("Google Chrome") )
hs.hotkey.bind( meh, "d", focus_app("Dash") )
hs.hotkey.bind( meh, "f", focus_app("Finder") )
hs.hotkey.bind( meh, "h", focus_app("Hammerspoon") )
hs.hotkey.bind( meh, "k", focus_app("Ergodox EZ Configurator") )
hs.hotkey.bind( meh, "m", focus_app("TextMate") )
hs.hotkey.bind( meh, "s", focus_app("Slack") )
hs.hotkey.bind( meh, "t", focus_app("iTerm") )
hs.hotkey.bind( meh, "v", focus_app("MacVim") )          -- TODO: make this cycle instances if active
hs.hotkey.bind( meh, "x", focus_app("Camera Settings") ) -- X is next to Z?  ¯\_(ツ)_/¯
hs.hotkey.bind( meh, "z", focus_app("Zoom.us") )



-- from the 'getting started' documentation:
--
-- hs.hotkey.bind(meh, "S", function()
--   hs.alert.show("Hello, world!")
--   hs.notify.new({title="Hammerspoon", informativeText="Hello, world!"}):send()
-- end)
--
-- hs.loadSpoon("AClock")
-- spoon.AClock:init()
-- hs.hotkey.bind(meh, "C", function()
--   spoon.AClock:toggleShow()
-- end)

