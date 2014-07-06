local find = import('utils/find')
local monitors = import('utils/monitors')
local position = import('utils/position')

local function get_window(arrangement_table)
    if arrangement_table.app_title ~= nil then
        return find.window.by_application_title(arrangement_table.app_title)
    end

    if arrangement_table.title ~= nil then
        return find.window.by_title(arrangement_table.app_title)
    end

    error("Arrangement table needs: app_title or title to be set")
end


local function arrange(arrangement_table)
    fnutils.map(arrangement_table, function(item)

        local window = get_window(item)
        if window == nil then
            return
        end

        local monitor = item.monitor
        local item_position = item.position

        if monitor == nil then
            error("arrangement table does not have monitor")
        end

        if item_position == nil then
            error("arrangement table does not have position")
        end

        if monitors[monitor] == nil then
            error("monitor " .. monitor .. " does not exist")
        end

        if type(item_position) == "string" then
            window:setframe(position[item_position](monitors[monitor].dimensions))

        elseif type(item_position) == "function" then
            window:setframe(monitors[monitor].dimensions:relative_to(item_position({
                monitor = monitors[monitor],
                window = window
            })))

        elseif type(item_position) == "table" then
            window:setframe(monitors[monitor].dimensions:relative_to(item_position))

        else
            error("position cannot be a " .. type(item_position))
        end
    end)
end

local function init_module()
    if config.arrangements == nil then
        alert("Arrangements has no available configs, set in config.arrangements")
    end

    for _, arrangement in ipairs(config.arrangements) do
        hotkey.bind(arrangement.mods, arrangement.key, function()
            arrange(arrangement.arrangement)
        end)
    end
end

return {
    init = init_module
}