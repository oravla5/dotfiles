function exists(file)
    local f=io.open(file,"r")
    if f~=nil then io.close(f) return true else return false end
end
-- set termguicolors to enable highlight groups
--vim.opt.termguicolors = true

-- empty setup using defaults
local cfgFile = string.format("%s/.config/nvim/.nvim_configured", os.getenv("HOME"))
if exists(cfgFile) then
    --require("nvim-tree").setup()
    require'nvim-tree'.setup({
        sort_by = "case_sensitive",
        view = {
          adaptive_size = true,
          mappings = {
            list = {
              { key = "u", action = "dir_up" },
              { key = "h<CR>", action = "split" },
              { key = "v<CR>", action = "vsplit" },
            },
          },
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
    })
end
