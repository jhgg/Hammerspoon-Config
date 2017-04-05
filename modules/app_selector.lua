local match_dialgoue = import('utils/matchDialogue')
local geom = import('utils/geometry')
local window = hs.window

local function moduleInit()
    local function matchDataSource()
        local results = {}

        for _, win in ipairs(window.allWindows()) do
            local title = win:title()

            if title:len() > 0 then
                table.insert(results, {
                    string = win:application():title() .. ' - ' .. title,
                    window = win
                })
            end
        end
        return results
    end

    local function matchSelected(match)
        match.window:focus()

        if config:get('appSelector.mouseMove', true) then
            local center = geom.rectMidpoint(match.window:frame())
            mouse.set(center)
        end
    end

    local matcher = match_dialgoue(matchDataSource, matchSelected)

    hotkey.bind(config:get('appSelector.mash', { "ctrl" }), config:get('appSelector.key', "tab"), function()
        matcher:show()
    end)
end

return {
    init = moduleInit
}

