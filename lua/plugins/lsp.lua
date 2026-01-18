-- LSP configuration overrides for LazyVim

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
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
        -- tsserver = {},
        -- gopls = {},
        -- pyright = {},
      },
    },
  },
}
