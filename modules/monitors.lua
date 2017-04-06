local position = import('utils/position')
local monitors = import('utils/monitors')
local geometry = import('utils/geometry')
local window = hs.window
local hotkey = hs.hotkey
local mouse = hs.mouse

local function init_module()
    for id, monitor in pairs(monitors.configuredMonitors) do

        hotkey.bind({ "cmd", "ctrl" }, "PAD" .. id, function()
            local midpoint = geometry.rectMidpoint(monitor.dimensions)
            mouse.setAbsolutePosition(midpoint)
        end)

        hotkey.bind({ "cmd", "ctrl", "alt" }, "PAD" .. id, function()
            local win = window.focusedWindow()
            if win ~= nil then
                win:setFrame(position.full(monitor.dimensions))
            end
        end)

        hotkey.bind({ "ctrl", "alt" }, "PAD" .. id, function()
            local win = window.focusedWindow()
            if win ~= nil then
                win:setFrame(position.left(monitor.dimensions))
            end
        end)

        hotkey.bind({ "cmd", "alt" }, "PAD" .. id, function()
            local win = window.focusedWindow()
            if win ~= nil then
                win:setFrame(position.right(monitor.dimensions))
            end
        end)
        hotkey.bind({ "shift", "ctrl", "alt" }, "PAD" .. id, function()
            local win = window.focusedWindow()
            if win ~= nil then
                win:setFrame(monitor.dimensions:relativeWindowPosition(win))
            end
        end)
    end
end

return {
    init = init_module
}