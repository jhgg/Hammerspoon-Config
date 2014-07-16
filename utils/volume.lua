local volume = {}

function volume.mute()
    local dev = audio.defaultoutputdevice()
    return dev and dev:setmuted(true)
end

function volume.unmute()
    local dev = audio.defaultoutputdevice()
    return dev and dev:setmuted(false)
end

function volume.muted()
    local dev = audio.defaultoutputdevice()
    return dev and dev:muted()
end

function volume.increment()
    local dev = audio.defaultoutputdevice()
    if dev == nil then
        return nil
    end

    local volume = dev:volume()
    volume = math.min(volume + 6.25, 100)
    if dev:setvolume(volume) then
        return volume
    end

    return false
end

function volume.decrement()
    local dev = audio.defaultoutputdevice()
    if dev == nil then
        return nil
    end

    local volume = dev:volume()
    volume = math.max(volume - 6.25, 0)
    if dev:setvolume(volume) then
        return volume
    end

    return false
end

function volume.set(volume)
    local dev = audio.defaultoutputdevice()
    if dev == nil then
        return nil
    end

    return dev:setvolume(volume)
end

return volume