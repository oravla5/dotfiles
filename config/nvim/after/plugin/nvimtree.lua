-- Protected module import
local nvim_tree_status_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_status_ok then
    return
end
print('[after/plugin/nvim-tree.lua] INFO: Configuring nvim-tree')

nvim_tree.setup {
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                -- Directory navigation
                { key = "gi", action = "cd" },                  -- Go into selected directory
                { key = "gu", action = "dir_up" },              -- Go up one directory
                -- Open files
                { key = "o", action = "edit" },                 -- Open file
                { key = "io", action = "edit_in_place" },       -- Open file in place
                { key = "ho", action = "split" },               -- Open file horizontally splitting the window
                { key = "vo", action = "vsplit" },              -- Open file vertially splitting the window
                -- File manipulation
                { key = "r", action = "rename" },               -- Rename file
                { key = "c", action = "copy" },                 -- Copy file / directory
                { key = "x", action = "cut" },                  -- Cut file / directory
                { key = "p", action = "paste" },                -- Paste file / directory
                { key = "a", action = "add" },                  -- Create / add file (or directory leaving a '/' at the end)
                { key = "d", action = "remove" },               -- Remove file
                -- Toggle visibility
                { key = "td", action = "toggle_dotfiles" },     -- Toggle visibility of dotfiles
                { key = "tg", action = "toggle_git_ignored" },  -- Toggle visibility of dotfiles
                -- Tree collapse / expand
                { key = "te", action = "expand_all" },          -- Expand full directory tree
                { key = "tc", action = "collapse_all" },        -- Collapse full directory tree
            },
        },
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = false,
    },
}
