local find = {
    window = {},
    windows = {},
    audio_device = {}
}

local geom = import('utils/geometry')
local fnutils = hs.fnutils
local audio = hs.audiodevice

function find.window.byTitle(title)
    return fnutils.find(window.allwindows(), function(window)
        return string.match(window:title(), title) ~= nil
    end)
end

function find.window.underneathMouse()
    local pos = mouse.get()
    return fnutils.find(window.orderedwindows(), function(window)
        return geom.pointInRect(window:frame(), pos)
    end)
end

function find.window.byApplicationTitle(title)
    return fnutils.find(window.allwindows(), function(window)
        return string.match(window:application():title(), title) ~= nil
    end)
end

function find.windows.byTitle(title)
    return fnutils.filter(window.allwindows(), function(window)
        return string.match(window:title(), title) ~= nil
    end)
end

function find.windows.byApplicationTitle(title)
    return fnutils.filter(window.allwindows(), function(window)
        return string.match(window:application():title(), title) ~= nil
    end)
end

function find.windows.underneathMouse()
    local pos = mouse.get()
    return fnutils.filter(window.orderedwindows(), function(window)
        return geom.pointInRect(window:frame(), pos)
    end)
end

function find.audio_device.yNameby_name(name)
    return fnutils.find(audio.allOutputDevices(), function(device)
        return string.match(device:name(), name) ~= nil
    end)
end

return find

