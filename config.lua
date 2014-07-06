
local config = {}


-- Maps monitor id -> screen index.
config.monitors = {
    [1] = 2,
    [2] = 1,
    [3] = 3,
    [4] = 5,
    [5] = 6,
    [6] = 4
}

config.arrangements = {}

-- Arrangement to use.
config.arrangements.default = {
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

return config