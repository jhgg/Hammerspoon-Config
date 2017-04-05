-- A convenience function that loads a file, reloading it each time this function is called. Searches
-- LUA_PATH like require does, but uses dofile to do the loading, making sure not to cache anything.
--
-- Useful for our purposes, where we'll have additional files that we want to be reloaded each time hydra.reload
-- is called.

local import = {}

local import_mt = {
    __call = function(_, ...) return import.import(...) end
}

local cache = {}

function import.clearCache()
    for k in pairs(cache) do
        cache[k] = nil
    end
end

function import.cacheSize()
    return #cache
end

function import.cachedModules()
    local t = {}
    for k in pairs(cache) do
        table.insert(t, k)
    end

    return t
end

function import.import(name)
    if cache[name] ~= nil then
        return cache[name]
    end

    for path in string.gmatch(package.path, "[^;]+") do
        local file = path:gsub("?", name)
        local attributes = hs.fs.attributes(file)
        local is_dir = attributes and attributes.mode == 'directory'

        if attributes ~= nil and not is_dir then
            local module = dofile(file)
            cache[name] = module

            return module
        end
    end

    error("No module " .. name .. " found.")
end

setmetatable(import, import_mt)

return import