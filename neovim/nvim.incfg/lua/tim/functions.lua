local M = {}

M.cl_regs = function(str)
  for c in str:gmatch '.' do
    vim.fn.setreg(c, '')
  end
end

M.cl_alpha_regs = function()
  local lowercase_alphas = 'abcdefghijklmnopqrstuvwxyz'
  M.cl_regs(lowercase_alphas)
end

return M
