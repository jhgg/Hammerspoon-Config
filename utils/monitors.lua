local dimensions__proto = {}
local dimensions__mt = { __index = dimensions__proto }

function dimensions__proto:relative_to(position)
    if position._relative ~= nil then
        return position
    end

    return {
        w = position.w,
        h = position.h,
        x = self.x + position.x,
        y = self.y + position.y,
        _relative = true
    }
end

function dimensions__proto:translate_from(position_func, translation_table)
    if type(position_func) == "string" then
        position_func = import('utils/position')[position_func]
    end

    local position = position_func(self)
    position._relative = true

    for k, v in pairs(translation_table) do
        position[k] = position[k] + v
    end

    return position
end


local function get_screen_dimensions(screen)

    local dim = screen:visibleframe()
    local frame = screen:frame()

    local dimensions = {
        w = dim.w,
        h = dim.h,
        x = dim.x,
        y = -dim.y,
        f = {
            w = frame.w,
            h = frame.h,
            x = frame.x,
            y = -frame.y
        }
    }

    setmetatable(dimensions, dimensions__mt)
    return dimensions
end

local function get_screen_dimensions_at_index(index)
    local screen = screen.allscreens()[index]
    if screen == nil then
        error("Cannot find screen with index " .. index)
    end

    return get_screen_dimensions(screen)

end

local monitors = {
    get_screen_dimensions = get_screen_dimensions,
    configured_monitors = {}
}

for i, v in ipairs(config.monitors) do
    monitors.configured_monitors[i] = {
        dimensions = get_screen_dimensions_at_index(v)
    }
end

return monitors
