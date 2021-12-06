-- config auto reload block
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

-- Move window left half
hs.hotkey.bind({"cmd", "ctrl"}, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Move window right half
hs.hotkey.bind({"cmd", "ctrl"}, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Move window top half
hs.hotkey.bind({"cmd", "ctrl"}, "K", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

-- Move window bottom half
hs.hotkey.bind({"cmd", "ctrl"}, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

-- Maximise window
hs.hotkey.bind({"cmd", "ctrl"}, "M", function()
  local win = hs.window.focusedWindow()
  win:maximize()
end)

-- prev screen
hs.hotkey.bind({"cmd", "ctrl"}, "P", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  win:moveToScreen(screen:previous())
end)

-- next screen
hs.hotkey.bind({"cmd", "ctrl"}, "N", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  win:moveToScreen(screen:next())
end)

-- close window
hs.hotkey.bind({"cmd", "ctrl"}, "C", function()
  local win = hs.window.focusedWindow()
  win:close()
end)
