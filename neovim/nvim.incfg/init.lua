-- vim.opt.nocompatible = true
vim.opt.encoding = 'utf-8'
vim.opt.mouse = 'a'
vim.opt.textwidth = 80
vim.opt.colorcolumn = {81}
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.enc = 'utf-8'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.autoindent = true
vim.opt.backspace={'indent' , 'eol', 'start'}
vim.opt.confirm = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.scrolloff = 8

-- show tabs, eol and trailing spaces.
vim.opt.list = true
vim.opt.listchars = {
  -- eol = '↲',
  tab = '↹ ',
  trail = '·'
}

-- Persistent undo
vim.opt.undofile = true
vim.cmd("set undodir=$HOME/tmp/vimundo")
                    -- Done in vimscript b/c $HOME or ~ won't expand in lua

vim.g.python3_host_prog = '/usr/bin/python3'

local color_opts = require 'colors.dejour'
require 'keymappings'
require 'plugins'

require('lualine').setup{
   options = {
      theme = color_opts.status_theme,
      icons_enabled = 1,
     section_separators = {'', ''},
     component_separators = {'', ''},
   }
}
