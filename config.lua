local config = {}

config.modules = {
    "arrangement",
    "monitors",
    "repl",
    "updates",
    "reload"
}

-- Maps monitor id -> screen index.
config.monitors = {
    [1] = 2,
    [2] = 1,
    [3] = 3,
    [4] = 5,
    [5] = 6,
    [6] = 4
}

config.autolaunch = true

-- Window arrangements.
config.arrangements = {
    {
        mods = { "cmd", "ctrl", "alt" },
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
                position = "bottom_right"
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