local awful = require'awful'
local beautiful = require'beautiful'
local wibox = require'wibox'
local gears = require'gears'
local dpi = beautiful.xresources.apply_dpi

local function create_popup()
    -- Creazione di un widget per il contenuto del popup
    local keybinds_widget = wibox.widget {
        {
            widget = wibox.widget.textbox,
            text = "Keybinds: (Note that Mod4 is WindowsKey)\n",
            align = "left",
            valign = "top",
            font = "monospace 12",
        },
        {
            widget = wibox.widget.textbox,
            text =  "Mod4 + A: Reload Awesome\n" ..
                    "Mod4 + Q: Close the active window\n" ..
                    "Mod4 + T: Terminal\n" ..
                    "Mod4 + R: Applications Launcher\n" ..
                    "Mod4 + {1, 2, 3, ...}: Change Workspace\n" ..
                    "Mod4 + Shift + {1, 2, 3, ...}: Switch window's workspace\n" ..

                    "\nPrint: Take an entire screenshot\n" ..
                    "Mod4 + Shift + S: Take an area screenshot \n" ..

                    "\nMod4 + B: Run Zen Browser\n" ..
                    "Mod4 + E: Run file manager",
            align = "left",
            valign = "top",
            font = "monospace 12",
        },
        layout = wibox.layout.fixed.vertical,
    }

    local popup = awful.popup {
        widget = {
            {
                widget = wibox.container.margin,
                keybinds_widget,
                margins = dpi(10),
            },
            layout = wibox.layout.fixed.vertical,
        },
        border_width = 1,
        border_color = beautiful.border_normal,
        placement = function(c)
            awful.placement.top_right(c, { margins = { top = 50, right = 90 } })
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