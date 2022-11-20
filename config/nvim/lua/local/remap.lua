local nnoremap = require("local.keymap").nnoremap
local vnoremap = require("local.keymap").vnoremap
local inoremap = require("local.keymap").inoremap

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

-- Navigate buffers
nnoremap("<S-l>", ":bnext<CR>")
nnoremap("<S-h>", ":bprevious<CR>")

-- Buffer manipulation
nnoremap("<leader>w", ":w<CR>") -- Save changes in current buffer
nnoremap("<leader>W", ":wa<CR>") -- Save changes in all buffers
nnoremap("<leader>q", ":wq<CR>") -- Close current buffer saving changes
nnoremap("<leader>Q", ":q!<CR>") -- Close current buffer discarding changes

-- Exiting nvim
nnoremap("<leader>x", ":wqa<CR>") -- Close nvim saving all changes
nnoremap("<leader>X", ":qa!<CR>") -- Close nvim discarding all changes

-- NvimTree bindings
nnoremap("<leader>ec", "<cmd>NvimTreeClose<CR>")
nnoremap("<leader>ee", "<cmd>NvimTreeFocus<CR>")

-- Telescope
nnoremap("<leader>t",
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{ previewer = false })<CR>")
nnoremap("<leader>T", "<cmd>Telescope live_grep<CR>")

-- LSP
nnoremap("<leader>f", ":Format<CR>")


-- Insert mode
-- Press jk fast to exist insert mode
inoremap("qq", "<ESC>")
inoremap("jk", "<ESC>")
inoremap("kj", "<ESC>")

-- Visual mode
-- Stay in indent mode
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Move text up and down
vnoremap("<A-k>", ":m .-2<CR>==")
vnoremap("<A-j>", ":m .+1<CR>==")
