local dimensions__proto = {}
local dimensions__mt = { __index = dimensions__proto }

function dimensions__proto:relative_to(position)
    return {
        w = position.w,
        h = position.h,
        x = self.x + position.x,
        y = self.y + position.y
    }
end

local function get_screen_dimensions(idx)
    local screen = screen.allscreens()[idx]
    if screen == nil then
        error("Cannot find screen with index " .. idx)
    end

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

local monitors = {}

for i, v in ipairs(config.monitors) do
    monitors[i] = {
        dimensions = get_screen_dimensions(v)
    }
end

return monitors
