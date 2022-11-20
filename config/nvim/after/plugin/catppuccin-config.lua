local catppuccin_status_ok, catppuccin = pcall(require, "catppuccin")
if not catppuccin_status_ok then
    return
end

-- Compile catppuccin configuration on save
local augroup = vim.api.nvim_create_augroup("CatppuccinCompiler", {})
vim.api.nvim_create_autocmd("BufWritePost", {
    group = augroup,
    pattern = "catppuccin-config.lua",
    callback = function()
        catppuccin.compile()
        if vim.g.colors_name == "catppuccin" then
            vim.cmd("source %")
            vim.cmd("colorscheme catppuccin")
        end
    end,
})

catppuccin.setup({
    compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    term_colors = true,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})
