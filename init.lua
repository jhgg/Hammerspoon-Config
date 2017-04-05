-- Hi!
-- Save this as ~/.hydra/init.lua and choose Reload Config from the menu

import = require('utils/import')
import.clearCache()

config = import('config')

function config:get(keyPath, default)
    local root = self
    for part in string.gmatch(keyPath, "[^\\.]+") do
        root = root[part]
        if root == nil then
            return default
        end
    end
    return root
end

local modules = {}

for _, v in ipairs(config.modules) do
    local moduleName = 'modules/' .. v
    local module = import(moduleName)

    if type(module.init) == "function" then
        module.init()
    end

    table.insert(modules, module)
end

--
--hydra.menu.show(function()
--
--    local menu = {
--        { title = "Reload Config", fn = hydra.reload },
--        { title = "-" }
--    }
--
--    local menus_inserted = 0
--
--    for _, module in ipairs(modules) do
--        if type(module.menu) == "function" then
--            fnutils.concat(menu, module.menu())
--            menus_inserted = menus_inserted + 1
--
--        elseif type(module.menu) == "table" then
--            fnutils.concat(menu, module.menu)
--            menus_inserted = menus_inserted + 1
--        end
--    end
--
--    if menus_inserted > 0 then
--        table.insert(menu, { title = "-" })
--    end
--
--    fnutils.concat(menu, {
--        { title = "About", fn = hydra.showabout },
--        { title = "Quit Hydra", fn = os.exit },
--    })
--
--    return menu
--end)


hs.window.animationDuration = config:get('window.animationDuration', 0)
hs.autoLaunch(config:get("autolaunch", false))

local buf = {}

if hs._wasLoaded == nil then
    hs._wasLoaded = true
    table.insert(buf, "Hammerspoon loaded: ")
else
    table.insert(buf, "Hammerspoon re-loaded: ")
end

table.insert(buf, "loaded " .. #modules .. " modules.")

hs.alert.show(table.concat(buf))



