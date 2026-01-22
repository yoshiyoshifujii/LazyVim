-- Lean4 support for Neovim
return {
  -- Lean4 plugin with LSP, syntax highlighting, and more
  {
    "Julian/lean.nvim",
    event = { "BufReadPre *.lean", "BufNewFile *.lean" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      -- LSP configuration
      lsp = {
        -- Automatically start Lean LSP when opening .lean files
        on_attach = function(client, bufnr)
          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

          -- Key mappings for Lean
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        end,
      },

      -- Abbreviations
      abbreviations = {
        -- Enable unicode input with backslash
        enable = true,
        -- Use backslash as the leader for abbreviations
        leader = "\\",
      },

      -- Infoview configuration
      infoview = {
        -- Automatically open the Lean infoview on file open
        autoopen = true,
        -- Width of the infoview window
        width = 50,
        -- Height (only used if horizontal is true)
        height = 20,
        -- Open infoview in a horizontal split
        horizontal = false,
        -- Show types of all hypotheses
        indicators = "auto",
      },

      -- Progress bars for Lean compilation
      progress_bars = {
        enable = true,
        priority = 10,
      },

      -- Mappings
      mappings = true,
    },
    config = function(_, opts)
      require("lean").setup(opts)
    end,
  },

  -- Note: Lean4 doesn't have official treesitter support yet
  -- The lean.nvim plugin provides its own syntax highlighting via LSP

  -- LSP configuration for Lean
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Lean4 language server
        -- Note: lean.nvim handles the LSP setup, so we don't need to configure it here
        -- This is just a placeholder to ensure it's recognized
        leanls = {},
      },
    },
  },

  -- Optional: Better colorscheme for Lean (uncomment one if desired)
  -- Catppuccin has excellent support for LSP semantic tokens
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   opts = {
  --     flavour = "mocha", -- latte, frappe, macchiato, mocha
  --     integrations = {
  --       treesitter = true,
  --       native_lsp = {
  --         enabled = true,
  --         virtual_text = {
  --           errors = { "italic" },
  --           hints = { "italic" },
  --           warnings = { "italic" },
  --           information = { "italic" },
  --         },
  --         underlines = {
  --           errors = { "underline" },
  --           hints = { "underline" },
  --           warnings = { "underline" },
  --           information = { "underline" },
  --         },
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "catppuccin",
  --   },
  -- },
}
