return {
  -- Add Go to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "go",
        "gomod",
        "gowork",
        "gosum",
      })
    end,
  },

  -- Optional: Add Go-specific colorscheme
  -- Uncomment one of these if you want a better Go color scheme:

  -- Option 1: TokyoNight (great contrast and Go support)
  -- { "folke/tokyonight.nvim" },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "tokyonight-night",
  --   },
  -- },

  -- Option 2: Catppuccin (softer colors, excellent semantic highlighting)
  -- { "catppuccin/nvim", name = "catppuccin" },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "catppuccin-mocha",
  --   },
  -- },

  -- Option 3: Gruvbox Material (warm, easy on eyes)
  -- { "sainnhe/gruvbox-material" },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "gruvbox-material",
  --   },
  -- },
}
