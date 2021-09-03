return function(colors)
  for i = 1, #colors do
      local s = "highlight default rainbowcol"
          .. i
          .. " guifg="
          .. colors[i]
      vim.cmd(s)
  end
end
