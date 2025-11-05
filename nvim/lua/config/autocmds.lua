-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- vim.api.nvim_set_hl(0, "Comment", { fg = "#808080", italic = true, link = "NonText" })
vim.cmd("hi DapBreakpointColor guifg=#fa4848")
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpointColor", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpointColor", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpointColor", linehl = "", numhl = "" })

vim.cmd("hi DapLogPointColor guifg=#61afef")
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPointColor", linehl = "", numhl = "" })
