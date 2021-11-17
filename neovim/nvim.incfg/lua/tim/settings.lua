-- vim: fdm=marker:fdc=1
vim.opt.encoding = 'utf-8'
vim.opt.mouse = 'a'
vim.opt.textwidth = 80
-- vim.opt.colorcolumn = '81'
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.autoindent = true
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.confirm = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.foldmethod = 'manual'
vim.opt.foldcolumn = '0'
vim.opt.fillchars = {
  fold = ' ',
  eob = ' ',
  diff = '╱', -- default: '-'; alt: '⣿' '░' '─';
  msgsep = '‾',
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸',
}
vim.opt.list = true -- show tabs, eol and trailing spaces.
vim.opt.listchars = {
  -- eol = '↲',
  tab = '↹ ',
  trail = '·',
}

vim.opt.undofile = true -- Persistent undo
vim.cmd 'set undodir=$HOME/tmp/vimundo'

vim.g.python3_host_prog = '/usr/bin/python3'

-- Columns 80 and above are imbued with diagnostic colors:
-- TODO: Set up command to toggle this.
vim.cmd [[:match DiagnosticVirtualTextWarn "\%81v."]]
vim.cmd [[:2match DiagnosticVirtualTextError "\%>81v."]]

-- TODO: The following module should probably get moved, or my settings will be
-- reset every time this is 'required'?

-- Settings Module {{{
-- Functions for toggling and cycling options.
local M = {}

local foldcolumn_states = {
  ['0'] = { next = '1' },
  ['1'] = { next = '2' },
  ['2'] = { next = '0' },
}

function M.cycle_fold_col()
  local curfold = vim.api.nvim_win_get_option(0, 'foldcolumn')

  if tonumber(curfold) > 2 then
    curfold = '2'
  end

  vim.opt.foldcolumn = foldcolumn_states[curfold].next

  require 'notify'(
    'foldcolumn is set to ' .. vim.api.nvim_win_get_option(0, 'foldcolumn'),
    'info',
    { title = 'Window Option Update:' }
  )
end

return M
-- }}}
