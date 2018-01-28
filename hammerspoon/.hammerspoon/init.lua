-------------------------------------------------------------------------------
-- Hammerspoon configuration
--
-- Keybindings:
--
--  cmd + alt + ctrl + r                reload hammerspoon config
--  cmd              + k                key-hints for changing apps
--  cmd              + U                activates python windows (figures)
--  cmd              + return           opens an iTerm2 instance
--  cmd              + r                opens Reminders app
--              ctrl + return           opens Safari
--  cmd + alt + ctrl + return           toggles app fullscreen (macos style)
--  cmd              + h                Safari only: navigates tabs
--  cmd              + l                Safari only: navigates tabs
--  cmd              + e                iTerm2 only: sends prefix to tmux
--  cmd + alt + ctrl + space            tile 50/50 two last active windows
--                                      is iTerm2 is involved, it goes to right
--
-------------------------------------------------------------------------------

local appfinder = require "hs.appfinder"
local hints = require "hs.hints"
local window = require "hs.window"
local application = require "hs.application"
local tabs = require "hs.tabs"
local tabs = require "hs.screen"
local screen = require "hs.screen"
require "tprint"

already_tiled_windows = {}

-- Reload configuration using CMD+ALT+CTRL+R.
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

-- This shows hints for windows of iTerm2 app.
hs.hints.showTitleThresh = 0
hs.hints.hintChars = {'F', 'J', 'D', 'S', 'T', 'U', 'R', 'E', 'L', 'Q'}
function giveFocusToNonStandardWindow (selectedWindow)
    selectedWindow:raise():focus()
end
hs.hotkey.bind({"cmd"},"k", function() 
    hints.windowHints(nil, giveFocusToNonStandardWindow, 1)
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
  itermapp = appfinder.appFromName("iTerm2")
  if itermapp == nil then
    -- it is not open; open it and focus (that opens a new window & focus it)
    application.open("iTerm2")
    application.launchOrFocus("iTerm2")
  else
    -- application.launchOrFocus("iTerm2")
    itermapp:selectMenuItem({"Shell","New Window"})
  end
end)

hs.hotkey.bind({"cmd"}, "r", function()
  reminderapp = appfinder.appFromName("Reminders")
  if reminderapp == nil then
    -- it is not open; open it and focus (that opens a new window & focus it)
    application.open("Reminders")
    application.launchOrFocus("Reminders")
  else
    application.open("Reminders")
    application.launchOrFocus("Reminders")
  end
end)

hs.hotkey.bind({"ctrl"}, "return", function()
  safariapp = appfinder.appFromName("Safari")
  if safariapp == nil then
    -- it is not open; open it and focus (that opens a new window & focus it)
    application.open("Safari")
    application.launchOrFocus("Safari")
  else
    -- open new window
    safariapp:selectMenuItem({"File","New Window"})
  end
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "return", function()
  local win = hs.window.focusedWindow()
  win:setFullScreen(1)
end)

-- For Safari tab navigation:
-- cmd+h to move to previous tab 
-- cmd+l to move to next tab
hs.hotkey.bind({"cmd"}, "h", function()
  local curr_app = hs.application.frontmostApplication()
  if curr_app:name() == 'Safari' then
    -- Safari es la ventana activa, mover un Tab atras
    hs.eventtap.keyStroke({"ctrl","shift"},"tab")
  else 
    -- Safari NO es la ventana activa
  end
end)
hs.hotkey.bind({"cmd"}, "l", function()
  local curr_app = hs.application.frontmostApplication()
  if curr_app:name() == 'Safari' then
    -- Safari es la ventana activa, mover un Tab adelante
    hs.eventtap.keyStroke({"ctrl"},"tab")
  else 
    -- Safari NO es la ventana activa
  end
end)

