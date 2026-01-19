-- Completely disable auto-formatting
return {
  -- Disable conform.nvim auto-format
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      format_on_save = false,
    },
  },
  -- Disable LSP formatting
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.autoformat = false
      -- Disable formatting capability for all LSP servers
      local on_attach = opts.on_attach
      opts.on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        if on_attach then
          on_attach(client, bufnr)
        end
      end
      return opts
    end,
  },
}
