-- Protected module import
local nvim_tree_status_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_status_ok then
    return
end
print('[after/plugin/nvim-tree.lua] INFO: Configuring nvim-tree')

nvim_tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {
        "startify",
        "dashboard",
        "alpha",
    },
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        timeout = 500,
    },
    sort_by = "case_sensitive",
    filters = {
        dotfiles = false,
    },
    view = {
        adaptive_size = true,
        width = 30,
        hide_root_folder = false,
        side = "left",
        number = false,
        relativenumber = false,
        mappings = {
            custom_only = false,
            list = {
                -- Directory navigation
                { key = "gi", action = "cd" },                  -- Go into selected directory
                { key = "gu", action = "dir_up" },              -- Go up one directory
                { key = "h", action = "close_node" },           -- Go up one directory
                -- Open files
                { key = { "l", "<CR>", "o" }, action = "edit" },-- Open file
                { key = "io", action = "edit_in_place" },       -- Open file in place
                { key = "oh", action = "split" },               -- Open file horizontally splitting the window
                { key = {"v", "ov"}, action = "vsplit" },       -- Open file vertially splitting the window
                -- File manipulation
                { key = "r", action = "rename" },               -- Rename file
                { key = "c", action = "copy" },                 -- Copy file / directory
                { key = "x", action = "cut" },                  -- Cut file / directory
                { key = "p", action = "paste" },                -- Paste file / directory
                { key = "a", action = "create" },               -- Create / add file (or directory leaving a '/' at the end)
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
        highlight_git = true,
        icons = {
            show = {
                git = true,
                folder = true,
                file = true,
                folder_arrow = true,
            },
            glyphs = {
                default = "",
            symlink = "",
            bookmark = "",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    deleted = "",
                    untracked = "U",
                    ignored = "◌",
                },
            },
        },
    },
}
