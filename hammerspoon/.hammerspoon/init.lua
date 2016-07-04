-- Hammerspoon configuration.

local appfinder = require "hs.appfinder"
local hints = require "hs.hints"
local window = require "hs.window"
local application = require "hs.application"
local tabs = require "hs.tabs"
require "tprint"

-- Reload configuration using CMD+ALT+CTRL+R.
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Hammerspoon config reloaded.")

-- This shows hints for windows of iTerm2 app.
-- hs.hints.fontName = 'Operator Mono Book'
-- hs.hints.fontSize = '20'
hs.hints.showTitleThresh = 0
hs.hints.hintChars = {'F', 'J', 'D', 'S', 'T', 'U'}
hs.hotkey.bind({"cmd"},"k", function() hints.windowHints(appfinder.appFromName("iTerm2"):allWindows()) end)

-- Ideas:
-- 1) bring all python figure windows to front
-- 2) toggle safari to front or back (for quick search for help)
--

-- Activates python figure windows
hs.hotkey.bind({"cmd"}, "U", function()
  pythonapp = application.get'python'
  -- print(pythonapp:title())
  pythonapp:unhide()
  pythonapp:activate(1)
end)

-- This opens a new window IF iTerm2 is already open...
--   we need to open a new instance if it is not (to do!)
--   something along the lines of:
--   hs.application.launchOrFocus("iterm")
--   first, probably (?)
hs.hotkey.bind({"cmd"}, "return", function()
  application.launchOrFocus("iTerm")
  itermapp = appfinder.appFromName("iTerm2")
  itermapp:selectMenuItem({"Shell","New Window"})
end)


hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  win:setFrame(f)
end)

