-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost packer.lua source <afile> | PackerSync
    augroup end
]]

-- Protected call
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init ({
    display = {
        open_fcn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup({
    function(use)
        use "wbthomason/packer.nvim"        -- Have packer manage itself
        use "nvim-lua/plenary.nvim"         -- Useful lua functions used by lots of plugins
        use "nvim-lua/popup.nvim"           -- An implementation of the Popup API from the vim in Neovim
        use 'nvim-tree/nvim-web-devicons'   -- optional, for file icons
        use 'nvim-tree/nvim-tree.lua'       -- File explorer
        use "windwp/nvim-autopairs"         -- Autopairs, integrates with both cmp and treesitter
        use "numToStr/Comment.nvim"         -- Easily comment stuff
        --[[ use "akinsho/bufferline.nvim" ]]
        --[[ use "moll/vim-bbye" ]]

        -- Colorschemes
        use 'folke/tokyonight.nvim'

        -- CMP plugins (autocompletion)
        use 'hrsh7th/nvim-cmp'          -- The completion plugin
        use 'hrsh7th/cmp-buffer'        -- buffer completions
        use 'hrsh7th/cmp-path'          -- path completions
        use 'hrsh7th/cmp-cmdline'       -- cmdline completions
        use 'saadparwaiz1/cmp_luasnip'  -- snippet completions
        use 'hrsh7th/cmp-nvim-lsp'      -- source for neovim's built-in language server client
        use 'hrsh7th/cmp-nvim-lua'      -- source for neovim Lua API

        -- snippets
        use 'L3MON4D3/LuaSnip'  -- snippet engine
        use 'rafamadriz/friendly-snippets' -- a bunch of snippets to use

        -- LSP (language autocompletion
        use 'neovim/nvim-lspconfig'             -- enable LSP
        use 'williamboman/mason.nvim'           -- simple to use language server installer
        use 'williamboman/mason-lspconfig.nvim' -- 
        use "jose-elias-alvarez/null-ls.nvim"   -- 

        -- Telescope (find files)
        use "nvim-telescope/telescope.nvim"
        use "nvim-telescope/telescope-media-files.nvim"

        -- Treesitter (syntax highlighting)
        use {
            "nvim-treesitter/nvim-treesitter",
            run = function()
                local ts_update = require('nvim-treesitter.install').update({with_sync = true})
                ts_update()
            end,
        }
        use "p00f/nvim-ts-rainbow"  -- parentheses and delimiters highlighting
        use "JoosepAlviste/nvim-ts-context-commentstring"

        -- Git
        use "lewis6991/gitsigns.nvim"
    end,
    config = {
        opt_default = false,
    }
})

