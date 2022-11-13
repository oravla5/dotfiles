function exists(file)
    local f=io.open(file,"r")
    if f~=nil then io.close(f) return true else return false end
end

local cfgFile = string.format("%s/.config/nvim/.nvim_configured", os.getenv("HOME"))
if exists(cfgFile) then
    print('[after/plugin/icons.lua] INFO: Configuring nvim-web-devicons')
    require'nvim-web-devicons'.setup {
        -- your personnal icons can go here (to override)
        -- you can specify color or cterm_color instead of specifying both of them
        -- DevIcon will be appended to `name`
        override = {
         zsh = {
           icon = "",
           color = "#428850",
           cterm_color = "65",
           name = "Zsh"
         }
        };
        -- globally enable different highlight colors per icon (default to true)
        -- if set to false all icons will have the default icon's color
        color_icons = true;
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true;
       }
end