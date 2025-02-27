local gears = require("gears")
local beautiful = require("beautiful")

-- Impostazioni del tema
local theme = {}

-- Altezza della titlebar
theme.titlebar_height = 40

-- Colori della titlebar
theme.titlebar_bg_normal = "#121212"
theme.titlebar_bg_focus = "#121212"

-- Icone dei pulsanti
theme.titlebar_close_button_normal = "/home/user/.config/awesome/theme/icons/titlebar/close.svg"
theme.titlebar_close_button_focus = "/home/user/.config/awesome/theme/icons/titlebar/close.svg"
theme.titlebar_minimize_button_normal = "/home/user/.config/awesome/theme/icons/titlebar/inac.svg"
theme.titlebar_minimize_button_focus = "/home/user/.config/awesome/theme/icons/titlebar/inac.svg"
theme.titlebar_maximize_button_normal = "/home/user/.config/awesome/theme/icons/titlebar/max.svg"
theme.titlebar_maximize_button_focus = "/home/user/.config/awesome/theme/icons/titlebar/max.svg"

-- Altre impostazioni del tema
theme.font = "sans 10"
theme.bg_normal = "#152126"
theme.fg_normal = "#d3dae3"

-- Restituisce il tema
return theme