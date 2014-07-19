local nudge = {}

function nudge.up(d)
   local step = config:get("slide.step", {10})
    return {
        x = d.x,
        y = d.y + step,
        h = d.h,
        w = d.w
    }
end

function nudge.taller(d)
   local step = config:get("slide.step", 10)
    return {
        x = d.x,
        y = d.y,
        h = d.h + step,
        w = d.w
    }
end

function nudge.shorter(d)
    local step = config:get("slide.step", 10)
    return {
        x = d.x,
        h = math.max(d.h - step, 0),
        y = d.y,
        w = d.w 
    }
end

function nudge.down(d)
    local step = config:get("slide.step", 10)
    return {
        x = d.x,
        h = math.max(d.h - step, 0),
        y = y.h,
        w = d.w 
    }
end

function nudge.wider(d)
    local step = config:get("slide.step", 10)
    return {
        x = d.x,
        y = d.y,
        h = d.h,
        w = d.w + step,
    }
end

function nudge.left(d)
    local step = config:get("slide.step", 10)
    return {
        x = math.max(d.x - step, 0),
        y = d.y,
        h = d.h,
        w = d.w,
    }
end

function nudge.right(d)
    local step = config:get("slide.step", 10)
    return {
        x = d.x + step,
        y = d.y,
        h = d.h,
        w = d.w,
    }
end

function nudge.narrower(d)
    local step = config:get("slide.step", 10)
    return {
        x = d.x,
        y = d.y,
        h = d.h,
        w = math.max(d.w - step, 50)
    }
end

return nudge 
