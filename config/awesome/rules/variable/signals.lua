local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

client.connect_signal("manage", function(c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("request::titlebars", function(c)
    local titlebar_height = 40

    local buttons = gears.table.join(
        awful.button({}, 1, function()
            c:activate{context = "titlebar", action = "mouse_move"}
        end),
        awful.button({}, 3, function()
            c:activate{context = "titlebar", action = "mouse_resize"}
        end)
    )

    awful.titlebar(c, {
        position = "top",
        size = titlebar_height,
    }):setup {
        {
            {
                awful.titlebar.widget.iconwidget(c),
                margins = 10,
                widget = wibox.container.margin
            },
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal
        },
        {
            {
                awful.titlebar.widget.titlewidget(c),
                buttons = buttons,
                forced_width = 2000,
                layout = wibox.layout.flex.horizontal
            },
            layout = wibox.layout.align.horizontal
        },
        {
            {
                wibox.widget.imagebox("/home/metodico/.config/awesome/theme/icons/close2.png"),
                resize = true,
                widget = wibox.container.background
            },
            buttons = gears.table.join(
                awful.button({}, 1, function() c:kill() end)
            ),
            layout = wibox.layout.fixed.horizontal,
        },
        layout = wibox.layout.align.horizontal,
        widget = wibox.container.background
    }
end)