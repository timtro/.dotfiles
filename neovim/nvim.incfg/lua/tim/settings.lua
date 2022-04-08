-- Settings, options and a module for toggling and cycling.
-- vim: fdm=marker:fdc=1

vim.opt.encoding = 'utf-8'
vim.opt.hidden = true
vim.opt.mouse = 'a'
vim.opt.inccommand = 'split'
vim.opt.laststatus = 3

-- width, tabbing, indenting and wrapping.
vim.opt.textwidth = 80
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.autoindent = true
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.confirm = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.fillchars = {
  fold = ' ',
  eob = ' ',
  diff = '╱', -- default: '-'; alt: '⣿' '░' '─';
  msgsep = '‾',
  foldopen = '▼',
  foldsep = '┊',
  foldclose = '▶',
}
vim.opt.list = true -- show tabs, eol and trailing spaces.
vim.opt.listchars = {
  -- eol = '↲',
  tab = '↹ ',
  trail = '·',
}

-- Folding (with Treesitter)
vim.opt.foldcolumn = '3'
vim.opt.foldmethod = 'marker'
-- vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 3
vim.opt.foldminlines = 5

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

-- Persistent undo
vim.opt.undofile = true
vim.cmd 'set undodir=$HOME/tmp/vimundo'

-- Hidden buffers to switch buffers without saving
vim.opt.hidden = true

-- Columns 80 and above are imbued with diagnostic colors:
-- TODO: Set up command to toggle this.
vim.cmd [[:match DiagnosticVirtualTextWarn "\%81v."]]
-- vim.cmd [[:2match DiagnosticVirtualTextError "\%>81v."]]

vim.g.python3_host_prog = '/usr/bin/python3'

-- TODO: The following module should probably get moved, or my settings will be
-- reset every time this is 'required'?

-- Settings Module {{{
-- Functions for toggling and cycling options.
local M = {}

local foldcolumn_states = {
  ['0'] = { next = '1' },
  ['1'] = { next = '2' },
  ['2'] = { next = '3' },
  ['3'] = { next = '0' },
}

function M.cycle_fold_col()
  local curfold = vim.api.nvim_win_get_option(0, 'foldcolumn')

  if tonumber(curfold) > 3 then
    curfold = '3'
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
