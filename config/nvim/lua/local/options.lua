vim.opt.guicursor = ""

vim.opt.clipboard = "unnamedplus"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

vim.g.mapleader = " "

-- disable netrw since nvim-tree is used
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
