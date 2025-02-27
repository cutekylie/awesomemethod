local awful = require'awful'
local beautiful = require'beautiful'
local wibox = require'wibox'
local dpi = beautiful.xresources.apply_dpi

local helpers = require'config.helpers'
local apps = require'config.apps'

local alacritty = wibox.widget {
    {
        id = 'icon',
        widget = wibox.widget.imagebox,
        image  = "/home/user/.config/awesome/ui/dock/alacritty.png",
    },
    layout = wibox.layout.fixed.horizontal
}

alacritty:buttons(awful.util.table.join(
    awful.button({}, 1, function()
        awful.spawn("alacritty")
    end)
))

local zenbrowser = wibox.widget {
    {
        id = 'icon',
        widget = wibox.widget.imagebox,
        image  = "/home/user/.config/awesome/ui/dock/zenbrowser.png",
    },
    layout = wibox.layout.fixed.horizontal
}

zenbrowser:buttons(awful.util.table.join(
    awful.button({}, 1, function()
        awful.spawn("zen-browser")
    end)
))

local thunar = wibox.widget {
    {
        id = 'icon',
        widget = wibox.widget.imagebox,
        image  = "/home/user/.config/awesome/ui/dock/thunar.png",
    },
    layout = wibox.layout.fixed.horizontal
}

thunar:buttons(awful.util.table.join(
    awful.button({}, 1, function()
        awful.spawn("thunar")
    end)
))

local discord = wibox.widget {
    {
        id = 'icon',
        widget = wibox.widget.imagebox,
        image  = "/home/user/.config/awesome/ui/dock/discord.png",
    },
    layout = wibox.layout.fixed.horizontal
}

discord:buttons(awful.util.table.join(
    awful.button({}, 1, function()
        awful.spawn("discord")
    end)
))

local alacritty = wibox.container.margin(alacritty, dpi(5), dpi(5), dpi(5), dpi(5))
local zenbrowser = wibox.container.margin(zenbrowser, dpi(5), dpi(5), dpi(5), dpi(5))
local thunar = wibox.container.margin(thunar, dpi(5), dpi(5), dpi(5), dpi(5))
local discord = wibox.container.margin(discord, dpi(5), dpi(5), dpi(5), dpi(5))

screen.connect_signal('request::desktop_decoration', function(s)

    s.mainbar = awful.wibar({
        screen = s,
        position = "bottom",
        width = dpi(240),
        height = dpi(60),
        stretch = false,
        ontop = true,
        visible = true,
    }):setup {
        layout = wibox.layout.fixed.horizontal,
        alacritty,
        zenbrowser,
        thunar,
        discord,
    }

end)
