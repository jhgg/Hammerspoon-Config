return {
    init = function()
        hotkey.bind({ "cmd", "ctrl", "alt" }, "R", repl.open)
    end
}