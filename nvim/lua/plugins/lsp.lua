local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Mason setup
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- Mason LSP Config
require("mason-lspconfig").setup({
	ensure_installed = {
		"ts_ls",
		"gopls",
		"lua_ls",
		"html",
		"cssls",
		"jsonls",
		"svelte",
		"astro",
		"tailwindcss",
		"emmet_ls",
	},
	automatic_installation = true,
})

-- LSP Keymaps
local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, silent = true }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "E", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	-- Format on <Space>p
	vim.keymap.set("n", "<Space>p", function()
		vim.lsp.buf.format({ async = true })
	end, { silent = true, desc = "Format File" })
end

-- Setup LSP servers
local lspconfig = require("lspconfig")
for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
	lspconfig[server].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end
