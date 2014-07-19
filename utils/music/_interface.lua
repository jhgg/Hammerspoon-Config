local interface = {}

function interface:tell(cmd)
    return hydra.exec('osascript -e \'tell application "' .. self.app_name .. '" to ' .. cmd .. "'")
end

function interface:play()
    self:tell('play')
end

function interface:playpause()
    self:tell('playpause')
end

function interface:pause()
    self:tell('pause')
end

function interface:next()
    self:tell('next track')
end

function interface:previous()
    self:tell('previous track')
end

function interface:currentTrack()
    local artist = self:tell('get the artist of the current track')
    local album = self:tell('get the album of the current track')
    local track = self:tell('get the name of the current track')
    return {
        artist = artist,
        track = track,
        album = album
    }
end

function interface:extend(map)
    for name, val in pairs(map) do
        if type(val) == "function" then
            self[name] = fnutils.partial(fn, self)
        elseif type(val) == "string" then
            self[name] = function()
                self:tell(val)
            end
        end
    end

    return self
end

return function(app)
    local control = {
        app_name = app
    }

    setmetatable(control, { __index = interface })

    -- Bind the function directly, so it can be called like control.play() instead of control:play()
    -- We want to make it seem like we're not using an instance of anything o:
    for i, fn in ipairs({ "play", "pause", "playpause", "next", "previous", "currentTrack" }) do
        control[fn] = fnutils.partial(control[fn], control)
    end

    return control
end