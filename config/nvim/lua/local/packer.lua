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
packer.init {
    display = {
        open_fcn = function()
            return require('packer.util').float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    use 'wbthomason/packer.nvim'    -- Have packer manage itself
    use 'nvim-lua/popup.nvim'       -- An implementation of the Popup API from the vim in Neovim
    use "nvim-lua/plenary.nvim"     -- Useful lua functions used by lots of plugins
    use 'nvim-tree/nvim-web-devicons'
    use {'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',  -- optional, for file icons
        },
        tag = 'nightly' -- updated every week
    }

    -- Colorschemes
    use 'folke/tokyonight.nvim'

    -- cmp plugins
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

    -- LSP
    use 'neovim/nvim-lspconfig'             -- enable LSP
    use 'williamboman/mason.nvim'           -- simple to use language server installer
    use 'williamboman/mason-lspconfig.nvim' -- 

    -- Telescope 
    use {'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        }
    }
    use 'nvim-telescope/telescope-media-files.nvim'

end)
