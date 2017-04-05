local config = {}

config.modules = {
    "arrangement",
    "monitors",
    "repl",
    "reload",
    "arrows",
    "lock",
    "fullscreen"
}

-- Maps monitor id -> screen index.
config.monitors = {
    autodiscover = true,
    rows = 2
}

config.autolaunch = true

-- Window arrangements.
config.arrangements = {
    fuzzySearch = {
        mash = {"cmd", "ctrl", "alt"},
        key = "Z"
    },
    {
        name = "zen",
        alert = true,
        mash = { "cmd", "ctrl", "alt" },
        key = "A",
        arrangement = {
            {
                appTitle = "^Mail",
                monitor = 1,
                position = "full_screen",
            },
            {
                appTitle = "^Slack",
                monitor = 4,
                position = "left"
            },
            {
                appTitle = "^Messages",
                monitor = 4,
                position = function(d)
                    return d:translate_from('bottom_right', {
                        y = 42,
                        h = -40
                    })
                end
            },
            {
                appTitle = "^ChronoMate",
                monitor = 4,
                position = function(d)
                    return d:translate_from('top_right', {
                        h = 42
                    })
                end
            },
            {
                appTitle = "^Spotify",
                monitor = 6,
                position = "full_screen",
            }
        }
    }
}

return config