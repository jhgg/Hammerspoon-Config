local find = import('utils/find')
local monitors = import('utils/monitors').configuredMonitors
local position = import('utils/position')
local fnutils = hs.fnutils
local hotkey = hs.hotkey

local function getWindow(arrangementTable)
    if arrangementTable.appTitle ~= nil then
        return find.window.byApplicationTitle(arrangementTable.appTitle)
    end

    if arrangementTable.title ~= nil then
        return find.window.byTitle(arrangementTable.appTitle)
    end

    error("Arrangement table needs: appTitle or title to be set")
end


local function arrange(arrangement)
    fnutils.map(arrangement, function(item)

        local window = getWindow(item)
        if window == nil then
            return
        end

        local monitor = item.monitor
        local itemPosition = item.position

        if monitor == nil then
            error("arrangement table does not have monitor")
        end

        if itemPosition == nil then
            error("arrangement table does not have position")
        end

        if monitors[monitor] == nil then
            error("monitor " .. monitor .. " does not exist")
        end

        local winFull = window:isFullScreen()

        if itemPosition ~= "fullScreen" and winFull then
            window:setFullScreen(false)
        end

        if type(itemPosition) == "string" then

            if itemPosition == "fullScreen" then
                window:setFrame(monitors[monitor].dimensions.f)

                if not winFull then
                    window:setFullScreen(true)
                end

            else

                window:setFrame(position[itemPosition](monitors[monitor].dimensions))
            end

        elseif type(itemPosition) == "function" then
            window:setFrame(monitors[monitor].dimensions:relativeTo(itemPosition(monitors[monitor].dimensions, {
                monitor = monitors[monitor],
                window = window,
                position = position
            })))

        elseif type(itemPosition) == "table" then
            window:setFrame(monitors[monitor].dimensions:relativeTo(itemPosition))

        else
            error("position cannot be a " .. type(itemPosition))
        end
    end)
end

local function handleArrangement(arrangement)
    arrange(arrangement.arrangement)

    if arrangement.alert == true then
        hydra.alert("Arranged monitors with: " .. (arrangement.name or "unnamed arrangement"), 1.0)
    end
end

local function initModule()
    if config.arrangements == nil then
        notify.show("Arrangements has no available configs", "", "Set some configs set in config.arrangements or unload this module", "")
        return
    end

    for _, arrangement in ipairs(config.arrangements) do
        if arrangement.key == nil and arrangement.menu ~= true then
            error("Arrangement is missing a key value, and isn't bound to the menu.")
        end

        if arrangement.key ~= nil then
            hotkey.bind(arrangement.mash or { "cmd", "ctrl", "alt" }, arrangement.key, fnutils.partial(handleArrangement, arrangement))
        end
    end

    if config:get('arrangements.fuzzySearch', false) then
        local mash = config:get('arrangements.fuzzySearch.mash', {"ctrl", "alt", "cmd"})
        local key = config:get('arrangements.fuzzySearch.key', "F")

        local matchDialog = import('utils/matchDialogue')

        local matcher = matchDialog(function()
            local list = fnutils.filter(config.arrangements, function(arrangement) return arrangement.name ~= nil end)
            return fnutils.map(list, function(arrangement)
                return {
                    string = arrangement.name,
                    arrangement = arrangement
                }
            end)
        end, function(match)
            handleArrangement(match.arrangement)
        end)

        hotkey.bind(mash, key, fnutils.partial(matcher.show, matcher))

    end


end

local function initMenu()
    if config.arrangements == nil then
        return
    end

    local menu = {}

    for _, arrangement in ipairs(config.arrangements) do
        if arrangement.menu == true then
            table.insert(menu, {
                title = "Arrange: " .. arrangement.name,
                fn = function()
                    handleArrangement(arrangement)
                end
            })
        end
    end

    if #menu > 0 then
        return fnutils.concat(menu, { { title = "-" } })
    else
        return menu
    end
end

return {
    init = initModule,
    menu = initMenu
}