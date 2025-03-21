local awful = require'awful'
local beautiful = require'beautiful'
local wibox = require'wibox'
local gears = require'gears'
local dpi = beautiful.xresources.apply_dpi

local function create_popup()
    local profile_image = wibox.widget {
        image = os.getenv("HOME") .. "/.config/awesome/theme/icons/pfp.png",
        resize = true,
        forced_width = dpi(150),
        forced_height = dpi(150),
        clip_shape = gears.shape.circle,
        widget = wibox.widget.imagebox,
    }

    local volume_text = wibox.widget {
        text = "Volume Slider",
        widget = wibox.widget.textbox, 
    }

    local volume_slider = wibox.widget {
        bar_shape = gears.shape.rectangle,
        bar_height = dpi(4),
        handle_shape = gears.shape.circle,
        handle_width = dpi(10),
        handle_color = beautiful.fg_focus,
        maximum = 100,
        value = 50,
        widget = wibox.widget.slider,
    }

    volume_slider.forced_width = dpi(200)
    volume_slider.forced_height = dpi(20)

    volume_slider:connect_signal("property::value", function(_, value)
        local volume_value = value .. "%"
        awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ " .. volume_value)
    end)

    local logout_button = wibox.widget {
        {
            markup = '<span font="Nerd Font; 50">󰍃 </span>',
            widget = wibox.widget.textbox,
        },
        buttons = awful.util.table.join(
            awful.button({}, 1, function() awesome.quit() end)
        ),
        layout = wibox.layout.fixed.horizontal,
    }

    local reboot_button = wibox.widget {
        {
            markup = '<span font="Nerd Font; 50">󰑓 </span>',
            widget = wibox.widget.textbox,
        },
        buttons = awful.util.table.join(
            awful.button({}, 1, function() awful.spawn("systemctl reboot") end)
        ),
        layout = wibox.layout.fixed.horizontal,
    }

    local shutdown_button = wibox.widget {
        {
            markup = '<span font="Nerd Font; 50"> </span>',
            widget = wibox.widget.textbox,
        },
        buttons = awful.util.table.join(
            awful.button({}, 1, function() awful.spawn("systemctl poweroff") end)
        ),
        layout = wibox.layout.fixed.horizontal,
    }

    local button_layout = wibox.widget {
        {
            profile_image,
            margins = dpi(20),
            widget = wibox.container.margin,
        },
        {
            shutdown_button,
            reboot_button,
            logout_button,
            layout = wibox.layout.fixed.horizontal,
        },
        layout = wibox.layout.align.horizontal,
    }

    local popup = awful.popup {
        widget = {
            {
                button_layout,
                widget = wibox.container.margin,
            },
            {
                volume_text,
                volume_slider,
                margins = dpi(20),
                widget = wibox.container.margin,
            },
            layout = wibox.layout.fixed.vertical,
        },
        border_width = 1,
        border_color = beautiful.border_normal,
        placement = function(c)
            awful.placement.top_right(c, { margins = { top = 50, right = 10 } })
        end,
        visible = false,
        ontop = true,
        bg = "#121212",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, dpi(10)) 
        end,
        forced_width = dpi(400),
        forced_height = dpi(250),
    }

    return popup
end

return {
    create_popup = create_popup,
}