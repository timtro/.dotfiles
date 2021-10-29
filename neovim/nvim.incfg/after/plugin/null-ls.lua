require('null-ls').config {
  sources = { require('null-ls').builtins.formatting.stylua },
}

require('lspconfig')['null-ls'].setup {}
