-- Define colorscheme and load configuration
local colorscheme = "catppuccin"
pcall(require, colorscheme .. "-config.lua")

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    return
end
