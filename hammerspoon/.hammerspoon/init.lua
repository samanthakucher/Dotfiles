-- Hammerspoon configuration.

local appfinder = require "hs.appfinder"
local hints = require "hs.hints"

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


