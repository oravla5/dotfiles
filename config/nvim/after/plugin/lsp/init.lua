-- Protected call
local lsp_config_ok, _ = pcall(require, 'lspconfig')
if not lsp_config_ok then
    return
end

print('[after/plugin/lsp/init.lua] INFO: Configuring LSP')
require('lsp.mason')
require('lsp.handlers').setup()
