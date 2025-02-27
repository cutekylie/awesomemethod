local awful = require'awful'

local mod = require'binds.mod'

client.connect_signal('request::default_keybindings', function()
   awful.keyboard.append_client_keybindings{
      awful.key{
         modifiers   = {mod.super},
         key         = 'f',
         description = 'toggle fullscreen',
         group       = 'client',
         on_press    = function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
         end,
      },
      awful.key{
         modifiers   = {mod.super},
         key         = 'q',
         description = 'close',
         group       = 'client',
         on_press    = function(c) c:kill() end,
      },
      awful.key{
         modifiers   = {mod.super},
         key         = 'h',
         description = 'minimize',
         group       = 'client',
         on_press    = function(c) c.minimized  = true end,
      },
      awful.key{
         modifiers   = {mod.super},
         key         = 's',
         description = '(un)maximize',
         group       = 'client',
         on_press    = function(c)
            c.maximized = not c.maximized
            c:raise()
         end,
      },
     awful.key{
	 	modifiers = {mod.super, mod.shift},
	 	key = 's',
	 	description = 'screenshot',
	 	group = 'client',
	 	on_press = function() awful.spawn.with_shell('flameshot gui') end,
      },
   }
end)
