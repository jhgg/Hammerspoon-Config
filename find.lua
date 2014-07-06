local find = {
    window = {}
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


return find

