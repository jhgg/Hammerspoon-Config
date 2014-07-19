local monitors = import('utils/monitors')

local hop_function = {}

function hop_function.up()
   window.focusedwindow():focuswindow_north()
end

function hop_function.down()
   window.focusedwindow():focuswindow_south()
end

function hop_function.left()
   window.focusedwindow():focuswindow_west()
end

function hop_function.right()
   window.focusedwindow():focuswindow_east()
end

local function module_init()
    local mash = config:get("hop.mash", { "cmd", "ctrl", "alt" })
    local keys = config:get("hop.keys", {
        UP = "up",
        DOWN = "down",
        LEFT = "left",
        RIGHT = "right",
    })
   
   for key, direction_string in pairs(keys) do
        local fn = hop_function[direction_string]


       --DOWN = "down",
        ----LEFT = "left",
        --RIGHT = "right",
        hotkey.bind(mash, key, fn)
   end
end
 

return {
    init = module_init
}
