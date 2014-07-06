-- Hi!
-- Save this as ~/.hydra/init.lua and choose Reload Config from the menu

local load = require('loader')
local inspect = require('inspect')
local find = load('find')
local position = load('position')
local monitors = load('monitors')
local arrangement = load('arrangement')

if hydra.was_loaded == nil then
    hydra.was_loaded = true
    hydra.alert("Hydra config loaded.", 1.5)
else
    hydra.alert("Hydra config (re)loaded.", 1.5)
end

-- open a repl
--   the repl is a Lua prompt; type "print('hello world')"
--   when you're in the repl, type "help" to get started
--   almost all readline functionality works in the repl
hotkey.bind({"cmd", "ctrl", "alt"}, "R", repl.open)
hotkey.bind({"cmd", "ctrl", "alt"}, "E", hydra.reload)

-- save the time when updates are checked
function checkforupdates()
  updates.check()
  settings.set('lastcheckedupdates', os.time())
end

for id, monitor in pairs(monitors) do
    hotkey.bind({"cmd", "ctrl"}, "PAD" .. id, function()
        local midpoint = geometry.rectmidpoint(monitor.dimensions)
        mouse.set(midpoint)
    end)

    hotkey.bind({"cmd", "ctrl", "alt"}, "PAD" .. id, function()
        local win = window.focusedwindow()
        win:setframe(monitor.dimensions)
    end)

    hotkey.bind({"ctrl", "alt"}, "PAD" .. id, function()
        local win = window.focusedwindow()
        win:setframe(position.top(monitor.dimensions))
    end)

    hotkey.bind({"cmd", "alt"}, "PAD" .. id, function()
        local win = window.focusedwindow()
        win:setframe(position.bottom_left(monitor.dimensions))
    end)
end

function frame_left_part(dimensions)
    return {
        x = dimensions.x,
        y = dimensions.y,
        h = dimensions.h,
        w = dimensions.w / 2
    }
end

function frame_right_part(dimensions)
    return {
        x = dimensions.x + dimensions.w / 2,
        y = dimensions.y,
        h = dimensions.h,
        w = dimensions.w / 2
    }
end


local arrangement_1 = {
    {
        app_title = "^Mail",
        monitor = 1,
        position = "full"
    },
    {
        app_title = "^Slack",
        monitor = 4,
        position = "left"
    },
    {
        app_title = "^Messages",
        monitor = 4,
        position = "bottom_right"
    },
    {
        app_title = "^Skype",
        monitor = 4,
        position = "top_right"
    },
    {
        app_title = "^Spotify",
        monitor = 6,
        position = "full"
    }
}


hotkey.bind({"cmd", "ctrl", "alt"}, "A", function()
    arrangement.arrange(arrangement_1)
end)


-- show a helpful menu
menu.show(function()
    local updatetitles = {[true] = "Install Update", [false] = "Check for Update..."}
    local updatefns = {[true] = updates.install, [false] = checkforupdates}
    local hasupdate = (updates.newversion ~= nil)

    return {
      {title = "Reload Config", fn = hydra.reload},
      {title = "-"},
      {title = "About", fn = hydra.showabout},
      {title = updatetitles[hasupdate], fn = updatefns[hasupdate]},
      {title = "Quit Hydra", fn = os.exit},
    }
end)

-- show available updates
local function showupdate()
  os.execute('open https://github.com/sdegutis/Hydra/releases')
end

-- what to do when an update is checked
function updates.available(available)
  if available then
    notify.show("Hydra update available", "", "Click here to see the changelog and maybe even install it", "showupdate")
  else
    hydra.alert("No update available.")
  end
end

-- Uncomment this if you want Hydra to make sure it launches at login
-- autolaunch.set(true)

-- check for updates every week
timer.new(timer.weeks(1), checkforupdates):start()
notify.register("showupdate", showupdate)

-- if this is your first time running Hydra, you're launching it more than a week later, check now
local lastcheckedupdates = settings.get('lastcheckedupdates')
if lastcheckedupdates == nil or lastcheckedupdates <= os.time() - timer.days(7) then
  checkforupdates()
end


