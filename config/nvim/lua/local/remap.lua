local nnoremap = require("local.keymap").nnoremap
local vnoremap = require("local.keymap").vnoremap
local inoremap = require("local.keymap").inoremap

-- NvimTree bindings
nnoremap("<leader>ec", "<cmd>NvimTreeClose<CR>")
nnoremap("<leader>ee", "<cmd>NvimTreeFocus<CR>")

-- Normal mode
-- Better windows navigation
nnoremap("<A-h>", "<C-w>h")
nnoremap("<A-j>", "<C-w>j")
nnoremap("<A-k>", "<C-w>k")
nnoremap("<A-l>", "<C-w>l")

-- Resize widnows with arrows
nnoremap("<C-Up>", ":resize -1<CR>")
nnoremap("<C-Down", ":resize +1<CR>")
nnoremap("<C-Left>", ":vertical resize -1<CR>")
nnoremap("<C-Right>", ":vertical resize +-<CR>")

-- Move text up and down
nnoremap("<C-j>", ":m .+1<CR>==")
nnoremap("<C-k>", ":m .-2<CR>==")

-- Telescope
nnoremap("<leader>f", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{ previewer = false })<CR>")
nnoremap("<leader>F", "<cmd>Telescope live_grep<CR>")
-- Insert mode
-- Press jk fast to exist insert mode
inoremap("jk", "<ESC>")
inoremap("kj", "<ESC>")

-- Visual mode
-- Stay in indent mode
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Move text up and down
vnoremap("<A-k>", ":m .-2<CR>==")
vnoremap("<A-j>", ":m .+1<CR>==")

