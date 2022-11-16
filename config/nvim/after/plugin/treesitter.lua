local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end

configs.setup {
    ensure_installed = { "bash", "c", "cpp", "javascript", "typescript", "tsx", "json", "lua", "python", "tsx", "css", "yaml", "markdown", "markdown_inline" },    -- one of 'all', 'maintained' (parsers with maintainers), or a list of languages
    sync_install = false,               -- install languages synchronously (only applied to `ensure_installed`
    ignore_install = { "" },            -- List of parsers to ignore installing
    autoparis = {
        enable = true,
    },
    highlight = {
        enable = true,                  -- false will disable the whole extension
        disable = { "" },               -- list of languages that will be disabled
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true,
        disable = { "yaml" }
    },
    rainbow = {
        enable = true,
        -- siable = { "jsx", "cpp" }, -- list of languages you want to disable the plugin for
        extended_mode = true,   -- Als highlight non-bracket delimiters like html tags, boolean or table: -> boolean
        max_file_lines = nil,   -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strins
        -- termcolors = {}, -- table of colour name strings
    },
}
