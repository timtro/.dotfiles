local M = {}

-- Borrowed from:
-- https://gitlab.com/jrop/dotfiles/-/blob/303e0f2a34a45b54b033c02aa8c3ad654fae09da/.config/nvim/lua/my/utils.lua#L17
local buf_vtext = function()
  local a_orig = vim.fn.getreg('a')
  local mode = vim.fn.mode()
  if mode ~= 'v' and mode ~= 'V' then
    vim.cmd([[normal! gv]])
  end
  vim.cmd([[silent! normal! "aygv]])
  local text = vim.fn.getreg('a')
  vim.fn.setreg('a', a_orig)
  return text
end

M.test = function()
  local bibentry = buf_vtext()
end

return M
