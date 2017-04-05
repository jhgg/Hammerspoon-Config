local nudge = import('utils/nudge')
local hotkey = hs.hotkey
local window = hs.window

local function moduleInit()
    local mash = config:get("slide.mash", { "cmd", "ctrl", "alt" })
    local keys = config:get("slide.keys", {
        UP = "shorter",
        DOWN = "taller",
        LEFT = "narrower",
        RIGHT = "wider",
    })

    for key, directionString in pairs(keys) do
        local nudgeFn = nudge[directionString]


        if nudgeFn == nil then
            error("arrow: " .. directionString .. " is not a valid direction")
        end

        hotkey.bind(mash, key, function()
            local win = window.focusedWindow()
            if win == nil then
                return
            end

            local dimensions = win:frame()
            local newframe = nudgeFn(dimensions)

            win:setFrame(newframe)
        end)
    end
end

return {
    init = moduleInit
}
