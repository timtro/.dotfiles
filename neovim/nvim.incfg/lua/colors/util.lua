local M = {}

M.set_rainbow = function(colors)
  for i = 1, #colors do
    local s = 'highlight default rainbowcol' .. i .. ' guifg=' .. colors[i]
    vim.cmd(s)
  end
end

M.highlight_cmd = function(group, color)
  if color.link then
    vim.cmd('highlight! link ' .. group .. ' ' .. color.link)
  else
    local style = color.style and 'gui=' .. color.style or 'gui=NONE'
    local fg = color.fg and 'guifg=' .. color.fg or 'guifg=NONE'
    local bg = color.bg and 'guibg=' .. color.bg or 'guibg=NONE'
    local sp = color.sp and 'guisp=' .. color.sp or ''

    local hl_cmd = 'highlight '
      .. group
      .. ' '
      .. style
      .. ' '
      .. fg
      .. ' '
      .. bg
      .. ' '
      .. sp

    return hl_cmd
  end
end

return M
