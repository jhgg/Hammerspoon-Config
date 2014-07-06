--
-- Created by IntelliJ IDEA.
-- User: mac
-- Date: 7/6/14
-- Time: 12:51 AM
-- To change this template use File | Settings | File Templates.
--

local load = require('loader')
local find = load('find')
local monitors = load('monitors')
local position = load('position')

local arrangement = {}

function get_window(arrangement_table)
    if arrangement_table.app_title ~= nil then
        return find.window.by_application_title(arrangement_table.app_title)
    end

    if arrangement_table.title ~= nil then
        return find.window.by_title(arrangement_table.app_title)
    end

    error("Arrangement table needs: app_title or title to be set")
end


function arrangement.arrange(arrangement_table)
    fnutils.map(arrangement_table, function(item)
        local window = get_window(item)
        if window == nil then
            return
        end

        if item.monitor == nil then
            error("arrangement table does not have monitor")
        end

        if item.position == nil then
            error("arrangement table does not have position")
        end

        if position[item.position] == nil then
            error("position " .. item.position .. " is invalid.")
        end

        if monitors[item.monitor] == nil then
            error("monitor " .. item.monitor .. " does not exist")
        end

        window:setframe(position[item.position](monitors[item.monitor].dimensions))

    end)
end

return arrangement