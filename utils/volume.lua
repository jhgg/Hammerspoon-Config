local volume = {}
local audio = hs.audiodevice

function volume.mute()
    local dev = audio.defaultOutputDevice()
    return dev and dev:setMuted(true)
end

function volume.unmute()
    local dev = audio.defaultOutputDevice()
    return dev and dev:setMuted(false)
end

function volume.muted()
    local dev = audio.defaultOutputDevice()
    return dev and dev:muted()
end

function volume.increment()
    local dev = audio.defaultOutputDevice()
    if dev == nil then
        return nil
    end

    local volume = dev:volume()
    volume = math.min(volume + 6.25, 100)
    if dev:setVolume(volume) then
        return volume
    end

    return false
end

function volume.decrement()
    local dev = audio.defaultOutputDevice()
    if dev == nil then
        return nil
    end

    local volume = dev:volume()
    volume = math.max(volume - 6.25, 0)
    if dev:setVolume(volume) then
        return volume
    end

    return false
end

function volume.set(volume)
    local dev = audio.defaultOutputDevice()
    if dev == nil then
        return nil
    end

    return dev:setVolume(volume)
end

return volume