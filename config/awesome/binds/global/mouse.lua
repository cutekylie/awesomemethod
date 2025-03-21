local awful = require'awful'
local naughty = require("naughty")
local widgets = require'ui.bar'
local apps = require'config.apps'

-- Definisci il menu principale
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

-- Aggiungi i binding del mouse
awful.mouse.append_global_mousebindings({
    awful.button({
        modifiers = {},
        button = 4,
        on_press = awful.tag.viewprev
    }),
    awful.button({
        modifiers = {},
        button = 5,
        on_press = awful.tag.viewnext
    }),
    awful.button({
        modifiers = {},
        button = 3, -- Tasto destro del mouse
        on_press = function() mainmenu:show() end,
    }),
})
