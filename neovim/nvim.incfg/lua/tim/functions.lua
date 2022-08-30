local M = {}

M.clear_all_registers = function(str)
  for c in str:gmatch '.' do
    vim.fn.setreg(c, '')
  end
end

M.clear_alpha_registers = function()
  local lowercase_alphas = 'abcdefghijklmnopqrstuvwxyz'
  M.cl_regs(lowercase_alphas)
end

return M
