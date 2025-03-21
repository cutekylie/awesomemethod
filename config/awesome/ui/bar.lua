local awful = require'awful'
local beautiful = require'beautiful'
local wibox = require'wibox'
local dpi = beautiful.xresources.apply_dpi
local gears = require'gears'

local systray_popup = require("ui.systray")
local cheatsheet_popup = require("ui.cheatsheet") 
local controlcenter_popup = require("ui.controlcenter")
local cairo = require("lgi").cairo
local helpers = require'config.helpers'
local apps = require'config.apps'

-- Clock widget
local clock_widget = wibox.widget {
    {
        format = '%I:%M %p',
        widget = wibox.widget.textclock,
        font = "SF Pro Display Bold 11", 
    },
    fg = beautiful.fg_focus,
    widget = wibox.container.background
}

-- Taglist widget
local taglist = awful.widget.taglist {
    screen = awful.screen.focused(),
    filter = awful.widget.taglist.filter.all,
    style = {
        shape = gears.shape.rounded_rect,
    },
    widget_template = {
        {
            {
                id = 'text_role',
                widget = wibox.widget.textbox,
            },
            margins = dpi(2),
            widget = wibox.container.margin,
        },
        widget = wibox.container.background,
    },
}

local function create_widget_with_border(widget)
    local widget_with_padding = wibox.container.margin(widget, dpi(10), dpi(10), dpi(8), dpi(8))
    local widget_with_border = wibox.container.background(widget_with_padding, "#1a1a1a")
    widget_with_border.shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 12)
    end
    widget_with_border.bg = "#1a1a1a"
    return wibox.container.margin(widget_with_border, dpi(5), dpi(5), dpi(5), dpi(5))
end

local taglist_with_margin = create_widget_with_border(taglist)
local clock_with_margin = create_widget_with_border(clock_widget)

local function create_systray_button(systray)
    local button = wibox.widget {
        image = os.getenv("HOME") .. "/.config/awesome/theme/icons/systray_popup.png",
        widget = wibox.widget.imagebox,
    }

    button:buttons(awful.util.table.join(
        awful.button({}, 1, function()
            systray.visible = not systray.visible
        end)
    ))

    return create_widget_with_border(button)
end

local function create_cheatsheet_button(cheatsheet)
    local button = wibox.widget {
        image = os.getenv("HOME") .. "/.config/awesome/theme/icons/keyboard.png",
        widget = wibox.widget.imagebox,
    }

    button:buttons(awful.util.table.join(
        awful.button({}, 1, function()
            cheatsheet.visible = not cheatsheet.visible
        end)
    ))
    return create_widget_with_border(button)
end

local function create_controlcenter_button(controlcenter)
    local button = wibox.widget {
        image = os.getenv("HOME") .. "/.config/awesome/theme/icons/controlcenter.png",
        widget = wibox.widget.imagebox,
    }

    button:buttons(awful.util.table.join(
        awful.button({}, 1, function()
            controlcenter.visible = not controlcenter.visible
        end)
    ))
    return create_widget_with_border(button)
end

screen.connect_signal('request::desktop_decoration', function(s)

    s.mainbar = awful.wibar({
        screen = s,
        position = "top",
        height = dpi(45),
        visible = true,
        ontop = false,
        stretch = true,
        bg = beautiful.bg_normal,
    })

    local systray = systray_popup.create_popup()
    local systray_button = create_systray_button(systray)

    local cheatsheet = cheatsheet_popup.create_popup()
    local cheatsheet_button = create_cheatsheet_button(cheatsheet)

    local controlcenter = controlcenter_popup.create_popup()
    local controlcenter_button = create_controlcenter_button(controlcenter)

    s.mainbar:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            taglist_with_margin,
        },
        {
            layout = wibox.layout.fixed.horizontal,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            cheatsheet_button,
            systray_button,
            controlcenter_button,
            clock_with_margin,
        },
    }
end)
