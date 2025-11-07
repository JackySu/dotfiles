function Installer_is_available_function(installer)
  return function()
    return vim.fn.executable(installer) == 1
  end
end

return {
  -- keep-sorted start block=yes

  {
    "mfussenegger/nvim-dap",
    lazy = true,
    -- Copied from LazyVim/lua/lazyvim/plugins/extras/dap/core.lua and
    -- modified.
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },

      -- conditional breakpoint
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Set Conditional Breakpoint",
      },

      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },

      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },

      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },

      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },

      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },

      {
        "<leader>dT",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
    },
    config = function()
      -- leave this blank to avoid loading default config
    end,
    -- dependencies = {
    --   {
    --     "igorlfs/nvim-dap-view",
    --     -- Alternative UI.  https://igorlfs.github.io/nvim-dap-view/keymaps
    --     ---@module 'dap-view'
    --     ---@type dapview.Config
    --     opts = {
    --       -- Automatically toggle dap-view windows when starting/stopping a
    --       -- session by pressing continue.
    --       auto_toggle = true,
    --     },
    --   },
    -- },
  },
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      layouts = {
        {
          elements = {
            -- Elements can be strings or table with id and size keys.
            { id = "scopes", size = 0.2 },
            { id = "breakpoints", size = 0.2 },
            { id = "stacks", size = 0.2 },
            { id = "watches", size = 0.4 },
          },
          size = 0.2, -- 20% columns
          position = "left",
        },
        {
          elements = {
            { id = "repl" },
            -- { id = "console", size = 0.65 },  -- Uncomment to enable console
          },
          size = 10,
          position = "bottom",
        },
      },
    },
    config = true,
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Dap UI",
      },
    },
    dependencies = {
      -- keep-sorted start block=yes
      {
        "jay-babu/mason-nvim-dap.nvim",
        ---@type MasonNvimDapSettings
        opts = {
          -- This line is essential to making automatic installation work
          -- :exploding-brain
          handlers = {},
          automatic_installation = false,
          -- DAP servers: these will be installed by mason-tool-installer.nvim
          -- for consistency.
          ensure_installed = {},
        },
        dependencies = {
          "mfussenegger/nvim-dap",
          "mason-org/mason.nvim",
        },
      },
      {
        "leoluz/nvim-dap-go",
        config = true,
        dependencies = {
          "mfussenegger/nvim-dap",
        },
        keys = {
          {
            "<leader>dt",
            function()
              require("dap-go").debug_test()
            end,
            desc = "Debug test",
          },
        },
      },
      {
        "mfussenegger/nvim-dap-python",
        lazy = true,
        cond = Installer_is_available_function("luarocks")(),
        config = function()
          -- debugpy is installed in my standard Python virtualenv so that it's
          -- available with all the other modules.
          require("dap-python").setup("python3")
        end,
        -- Consider the mappings at
        -- https://github.com/mfussenegger/nvim-dap-python?tab=readme-ov-file#mappings
        dependencies = {
          "mfussenegger/nvim-dap",
        },
      },
      {
        "nvim-neotest/nvim-nio",
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        config = true,
        dependencies = {
          "mfussenegger/nvim-dap",
        },
      },
      -- keep-sorted end
    },
  },
  -- keep-sorted end
}
