-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Quickfix window helpers
autocmd("QuickFixCmdPost", {
  group = augroup("qf_autowin", { clear = true }),
  pattern = { "make", "grep", "grepadd", "vimgrep", "vimgrepadd" },
  command = "cwindow",
})

autocmd("QuickFixCmdPost", {
  group = augroup("lqf_autowin", { clear = true }),
  pattern = { "lmake", "lgrep", "lgrepadd", "lvimgrep", "lvimgrepadd" },
  command = "lwindow",
})

-- Restore cursor position
autocmd("BufReadPost", {
  group = augroup("restore_cursor", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lnum = mark[1]
    local col = mark[2]
    if lnum > 0 and lnum <= vim.api.nvim_buf_line_count(0) then
      pcall(vim.api.nvim_win_set_cursor, 0, { lnum, col })
    end
  end,
})

-- Filetype-specific indent
local function set_indent(sw, ts, sts, et)
  vim.opt_local.shiftwidth = sw
  vim.opt_local.tabstop = ts
  vim.opt_local.softtabstop = sts
  vim.opt_local.expandtab = et
end

autocmd("FileType", {
  group = augroup("filetype_indent", { clear = true }),
  pattern = { "apache", "aspvbs", "c", "cpp", "cs", "diff", "eruby", "java", "javascript", "perl", "php", "python", "sh", "sql", "vb", "wsh", "xhtml", "xml", "zsh" },
  callback = function()
    set_indent(4, 4, 4, true)
  end,
})

autocmd("FileType", {
  group = augroup("filetype_indent_two", { clear = true }),
  pattern = { "css", "html", "ruby", "haml", "yaml", "vim", "scala" },
  callback = function()
    set_indent(2, 2, 2, true)
  end,
})

-- XML: close tag completion
autocmd("FileType", {
  group = augroup("xml_close_tag", { clear = true }),
  pattern = "xml",
  callback = function()
    vim.keymap.set("i", "</", "</<C-x><C-o>", { buffer = true })
  end,
})

-- Quickfix window close mappings
autocmd("FileType", {
  group = augroup("qf_keymaps", { clear = true }),
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "q", ":cclose<CR>", { buffer = true })
    vim.keymap.set("n", "<ESC>", ":cclose<CR>", { buffer = true })
  end,
})

-- Highlight full-width spaces
autocmd({ "VimEnter", "ColorScheme" }, {
  group = augroup("zenkaku_space", { clear = true }),
  callback = function()
    vim.cmd("highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray")
    vim.cmd("match ZenkakuSpace /\\%u3000/")
  end,
})

-- User commands
vim.api.nvim_create_user_command("Ev", function()
  vim.cmd("edit " .. vim.env.MYVIMRC)
end, {})

vim.api.nvim_create_user_command("Rv", function()
  vim.cmd("source " .. vim.env.MYVIMRC)
end, {})

vim.api.nvim_create_user_command("Pt", function()
  vim.o.paste = not vim.o.paste
end, {})

vim.api.nvim_create_user_command("Bw", function()
  vim.cmd("bnext | bdelete #")
end, {})

vim.api.nvim_create_user_command("Cp932", function()
  vim.cmd("edit ++enc=cp932")
end, {})

vim.api.nvim_create_user_command("Eucjp", function()
  vim.cmd("edit ++enc=euc-jp")
end, {})

vim.api.nvim_create_user_command("Iso2022jp", function()
  vim.cmd("edit ++enc=iso-2022-jp")
end, {})

vim.api.nvim_create_user_command("Utf8", function()
  vim.cmd("edit ++enc=utf-8")
end, {})

vim.api.nvim_create_user_command("Jis", function()
  vim.cmd("Iso2022jp")
end, {})

vim.api.nvim_create_user_command("Sjis", function()
  vim.cmd("Cp932")
end, {})

-- Disable all LazyVim format on save autocmds
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    -- Delete LazyVim's format autocmd groups
    pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_format_on_save")
    pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_auto_format")
  end,
})
