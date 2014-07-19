return function(...)
    local matcher_functions = {...}

    return function(...)
        for _, fn in ipairs(matcher_functions) do
            local ret = fn(...)
            if ret ~= nil then
                return ret
            end
        end

        return nil
    end
end

