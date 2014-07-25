local function endswith(s, send)
    return #s >= #send and s:find(send, #s-#send+1, true) and true or false
end

local function did_lua_file_change(files)
    for _, file in ipairs(files) do
        if endswith(file, ".lua") then
            return true
        end
    end

    return false
end

local function on_files_changed(files)
    if did_lua_file_change(files) then
        hydra.reload()
    end
end

return {
    init = function()
        pathwatcher.new(os.getenv("HOME") .. "/.hydra/", on_files_changed):start()
    end
}