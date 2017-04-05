local hotkey = hs.hotkey

local function moduleInit()
    local mash = config:get('fullscreen.mash', { "cmd", "ctrl" })
    local key = config:get('fullscreen.key', "A")

    hotkey.bind(mash, key, function()
        local win = hs.window.focusedWindow()
        if win ~= nil then
            win:setFullScreen(not win:isFullScreen())
        end
    end)
end

return {
    init = moduleInit
}