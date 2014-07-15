-- Functions to calculate positioning of a window.

local position = {}

-- Left half.
function position.left(d)
    return {
        x = d.x,
        y = d.y,
        h = d.h,
        w = d.w / 2
    }
end

-- Right half
function position.right(d)
    return {
        x = d.x + d.w / 2,
        y = d.y,
        h = d.h,
        w = d.w / 2
    }
end

-- Top half
function position.top(d)
    return {
        x = d.x,
        y = d.y,
        h = d.h / 2,
        w = d.w,
    }
end

-- Bottom half
function position.bottom(d)
    return {
        x = d.x,
        y = d.y + d.h / 2,
        h = d.h / 2,
        w = d.w
    }
end

-- Top left quarter
function position.top_left(d)
    return {
        x = d.x,
        y = d.y,
        h = d.h / 2,
        w = d.w / 2
    }
end

-- Top right quarter
function position.top_right(d)
    return {
        x = d.x + d.w / 2,
        y = d.y,
        h = d.h / 2,
        w = d.w / 2
    }
end

-- Bottom left quarter
function position.bottom_left(d)
    return {
        x = d.x,
        y = d.y + d.h / 2,
        h = d.h / 2,
        w = d.w / 2
    }
end

-- Bottom right quarter
function position.bottom_right(d)
    return {
        x = d.x + d.w / 2,
        y = d.y + d.h / 2,
        h = d.h / 2,
        w = d.w / 2
    }
end

-- Full screen
function position.full(d)
    return {
        x = d.x,
        y = d.y,
        h = d.h,
        w = d.w
    }
end

-- Left 1/3rd.
function position.left_third(d)
    return {
        x = d.x,
        y = d.y,
        h = d.h,
        w = d.w / 3
    }
end

-- Left 1/3rd.
function position.middle_third(d)
    return {
        x = d.x + (d.w / 3),
        y = d.y,
        h = d.h,
        w = d.w / 3
    }
end

-- Left 2/3rd
function position.left_two_thirds(d)
    return {
        x = d.x,
        y = d.y,
        h = d.h,
        w = (d.w / 3) * 2
    }
end

-- Right 1/3rd
function position.right_third(d)
    return {
        x = d.x + ((d.w / 3) * 2),
        y = d.y,
        h = d.h,
        w = d.w / 3
    }
end

-- Right 2/3rds.
function position.right_two_thirds(d)
    return {
        x = d.x + (d.w / 3),
        y = d.y,
        h = d.h,
        w = (d.w / 3) * 2
    }
end

return position