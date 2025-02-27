local awful = require'awful'
local beautiful = require'beautiful'
local wibox = require'wibox'
local dpi = beautiful.xresources.apply_dpi

local controlcenter = require("ui.controlcenter")
local cairo = require("lgi").cairo
local helpers = require'config.helpers'
local apps = require'config.apps'

local awesomemenu = {
   {'reload', awesome.restart},
   {'end', awesome.quit},
}

local mainmenu = awful.menu{
   items = {
    {'awesome', awesomemenu},
    {'vscode', apps.vscode},
    {'files', apps.files},
    {'browser', apps.browser},
    {'wallpaper', apps.nitrogen},
    {'terminal', apps.terminal}
   }
}

local clock_widget = wibox.widget {
    {
        format = '%H:%M',
        widget = wibox.widget.textclock
    },
    bg = beautiful.bg_normal,
    fg = beautiful.fg_focus,
    widget = wibox.container.background
}

local date_widget = wibox.widget {
    {
        format = '%d/%m/%Y',
        widget = wibox.widget.textclock
    },
    bg = beautiful.bg_normal,
    fg = beautiful.fg_focus,
    widget = wibox.container.background
}

local time_date_widget = wibox.widget {
    {
        clock_widget,
        align = "center",
        widget = wibox.container.place
    },
    date_widget,
    layout = wibox.layout.fixed.vertical,
}

local clock_container = wibox.container.margin(time_date_widget, dpi(10), dpi(10), dpi(5), dpi(5))

local launcher = wibox.container.margin(awful.widget.launcher{
   image = beautiful.awesome_icon,
   menu = mainmenu
}, dpi(10), dpi(10), dpi(10), dpi(10))

local function create_popup_button(popup)
    local button = wibox.widget {
        text = "  ",
        widget = wibox.widget.textbox,
    }

    button:buttons(awful.util.table.join(
        awful.button({}, 1, function()
            popup.visible = not popup.visible
        end)
    ))

    return button
end

screen.connect_signal('request::desktop_decoration', function(s)

    s.taglist = awful.widget.taglist {
        screen = s,
        filter  = awful.widget.taglist.filter.all,
        widget_template = {
            {
                {
                    id = "text_role",
                    widget = wibox.widget.textbox
                },
                margins = {left = dpi(3), right = dpi(13), top = dpi(2), bottom = dpi(2)},
                widget = wibox.container.margin
            },
            layout = wibox.layout.align.horizontal
        },
    }

    s.tasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        widget_template = {
            {
                {
                    {
                        {
                            id = "text_role",
                            forced_width = dpi(150),
                            widget = wibox.widget.textbox,
                        },
                        margins = { right = dpi(15) },
                        widget = wibox.container.margin,
                    },
                    layout = wibox.layout.align.horizontal
                },
                halign = "center",
                widget = wibox.container.place
            },
            id     = "background_role",
            widget = wibox.container.background
        },
        buttons = {
            awful.button({}, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end)
        },
    }

    local systray = wibox.widget.systray()
    systray:set_base_size(20)

    local systray_container = wibox.container.margin(systray, dpi(5), dpi(5), dpi(5), dpi(5))

    local popup = controlcenter.create_popup()
    local popup_button = create_popup_button(popup)

    s.mainbar = awful.wibar({
        screen = s,
        position = "top",
        height = dpi(45),
        stretch = true,
        margins = { top = 0 },
    }):setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            launcher,
            s.taglist,
        },
        {
            s.tasklist,
            margins = dpi(11),
            widget = wibox.container.margin
        },
        {
            layout = wibox.layout.fixed.horizontal,
            {
                layout = wibox.container.place,
                systray_container,
            },
            popup_button,
            clock_container,
        },
    }

end)
