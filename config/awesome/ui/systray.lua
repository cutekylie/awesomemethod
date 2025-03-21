local awful = require'awful'
local beautiful = require'beautiful'
local wibox = require'wibox'
local gears = require'gears'
local dpi = beautiful.xresources.apply_dpi

local function create_popup()
    local systray = wibox.widget.systray()
    systray:set_base_size(35)

    local popup = awful.popup {
        widget = {
            {
                widget = wibox.container.margin,
                systray,
            },
            {
                widget = wibox.container.margin,
            },
            layout = wibox.layout.fixed.vertical,
        },
        border_width = 1,
        border_color = beautiful.border_normal,
        placement = function(c)
            awful.placement.top_right(c, { margins = { top = 50, right = 135 } })
        end,
        visible = false,
        ontop = true,
        bg = "#121212",
        forced_width = dpi(400),
        forced_height = dpi(250),
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, dpi(10))  -- Modifica il valore di dpi(10) per cambiare il raggio degli angoli
        end,
    }

    return popup
end

return {
    create_popup = create_popup,
}