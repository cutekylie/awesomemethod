local _M = {}

local awful = require'awful'

_M.layouts = {
   awful.layout.suit.tile,
   awful.layout.suit.floating,
}

_M.tags = {'1', '2'}

return _M
