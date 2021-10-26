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
vim.g.python3_host_prog = '/usr/bin/python3'
-- vim.g.mapleader = '\''
-- vim.opt.scrolloff = 8

vim.opt.undofile = true -- Persistent undo
vim.cmd("set undodir=$HOME/tmp/vimundo")

vim.opt.list = true -- show tabs, eol and trailing spaces.
vim.opt.listchars = {
  -- eol = '↲',
  tab = '↹ ',
  trail = '·'
}

require'packer_bootstrap'

local color_opts = require 'colors.dejour'
color_opts.setup()

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand '%:p:h'
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

require 'plugins'
require 'keymappings'
