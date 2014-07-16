local find = {
    window = {},
    windows = {},
    audio_device = {}
}

function find.window.by_title(title)
    return fnutils.find(window.allwindows(), function(window)
        return string.match(window:title(), title) ~= nil
    end)
end

function find.window.by_application_title(title)
    return fnutils.find(window.allwindows(), function(window)
        return string.match(window:application():title(), title) ~= nil
    end)
end

function find.windows.by_title(title)
    return fnutils.filter(window.allwindows(), function(window)
        return string.match(window:title(), title) ~= nil
    end)
end

function find.windows.by_application_title(title)
    return fnutils.filter(window.allwindows(), function(window)
        return string.match(window:application():title(), title) ~= nil
    end)
end

function find.audio_device.by_name(name)
    return fnutils.find(audio.alloutputdevices(), function(device)
        return string.match(audio:name(), name) ~= nil
    end)
end

return find

