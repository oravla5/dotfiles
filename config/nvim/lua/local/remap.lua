local nnoremap = require("local.keymap").nnoremap

nnoremap("<leader>ee", "<cmd>NvimTreeToggle<CR>")
nnoremap("<leader>fe", "<cmd>NvimTreeFocus<CR>")

-- Windows navigation
nnoremap("<A-h>", "<C-w>h")
nnoremap("<A-j>", "<C-w>j")
nnoremap("<A-k>", "<C-w>k")
nnoremap("<A-l>", "<C-w>l")
