local hotkey = hs.hotkey

local function moduleInit()
    local mash = config:get("lock.mash", {})
    local key = config:get("lock.key", "F13")

    hotkey.bind(mash, key, function()
        hs.execute("/System/Library/CoreServices/Menu\\ Extras/User.menu/Contents/Resources/CGSession -suspend")
    end)

end

return {
    init = moduleInit
}