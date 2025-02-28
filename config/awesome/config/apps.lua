local _M = {
   terminal    = os.getenv('TERMINAL') or 'alacritty',
   editor      = os.getenv('EDITOR')   or 'nvim',
   browser     = 'zen-browser',
   nitrogen    = 'nitrogen',
   files       = 'thunar',
   vscode      = 'code'
}

_M.editor_cmd = _M.terminal .. ' -e ' .. _M.editor
_M.manual_cmd = _M.terminal .. ' -e man awesome'

return _M
