return {
  {
    -- Automatically sets up LSP, so lsp.lua doesn't include rust.
    -- Makes debugging work seamlessly.
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended by module.
    ft = "rust",
    lazy = false,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },

  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup({
        completion = {
          cmp = {
            enabled = true,
          },
        },
      })
      require("cmp").setup.buffer({
        sources = { { name = "crates" } },
      })
    end,
  },
}
