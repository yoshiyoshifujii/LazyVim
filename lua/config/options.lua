-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.relativenumber = false
opt.number = true
opt.scrolloff = 5
opt.textwidth = 0
opt.backup = false
opt.writebackup = false
opt.autoread = true
opt.swapfile = false
opt.undofile = false
opt.hidden = true
opt.backspace = "indent,eol,start"
opt.formatoptions = "lmoq"
opt.visualbell = true
opt.errorbells = false
opt.belloff = "all"
opt.whichwrap = "b,s,h,l,<,>,[,]"
opt.showcmd = true
opt.showmode = true
opt.modelines = 0
opt.mouse = "a"
opt.clipboard = "unnamedplus,unnamed"
opt.ruler = true
opt.laststatus = 2
opt.wildmenu = true
opt.wildchar = 9
opt.wildmode = "list:full"
opt.history = 1000
opt.complete:append("k")
opt.wrapscan = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.showmatch = true
opt.list = true
opt.listchars = { tab = ">.", trail = "_", extends = ">", precedes = "<" }
opt.display = "uhex"
opt.lazyredraw = true
opt.autoindent = true
opt.smartindent = true
opt.cindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 0
opt.expandtab = true
opt.autochdir = true
opt.tags = "tags;"
opt.tagbsearch = false
opt.fileformats = { "unix", "dos", "mac" }
opt.suffixes = ".bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc"
opt.virtualedit:append("block")
