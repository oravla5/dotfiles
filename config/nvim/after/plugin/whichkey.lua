local status_ok, which_key = pcall(require, "which-key")

if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local normal_leader_opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local normal_leader_mappings = {
    ["a"] = { "<CMD>Alpha<CR>", "Alpha" },
    ["b"] = {
        "<CMD>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
        "Buffers",
    },
    e = {
        name = "Explorer",
        e = { "<CMD>NvimTreeFocus<CR>", "Focus on Explorer" },
        c = { "<CMD>NvimTreeClose<CR>", "Close Explorer" },
    },
    ["f"] = {
        "<CMD>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{ previewer = false })<CR>",
        "Find files"
    },
    ["F"] = { "<CMD>Telescope live_grep theme=ivy<CR>", "Find text" },
    g = {
        name = "Git",
        l = { "<CMD>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
        o = { "<CMD>Telescope git_status<CR>", "Open changed file" },
        b = { "<CMD>Telescope git_branches<CR>", "Checkout branch" },
        c = { "<CMD>Telescope git_commits<CR>", "Checkout commit" },
        d = { "<CMD>Gitsigns diffthis HEAD<CR>", "Diff" },
    },
    l = {
        name = "LSP",
        a = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
        d = { "<CMD>Telescope diagnostics bufnr=0<CR>", "Document Diagnostics" },
        w = { "<CMD>Telescope diagnostics<CR>", "Workspace Diagnostics" },
        f = { "<CMD>lua vim.lsp.buf.format{async=true}<CR>", "Format" },
        i = { "<CMD>LspInfo<CR>", "Info" },
        I = { "<CMD>LspInstallInfo<CR>", "Installer Info" },
        j = { "<CMD>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostics" },
        k = { "<CMD>lua vim.diagnostic.goto_prev()<CR>", "Previous Diagnostics" },
        l = { "<CMD> lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
        q = { "<CMD>lua vim.diagnostic.setloclist()<CR>", "Quickfix" },
        r = { "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename" },
        s = { "<CMD>Telescope lsp_document_symbols<CR>", "Document Symbols" },
        S = { "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols" },
    },
    p = {
        name = "Packer",
        c = { "<CMD>PackerCompile<CR>", "Compile" },
        i = { "<CMD>PackerInstall<CR>", "Install" },
        s = { "<CMD>PackerSync<CR>", "Sync" },
        S = { "<CMD>PackerStatus<CR>", "Status" },
        u = { "<CMD>PackerUpdate<CR>", "Update" },
    },
    s = {
        name = "Search",
        b = { "<CMD>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<CMD>Telescope colorscheme<cr>", "Colorscheme" },
        h = { "<CMD>Telescope help_tags<cr>", "Find Help" },
        M = { "<CMD>Telescope man_pages<cr>", "Man Pages" },
        r = { "<CMD>Telescope oldfiles<cr>", "Open Recent File" },
        R = { "<CMD>Telescope registers<cr>", "Registers" },
        k = { "<CMD>Telescope keymaps<cr>", "Keymaps" },
        C = { "<CMD>Telescope commands<cr>", "Commands" },
    },
    t = {
        name = "Terminal",
        f = { "<CMD>ToggleTerm direction=float<CR>", "Float" },
        h = { "<CMD>ToggleTerm direction=horizontal<CR>", "Horizontal" },
        v = { "<CMD>ToggleTerm direction=vertical<CR>", "Vertical" },
    },
    ["w"] = { "<CMD>w<CR>", "Save changes in current buffer." },
    ["W"] = { "<CMD>wa<CR>", "Save changes in all open buffers" },
    ["q"] = { "<CMD>w<CR><cmd>Bdelete<CR>", "Close current buffer saving changes (keeps window open)." },
    ["Q"] = { "<CMD>Bdelete!<CR>", "Close current buffer discarding changes" },
    ["x"] = { "<CMD>wqa<CR>", "Close Neovim saving all changes" },
    ["X"] = { "<CMD>qa!<CR>", "Close Neovim discarding all changes" },
}

which_key.setup(setup)
which_key.register(normal_leader_mappings, normal_leader_opts)
