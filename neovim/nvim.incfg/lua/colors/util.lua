local M = {}

M.set_rainbow = function(colors)
  for i = 1, #colors do
    vim.cmd('highlight rainbowcol' .. i .. ' guifg=' .. colors[i])
  end
end

M.highlight = function(group, color)
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

    vim.cmd(hl_cmd)
  end
end

return M
