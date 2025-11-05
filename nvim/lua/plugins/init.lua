return {
  -- add gruvbox
  -- { "ellisonleao/gruvbox.nvim" },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- use mini.starter instead of alpha
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  {
    "JackySu/bamboo.nvim",
    branch = "fix_not_transparent_bufferline",
    lazy = false,
    priority = 2047,
    config = function()
      require("bamboo").setup({
        transparent = true,
        -- dim_inactive = true,
        lualine = {
          transparent = true,
        },
        colors = {
          purple = "#1ac8ca", -- override purple with cyan
        },
        code_style = {
          comments = {
            italic = true --[[, bold = true ]],
          },
          conditions = {
            italic = true --[[, bold = true ]],
          },
          parameters = {
            italic = true --[[, bold = true ]],
          },
          keywords = {
            italic = true,
            bold = true,
          },
        },
        diagnostics = {
          darker = true,
          undercurl = true,
        },
      })
      require("bamboo").load()
    end,
  },

  {
    "LazyVim/LazyVim",
    -- opts = {
    --   colorscheme = "bamboo",
    -- },
  },
  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
  -- { "folke/trouble.nvim", enabled = false },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      -- init = function()
      --   require("lazyvim.util").lsp.on_attach(function(_, buffer)
      --     -- stylua: ignore
      --     vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
      --     vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
      --   end)
      -- end,
    },
    ---@class PluginLspOpts
    opts = {
      diagnostics = {
        underline = true,
        virtual_text = false,
        virtual_lines = { current_line = false },
      },
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
        stylua = { enabled = false },
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          -- ---@type LazyKeysSpec[]
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    keys = {
      {
        "<leader>co",
        "<cmd>TypescriptOrganizeImports<CR>",
        desc = "Organize Imports",
        ft = { "typescript", "typescriptreact" },
      },
      {
        "<leader>cR",
        "<cmd>TypescriptRenameFile<CR>",
        desc = "Rename File",
        ft = { "typescript", "typescriptreact" },
      },
    },
  },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "HiPhish/rainbow-delimiters.nvim" },
    opts = function(_, opts)
      -- add rainbow to treesitter
      opts.rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
      }
    end,
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        -- append more languages to install
        "rust",
        "haskell",
        "go",
        "c",
        "cpp",
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },

  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
      }
    end,
  },
  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "rust-analyzer",
        "pyright",
        "clangd",
        "lua-language-server",
        "typescript-language-server",
      },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    lazy = false,
    enabled = true,
    opts = {
      panel = {
        auto_refresh = true,
        layout = {
          position = "right",
          ratio = 0.3,
        },
      },
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
        },
      },
    },
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "ghost",
        enable_on_insert = true,
        multilines = {
          enabled = true,
        },
      })
    end,
  },

  {
    "folke/snacks.nvim",
    opts = {
      indent = {
        enabled = true,
        char = " ",
      },
    },
  },
  {
    "eero-lehtinen/oklch-color-picker.nvim",
    event = "VeryLazy",
    version = "*",
    keys = {
      {
        "<leader>v",
        function()
          require("oklch-color-picker").pick_under_cursor()
        end,
        desc = "Pick color under cursor",
      },
    },
    ---@type oklch.Opts
    opts = {
      highlight = {
        style = "virtual_left",
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    opts = function()
      Snacks.toggle({
        name = "Indention Guides",
        get = function()
          return require("ibl.config").get_config(0).enabled
        end,
        set = function(state)
          require("ibl").setup_buffer(0, { enabled = state })
        end,
      }):map("<leader>ug")

      return {
        indent = {
          char = "╎",
          tab_char = " ",
        },
        scope = { show_start = false, show_end = false },
        exclude = {
          filetypes = {
            "Trouble",
            "alpha",
            "dashboard",
            "help",
            "lazy",
            "mason",
            "neo-tree",
            "notify",
            "snacks_dashboard",
            "snacks_notif",
            "snacks_terminal",
            "snacks_win",
            "toggleterm",
            "trouble",
          },
        },
      }
    end,
    main = "ibl",
  },

  -- -- disable indent-blankline
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = "LazyFile",
  --   opts = {
  --     scope = { enabled = false },
  --   },
  -- },

  {
    "Mr-LLLLL/cool-chunk.nvim",
    event = { "BufReadPost", "BufNewFile" }, -- Changed from BufReadPre
    ft = { -- Only load for specific filetypes
      "lua",
      "python",
      "javascript",
      "typescript",
      "rust",
      "go",
      "c",
      "cpp",
      "java",
      "json",
      "yaml",
      "html",
      "css",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("cool-chunk").setup({

        chunk = {
          priority = 1,
          exclude_filetypes = {
            -- LazyVim special buffers
            "snacks_picker_list",
            "snacks_dashboard",
            "snacks_notif",
            "snacks_terminal",

            -- Common exclusions
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
            "prompt",
            "TelescopePrompt",
            "nofile",
            "terminal",

            -- ignore nvim-dap breakpoint symbols
            "DapBreakpoint",
          },
        },
        line_num = {
          notify = false,
          enable = false, -- Disable line_num feature entirely
        },
      })
    end,
  },
}
