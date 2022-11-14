-- Protected call
local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
    return
end

print('[after/plugin/lsp/init.lua] INFO: Configuring LSP')
require('lsp.lsp-installer')
require('lsp.handlers').setup()
