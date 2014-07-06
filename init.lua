-- Hi!
-- Save this as ~/.hydra/init.lua and choose Reload Config from the menu

import = require('utils/import')
import.clear_cache()

config = import('config')

function config:get(key_path, default)
    local root = self
    for part in string.gmatch(key_path, "[^\\.]+") do
        root = root[part]
        if root == nil then
            return default
        end
    end
    return root
end

local modules = {}

for _, v in ipairs(config.modules) do
    local module_name = 'modules/' .. v
    local module = import(module_name)

    if type(module.init) == "function" then
        module.init()
    end

    table.insert(modules, module)
end


menu.show(function()

    local menu = {
        { title = "Reload Config", fn = hydra.reload },
        { title = "-" }
    }

    local menus_inserted = 0

    for _, module in ipairs(modules) do
        if type(module.menu) == "function" then
            fnutils.concat(menu, module.menu())
            menus_inserted = menus_inserted + 1

        elseif type(module.menu) == "table" then
            fnutils.concat(menu, module.menu)
            menus_inserted = menus_inserted + 1
        end
    end

    if menus_inserted > 0 then
        table.insert(menu, { title = "-" })
    end

    fnutils.concat(menu, {
        { title = "About", fn = hydra.showabout },
        { title = "Quit Hydra", fn = os.exit },
    })

    return menu
end)

autolaunch.set(config.autolaunch == true)

local buf = {}

if hydra.was_loaded == nil then
    hydra.was_loaded = true
    table.insert(buf, "Hydra loaded: ")
else
    table.insert(buf, "Hydra re-loaded: ")
end

table.insert(buf, "loaded " .. #modules .. " modules.")

hydra.alert(table.concat(buf))



