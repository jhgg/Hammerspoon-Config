--
-- Created by IntelliJ IDEA.
-- User: mac
-- Date: 7/6/14
-- Time: 12:56 AM
-- To change this template use File | Settings | File Templates.
--

local position = {}

function position.left(d)
    return {
        x = d.x,
        y = d.y,
        h = d.h,
        w = d.w / 2
    }
end

function position.right(d)
    return {
        x = d.x + d.w / 2,
        y = d.y,
        h = d.h,
        w = d.w / 2
    }
end

function position.top(d)
    return {
        x = d.x,
        y = d.y,
        h = d.h / 2,
        w = d.w,
    }
end

function position.bottom(d)
    local top_offset = d.f.h - d.h
    return {
        x = d.x,
        y = top_offset + d.y + d.h / 2,
        h = d.h / 2,
        w = d.w
    }
end

function position.top_left(d)
    return {
        x = d.x,
        y = d.y,
        h = d.h / 2,
        w = d.w / 2
    }
end

function position.top_right(d)
    return {
        x = d.x + d.w / 2,
        y = d.y,
        h = d.h / 2,
        w = d.w / 2
    }
end

function position.bottom_left(d)
    local top_offset = d.f.h - d.h
    return {
        x = d.x,
        y = top_offset + d.y + d.h / 2,
        h = d.h / 2,
        w = d.w / 2
    }
end

function position.bottom_right(d)
    local top_offset = d.f.h - d.h
    return {
        x = d.x + d.w / 2,
        y = top_offset + d.y + d.h / 2,
        h = d.h / 2,
        w = d.w / 2
    }
end

function position.full(d)
    return {
        x = d.x,
        y = d.y,
        h = d.h,
        w = d.w
    }
end

function position.left_third(d)
    return {
        x = d.x,
        y = d.y,
        h = d.h,
        w = d.w / 3
    }
end

function position.left_two_thirds(d)
    return {
        x = d.x,
        y = d.y,
        h = d.h,
        w = (d.w / 3) * 2
    }
end

function position.right_third(d)
    return {
        x = d.x + ((d.w / 3) * 2),
        y = d.y,
        h = d.h,
        w = d.w / 3
    }
end

function position.right_two_thirds(d)
    return {
        x = d.x + (d.w / 3),
        y = d.y,
        h = d.h,
        w = (d.w / 3) * 2
    }
end

return position