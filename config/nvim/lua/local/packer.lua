-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use {'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',  -- optional, for file icons
        },
        tag = 'nightly' -- updated every week
    }
end)
