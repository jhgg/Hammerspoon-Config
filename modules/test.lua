local function module_init()
    local matcher = import('utils/match_dialogue')(function()
        return fnutils.map(window.allwindows(), function(window)
            return {
                string = window:application():title() .. ' - ' .. window:title(),
                window = window
            }
        end)
    end, function(match)
        match.window:focus()

    end)

    hotkey.bind({ "cmd", "ctrl" }, "S", function()
        matcher:show()
    end)
end

return {
    init = module_init
}

