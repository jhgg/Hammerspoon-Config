local geometry = {}

function geometry.point_in_rect(rect, point)
    return point.x >= rect.x and
           point.y >= rect.y and
           point.x <= rect.x + rect.w and
           point.y <= rect.y + rect.h
end

function geometry.rect_midpoint(rect)
    return {
        x = rect.x + rect.w * .5,
        y = rect.y + rect.h * .5
    }
end

return geometry