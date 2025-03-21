local awful = require'awful'
local hotkeys_popup = require 'awful.hotkeys_popup'
require 'awful.hotkeys_popup.keys'
local menubar = require 'menubar'

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
     awful.key({
	 	modifiers = {mod.super, mod.shift},
	 	key = 's',
	 	description = 'area screenshot',
	 	group = 'client',
	 	on_press = function() awful.spawn.with_shell("sh /home/metodico/.config/awesome/scripts/screenselect.sh") 
      end,
     }),
     awful.key({
    		key = 'Print',
    		description = 'full screenshot',
    		group = 'client',
    		on_press = function() awful.spawn.with_shell('maim $HOME/Pictures/Screenshot/$(date +%Y%m%d_%H%M%S).png && xclip -selection clipboard -target image/png -i $HOME/Pictures/Screenshot/$(date +%Y%m%d_%H%M%S).png') end,
     }),
   }
end)
