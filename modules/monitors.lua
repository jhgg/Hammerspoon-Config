local position = import('utils/position')
local monitors = import('utils/monitors')

local function init_module()
    for id, monitor in pairs(monitors) do

        hotkey.bind({ "cmd", "ctrl" }, "PAD" .. id, function()
            local midpoint = geometry.rectmidpoint(monitor.dimensions)
            mouse.set(midpoint)
        end)

        hotkey.bind({ "cmd", "ctrl", "alt" }, "PAD" .. id, function()
            local win = window.focusedwindow()
            win:setframe(position.full(monitor.dimensions))
        end)

        hotkey.bind({ "ctrl", "alt" }, "PAD" .. id, function()
            local win = window.focusedwindow()
            win:setframe(position.top(monitor.dimensions))
        end)

        hotkey.bind({ "cmd", "alt" }, "PAD" .. id, function()
            local win = window.focusedwindow()
            win:setframe(position.bottom_left(monitor.dimensions))
        end)
    end
end

return {
    init = init_module
}