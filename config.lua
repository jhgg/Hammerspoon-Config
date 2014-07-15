local config = {}

config.modules = {
    "arrangement",
    "monitors",
    "repl",
    "updates",
    "reload",
    "arrows"
}

-- Maps monitor id -> screen index.
config.monitors = {
    autodiscover = true,
    rows = 2
}

config.autolaunch = true

-- Window arrangements.
config.arrangements = {
    {
        name = "zen",
        alert = true,
        mash = { "cmd", "ctrl", "alt" },
        key = "A",
        arrangement = {
            {
                app_title = "^Mail",
                monitor = 1,
                position = "full"
            },
            {
                app_title = "^Slack",
                monitor = 4,
                position = "left"
            },
            {
                app_title = "^Messages",
                monitor = 4,
                position = function(d)
                    return d:translate_from('bottom_right', {
                        y = 42,
                        h = -40
                    })
                end
            },
            {
                app_title = "^Skype",
                monitor = 4,
                position = "top_right"
            },
            {
                app_title = "^Spotify",
                monitor = 6,
                position = "full"
            }
        }
    }
}

return config