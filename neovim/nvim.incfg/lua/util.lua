local M = {}

M.create_augroup = function(autocmds, name)
  vim.cmd('augroup ' .. name)
  vim.cmd 'autocmd!'

  for _, autocmd in ipairs(autocmds) do
    vim.cmd('autocmd ' .. table.concat(autocmd, ' '))
  end

  vim.cmd 'augroup END'
end

function M.create_buf_augroup(autocmds, name, bufnr)
  local buftext

  vim.cmd('augroup ' .. name)

  if bufnr then
    buftext = string.format('<buffer=%d>', bufnr)
  else
    buftext = '<buffer>'
  end

  vim.cmd('autocmd! * ' .. buftext)

  for _, autocmd in ipairs(autocmds) do
    vim.cmd(
      string.format(
        'autocmd %s %s %s',
        autocmd[1],
        buftext,
        table.concat(autocmd, ' ', 2)
      )
    )
  end

  vim.cmd 'augroup END'
end

return M
