local awful = require'awful'

screen.connect_signal('request::desktop_decoration', function(s)

    tag.connect_signal('request::default_layouts', function()
        awful.layout.append_default_layouts({
            awful.layout.suit.tile,
            awful.layout.suit.floating, 
        })
    end)

    awful.tag({" "," "," "," "}, s , awful.layout.layouts[1])

end)
