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
hs.alert.show("Hammerspoon config loaded.")

-- This shows hints for windows of iTerm2 app.
hs.hints.showTitleThresh = 0
hs.hints.hintChars = {'F', 'J', 'D', 'S', 'T', 'U'}
-- The following works in general but fails on iTerm2 windows without title bar
-- hs.hotkey.bind({"cmd"},"k", function() hints.windowHints(appfinder.appFromName("iTerm2"):allWindows()) end)
function giveFocusToNonStandardWindow (selectedWindow)
    -- The following :raise():focus() thing was suggested by user Ng
    --   on the irc.freenode.net 8001 #hammerspoon channel
    selectedWindow:raise():focus()
end
hs.hotkey.bind({"cmd"},"k", function() 
    -- itermapp = application.find('iTerm2')
    -- print(itermapp)
    -- itermwins = itermapp:allWindows()
    -- print(itermwins)
    -- hints.windowHints(itermapp:allWindows()) 
    -- hints.windowHints(itermwins, nil, 1)
    -- Interesting, this works for all windows, regardless if iTerm2 or not!:
    hints.windowHints(nil, giveFocusToNonStandardWindow, 1)
    -- hints.windowHints(itermwins, giveFocusToNonStandardWindow, 1)
end)
-- Solution:
-- define a function in Lua, windowHints' second argument function 
-- will take the hs.window object of the window chosen by the user!



-- Ideas:
-- 1) bring all python figure windows to front
-- 2) toggle safari to front or back (for quick search for help)

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


hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", function()
  hs.execute("brew services restart kwm")
  hs.alert.show("kwm restarted.")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  win:setFrame(f)
end)

