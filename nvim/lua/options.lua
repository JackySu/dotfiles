require "nvchad.options"

-- add yours here!

vim.o.cursorlineopt ='both' -- to enable cursorline!

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})

vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({0}), {0})

local lspconfig = require("lspconfig")

lspconfig.ruff.setup {}
lspconfig.pyright.setup {}
lspconfig.clangd.setup {}
lspconfig.ts_ls.setup {}
