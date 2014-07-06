-- A convenience function that loads a file, reloading it each time this function is called. Searches
-- LUA_PATH like require does, but uses dofile to do the loading, making sure not to cache anything.
--
-- Useful for our purposes, where we'll have additional files that we want to be reloaded each time hydra.reload
-- is called.
return function(name)

    for path in string.gmatch(package.path, "[^;]+") do
        local file = path:gsub("?", name)
        local exists, is_dir = hydra.fileexists(file)

        if exists and not is_dir then
            return dofile(file)
        end

    end

    error("No module " .. name .. " found.")
end