return {
    init = function()
        hs.hotkey.bind(config:get("reload.mash", { "cmd", "ctrl", "alt" }), config:get("reload.key", "E"), hs.reload)
    end
}