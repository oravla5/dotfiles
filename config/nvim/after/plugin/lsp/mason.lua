local mason_status_ok, mason = pcall(require, 'mason')
local mason_config_status_ok, mason_config = pcall(require, 'mason-lspconfig')
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")

if not (mason_status_ok or mason_config_status_ok or lspconfig_status_ok) then
    return
end


local servers = {
	"sumneko_lua",
    "clangd",
	-- "cssls",
	-- "html",
	-- "tsserver",
	-- "pyright",
	-- "bashls",
	"jsonls",
	-- "yamlls",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        },
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

mason.setup(settings)
mason_config.setup({
	ensure_installed = servers,
	automatic_installation = true,
})


local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("lsp.handlers").on_attach,
		capabilities = require("lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "lsp.settings" .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
