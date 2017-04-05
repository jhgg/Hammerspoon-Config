local function endswith(s, send)
    return #s >= #send and s:find(send, #s-#send+1, true) and true or false
end

local function didLuaFileChange(files)
    for _, file in ipairs(files) do
        if endswith(file, ".lua") then
            return true
        end
    end

    return false
end

local function onFilesChanged(files)
    if didLuaFileChange(files) then
        hs.reload()
    end
end

return {
    init = function()
        hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", onFilesChanged):start()
    end
}