--
-- Created by IntelliJ IDEA.
-- User: mac
-- Date: 7/5/14
-- Time: 11:26 PM
-- To change this template use File | Settings | File Templates.
--
local function get_screen_dimensions(idx)
    local screen = screen.allscreens()[idx]
    local dim = screen:visibleframe()
    local frame = screen:frame()

    return {
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
end

return {
    [1] = {
        dimensions = get_screen_dimensions(2)
    },
    [2] = {
        dimensions = get_screen_dimensions(1)
    },
    [3] = {
        dimensions = get_screen_dimensions(3)
    },
    [4] = {
        dimensions = get_screen_dimensions(5)
    },
    [5] = {
        dimensions = get_screen_dimensions(6)
    },
    [6] = {
        dimensions = get_screen_dimensions(4)
    },
}

