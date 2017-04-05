local dimensions__proto = {}
local dimensions__mt = { __index = dimensions__proto }
local screen = hs.screen
local fnutils = hs.fnutils

function dimensions__proto:relativeTo(position)
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

function dimensions__proto:relativeWindowPosition(win)
    local frame = win:frame()
    local winScreen = win:screen()
    local screenframe = winScreen:frame()

    return self:relativeTo({
        w = frame.w,
        h = frame.h,
        x = frame.x - screenframe.x,
        y = frame.y - screenframe.y,
    })

end

function dimensions__proto:translateFrom(positionFunc, translationTable)
    if type(positionFunc) == "string" then
        positionFunc = import('utils/position')[positionFunc]
    end

    local position = positionFunc(self)
    position._relative = true

    for k, v in pairs(translationTable) do
        position[k] = position[k] + v
    end

    return position
end


local function getScreenDimensions(winScreen)

    local dim = winScreen:frame()
    local frame = winScreen:fullFrame()

    local dimensions = {
        w = dim.w,
        h = dim.h,
        x = dim.x,
        y = dim.y,
        f = {
            w = frame.w,
            h = frame.h,
            x = frame.x,
            y = frame.y
        }
    }

    setmetatable(dimensions, dimensions__mt)
    return dimensions
end

local function getScreenDimensionsAtIndex(index)
    local screen = screen.allscreens()[index]
    if screen == nil then
        error("Cannot find screen with index " .. index)
    end

    return getScreenDimensions(screen)
end

local function autodiscoverMonitors(rows)
    local screens = screen.allScreens()
    local primaryScreen = fnutils.find(screens, function(winScreen)
        local dim = winScreen:fullFrame()
        return dim.x == 0 and dim.y == 0
    end)
    local screenTable = {}
    local referenceScreenFrame = primaryScreen:fullFrame()

    for _ = 1, rows do
        local monitorsInRow = fnutils.filter(screens, function(winScreen)
            return winScreen:fullFrame().y == referenceScreenFrame.y
        end)

        table.sort(monitorsInRow, function(a, b)
            return a:fullFrame().x < b:fullFrame().x
        end)

        fnutils.concat(screenTable, monitorsInRow)
        referenceScreenFrame.y = referenceScreenFrame.y - referenceScreenFrame.h
    end

    return fnutils.map(screenTable, function(screen)
        return {
            dimensions = getScreenDimensions(screen)
        }
    end)
end

local monitors = {
    getScreenDimensions = getScreenDimensions,
    configuredMonitors = {}
}

if config:get("monitors.autodiscover", false) then
    monitors.configuredMonitors = autodiscoverMonitors(config:get("monitors.rows", 1))
else
    for i, v in ipairs(config:get("monitors", {})) do
        monitors.configuredMonitors[i] = {
            dimensions = getScreenDimensionsAtIndex(v)
        }
    end
end

return monitors
