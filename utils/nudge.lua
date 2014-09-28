local nudge = {}
local step = config:get("nudge.step", 10)

function nudge.up(d)
    return {
        x = d.x,
        y = d.y + step,
        h = d.h,
        w = d.w
    }
end

function nudge.taller(d)
    return {
        x = d.x,
        y = d.y,
        h = d.h + step,
        w = d.w
    }
end

function nudge.shorter(d)
    return {
        x = d.x,
        h = math.max(d.h - step, 0),
        y = d.y,
        w = d.w
    }
end

function nudge.down(d)
    return {
        x = d.x,
        h = math.max(d.h - step, 0),
        y = d.h,
        w = d.w
    }
end

function nudge.wider(d)
    return {
        x = d.x,
        y = d.y,
        h = d.h,
        w = d.w + step,
    }
end

function nudge.left(d)
    return {
        x = math.max(d.x - step, 0),
        y = d.y,
        h = d.h,
        w = d.w,
    }
end

function nudge.right(d)
    return {
        x = d.x + step,
        y = d.y,
        h = d.h,
        w = d.w,
    }
end

function nudge.narrower(d)
    return {
        x = d.x,
        y = d.y,
        h = d.h,
        w = math.max(d.w - step, 50)
    }
end

return nudge
