-- LSP configuration overrides for LazyVim

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Automatically install LSP servers
      ensure_installed = {
        "kotlin_language_server",
      },
      servers = {
        -- Example: Lua language server settings
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },

        -- Add servers you want enabled here. Examples:
        tsserver = {},

        -- Go language server with enhanced semantic highlighting
        gopls = {
          settings = {
            gopls = {
              semanticTokens = true,
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
            },
          },
        },

        -- Kotlin language server
        kotlin_language_server = {},
        -- pyright = {},
      },
    },
  },
}
