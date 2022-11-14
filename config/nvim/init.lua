require("local")

print("[nvim/init.lua] - Initializing neovim")
package.path = os.getenv("HOME") .. "/.config/nvim/after/plugin/?.lua;" .. package.path
