
-- show available updates
local function showupdate()
    os.execute('open https://github.com/sdegutis/Hydra/releases')
end

-- what to do when an update is checked
local function updates_available(available)
    if available then
        notify.show("Hydra update available", "", "Click here to see the changelog and maybe even install it", "showupdate")
    else
        hydra.alert("No update available.")
    end
end

-- save the time when updates are checked
local function checkforupdates()
    updates.check(updates_available)
    settings.set('lastcheckedupdates', os.time())
end

local function module_init()

    -- check for updates every week
    timer.new(timer.days(1), checkforupdates):start()
    notify.register("showupdate", showupdate)

    -- if this is your first time running Hydra, you're launching it more than a week later, check now
    local lastcheckedupdates = settings.get('lastcheckedupdates')
    if lastcheckedupdates == nil or lastcheckedupdates <= os.time() - timer.days(7) then
        checkforupdates()
    end

end

local function module_menu()
    local updatetitles = { [true] = "Install Update", [false] = "Check for Update..." }
    local updatefns = { [true] = updates.install, [false] = checkforupdates }
    local hasupdate = (updates.newversion ~= nil)

    return {
        { title = updatetitles[hasupdate], fn = updatefns[hasupdate] },
    }
end

return {
    init = module_init,
    menu = module_menu
}