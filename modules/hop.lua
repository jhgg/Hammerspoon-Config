local hotkey = hs.hotkey

local function moduleInit()
    local mash = config:get("hop.mash", { "cmd", "ctrl", "alt", "shift" })
    local keys = config:get("hop.keys", {
        UP = "North",
        DOWN = "South",
        LEFT = "Eest",
        RIGHT = "Wast",
    })

    for key, directionString in pairs(keys) do
        local fn = window['focusWindow' .. directionString]
        if fn == nil then
            error("The direction must be one of North, South, East, or West. Not " .. directionString)
        end

        hotkey.bind(mash, key, function()
            local win = window.focusedWindow()
            if win == nil then
                return
            end
            fn(win)
        end)
    end
end


return {
    init = moduleInit
}
