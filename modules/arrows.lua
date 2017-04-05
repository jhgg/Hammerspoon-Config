local position = import('utils/position')
local monitors = import('utils/monitors')
local hotkey = hs.hotkey
local window = hs.window

local function moduleInit()
    local mash = config:get("arrows.mash", { "cmd", "ctrl", "alt" })
    local keys = config:get("arrows.keys", {
        UP = "top",
        DOWN = "bottom",
        LEFT = "left",
        RIGHT = "right",
        SPACE = "full",
        PAD7 = "leftThird",
        PAD8 = "middleThird",
        PAD9 = "rightThird",
    })

    for key, positionString in pairs(keys) do
        local positionFn = position[positionString]

        if positionFn == nil then
            error("arrow: " .. positionString .. " is not a valid position")
        end

        hotkey.bind(mash, key, function()
            local win = window.focusedWindow()
            if win == nil then
                return
            end

            local screen = win:screen()
            local dimensions = monitors.getScreenDimensions(screen)
            local newframe = positionFn(dimensions)

            win:setFrame(newframe)
        end)

    end

end

return {
    init = moduleInit
}