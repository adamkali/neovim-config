vim.g.mapleader = " "
vim.g.maplocalleader = "<BS>"
vim.cmd([[set noswapfile]])
vim.cmd([[hi @lsp.type.number gui=italic]])
vim.opt.conceallevel = 2
vim.opt.nu = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.showmode = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.undofile = true
vim.opt.winborder = "rounded"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.showtabline = 0
vim.opt.signcolumn = "yes"
vim.opt.expandtab = false
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.number = true
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.opt.wrap = true
vim.opt.wrap = true
-- dont let esc in normal move the cursor down 
vim.opt.relativenumber = true

vim.keymap.set("n", "<esc>", "<esc>")

-- Use this as the general python interpreter

vim.g.python3_host_prog = "/usr/bin/python4.12"
vim.cmd [[set guifont=Maple\ Mono\ NF:h20]]
