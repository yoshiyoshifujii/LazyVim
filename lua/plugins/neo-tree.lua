-- Neo-tree configuration
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- false = hide filtered items, true = show but dimmed
          hide_dotfiles = false,
          hide_gitignored = false, -- true = hide gitignored files
          hide_by_name = {
            -- "node_modules"
          },
          hide_by_pattern = {
            -- "*.meta",
            -- "*/src/*/tsconfig.json",
          },
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
      },
    },
  },
}
