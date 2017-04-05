return {
    init = function()
        hs.hotkey.bind(config:get("repl.mash", { "cmd", "ctrl", "alt" }), config:get("repl.key", "R"), hs.toggleConsole)
    end
}