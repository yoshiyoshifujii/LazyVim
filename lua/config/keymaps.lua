-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Use ; for command-line
map({ "n", "x", "o" }, ";", ":")

-- Clipboard paste in insert mode
map("i", "<C-p>", '<Esc>"*pa', { silent = true })

-- Copy current file absolute path to clipboard
map("n", "<leader>yp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.fn.setreg("*", path)
  print("Copied: " .. path)
end, { desc = "Yank file path", silent = true })

-- Movement
map("n", "h", "<Left>")
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "l", "<Right>")
map("n", "<Down>", "gj")
map("n", "<Up>", "gk")
map({ "n", "x", "o" }, "0", "^")

-- Insert mode cursor movement
map("i", "<C-e>", "<End>")
map("i", "<C-a>", "<Home>")

-- Page move
map("n", "<Space>j", "<C-f>")
map("n", "<Space>k", "<C-b>")

-- Buffer navigation
map("n", "<F2>", ":bp<CR>", { silent = true })
map("n", "<F3>", ":bn<CR>", { silent = true })
map("n", "<F4>", ":bnext | bdelete #<CR>", { silent = true })

-- Window movement
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-h>", "<C-w>h")

-- Last changed text selection (avoid LazyVim comment mapping on gc)
map("n", "gC", "`[v`]")
map("x", "gC", "<C-u>normal gC<CR>")
map("o", "gC", "<C-u>normal gC<CR>")

-- Yank word under cursor
map("n", "vy", "vawy")

-- Visual mode: v selects to line end
map("x", "v", "$h")

-- Search helpers
map("n", "<ESC><ESC>", ":nohlsearch<CR>", { silent = true })
map("n", "s*", function()
  return ":%substitute/\\<" .. vim.fn.expand("<cword>") .. "\\>/"
end, { expr = true })

-- Tags navigation
map("n", "t", "<Nop>")
map("n", "tt", "<C-]>")
map("n", "tj", ":tag<CR>", { silent = true })
map("n", "tk", ":pop<CR>", { silent = true })
map("n", "tl", ":tags<CR>", { silent = true })

-- Matching brackets
map("n", "(", "%")
map("n", ")", "%")

-- Undo breakpoints
map("i", "<C-u>", "<C-g>u<C-u>")
map("i", "<C-w>", "<C-g>u<C-w>")

-- Insert: jj to escape
map("i", "jj", "<Esc>")

-- Yank to line end/head
map("n", "y9", "y$")
map("n", "y0", "y^")

-- JSON format
map("n", "<Leader>j", "!python -m json.tool<CR>", { silent = true })

-- Visual paste without overwriting register
map("x", "p", '"_dP')

-- Diff-aware gf
local function do_git_diff_aware_gf(command)
  local target_path = vim.fn.expand("<cfile>")
  if target_path:match("^[ab]/") then
    if vim.fn.filereadable(target_path) == 1 or vim.fn.isdirectory(target_path) == 1 then
      return command
    end
    local pos = vim.fn.searchpos("\\f+", "cenW")
    local col = pos[2] or 0
    local move = "v" .. tostring(#target_path - 3) .. "h"
    return tostring(col) .. "|" .. move .. command
  end
  return command
end

map("n", "gf", function()
  return do_git_diff_aware_gf("gf")
end, { expr = true })
map("n", "gF", function()
  return do_git_diff_aware_gf("gF")
end, { expr = true })
map("n", "<C-w>f", function()
  return do_git_diff_aware_gf("<C-w>f")
end, { expr = true })
map("n", "<C-w><C-f>", function()
  return do_git_diff_aware_gf("<C-w><C-f>")
end, { expr = true })
map("n", "<C-w>F", function()
  return do_git_diff_aware_gf("<C-w>F")
end, { expr = true })
map("n", "<C-w>gf", function()
  return do_git_diff_aware_gf("<C-w>gf")
end, { expr = true })
map("n", "<C-w>gF", function()
  return do_git_diff_aware_gf("<C-w>gF")
end, { expr = true })

-- Toggle quickfix window
local function toggle_qf_window()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "quickfix" then
      vim.cmd("cclose")
      return
    end
  end
  vim.cmd("botright cwindow")
end

map("n", "cw", toggle_qf_window, { silent = true })

vim.cmd([[
  xnoremap <silent> // y/\V<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
  xnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>
]])