-- Para poder usar cmd+e para enviar el prefix de tmux
hs.hotkey.bind({"cmd"}, "e", function()
  local curr_app = hs.application.frontmostApplication()
  if curr_app:name() == 'iTerm2' then
    -- iTerm es la ventana activa, enviar el prefijo 
    hs.eventtap.keyStroke({"ctrl"},"z")
  else 
    -- No hagamos nada
  end
end)

-- Para tomar las 2 ultimas ventanas que estuvieron activas
--   y generar con ellas un tiling vertical; esto me sirve
--   a menudo para copiar de safari a iterm2 (siempre a derecha)
--     en un estadio posterior deberiamos poder revertir 
--     las dos ventanas involucradas a su posicion y tamano
--     originales
-- *idea from freenode #hammerspoon channel*
-- Ng: I would have a global variable that stores their frames before
-- moving them. When your hot key callback fires, if there are frames in there,
-- apply them and remove them. If not, store them and do the tiling :)

-- function util para lo subsiguiente
function table.index_in_tiled_table(element)
   for index, value in pairs(already_tiled_windows) do
       if value == element then
           return index
       end
   end
   return nil
end

hs.hotkey.bind({"cmd","alt","ctrl"},"space", function()
  local wins = hs.window.orderedWindows()
  -- obtener info de la pantalla actual
  local menu_bar_height = 22
  local curr_screen = hs.screen.mainScreen()
  local scr_h = curr_screen:currentMode()['h']
  local scr_w = curr_screen:currentMode()['w']
  local x_curr_screen, y_curr_screen = curr_screen:position()
  -- obtener id, posicion y tamaño de las ventanas involucradas
  winob1 = wins[1]
  winob2 = wins[2]
  -- safari bug, I dont know why (maybe it gets the menu bar?)
  if winob1:application():name() == 'Safari' then
      winob1 = wins[2]
      winob2 = wins[3]
  end
  -- determinamos si iTerm2 es una de las ventanas
  if winob1:application():name() == 'iTerm2' then i=0 else i=1 end
  -- buscar si existe la primera en la lista
  idx1 = table.index_in_tiled_table(winob1:id())
  if idx1 == nil then
    -- guardar su estado antes de tilearla
    table.insert(already_tiled_windows, winob1:id())
    table.insert(already_tiled_windows, winob1:topLeft())
    table.insert(already_tiled_windows, winob1:size())
    -- tilearla
    curr_win = hs.window.get(winob1:id())
    curr_win:setTopLeft(x_curr_screen+(1-i)*scr_w/2, menu_bar_height)
    curr_win:setSize(scr_w/2,scr_h-menu_bar_height)
  else   
    -- recuperar su estado original
    curr_win = hs.window.get(winob1:id())
    curr_win:setTopLeft(already_tiled_windows[idx1+1])
    curr_win:setSize(already_tiled_windows[idx1+2])
    -- sacarla de la lista
    table.remove(already_tiled_windows, idx1)
    table.remove(already_tiled_windows, idx1)
    table.remove(already_tiled_windows, idx1)
  end
  idx2 = table.index_in_tiled_table(winob2:id())
  if idx2 == nil then
    -- guardar su estado antes de tilearla
    table.insert(already_tiled_windows, winob2:id())
    table.insert(already_tiled_windows, winob2:topLeft())
    table.insert(already_tiled_windows, winob2:size())
    -- tilearla
    curr_win = hs.window.get(winob2:id())
    curr_win:setTopLeft(x_curr_screen+i*scr_w/2, menu_bar_height)
    curr_win:setSize(scr_w/2,scr_h-menu_bar_height)
  else 
    -- recuperar su estado original
    curr_win = hs.window.get(winob2:id())
    curr_win:setTopLeft(already_tiled_windows[idx2+1])
    curr_win:setSize(already_tiled_windows[idx2+2])
    -- sacarla de la lista
    table.remove(already_tiled_windows, idx2)
    table.remove(already_tiled_windows, idx2)
    table.remove(already_tiled_windows, idx2)
  end
  print('----------------')
end)


hs.alert.show("Hammerspoon config loaded.")
