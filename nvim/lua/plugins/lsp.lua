-- capabilities (cmp)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Mason UI
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- Mason LSP ensure
require("mason-lspconfig").setup({
	ensure_installed = {
		"ts_ls",
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

-- Keymaps on_attach
local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, silent = true }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "E", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<Space>p", function()
		vim.lsp.buf.format({ async = true })
	end, { silent = true, desc = "Format File" })
end

-- --------- TypeScript SDK resolver (no -D required) ----------
local uv = vim.loop
local function is_dir(p)
	if not p or p == "" then
		return false
	end
	local st = uv.fs_stat(p)
	return st and st.type == "directory"
end
local function is_file(p)
	if not p or p == "" then
		return false
	end
	local st = uv.fs_stat(p)
	return st and st.type == "file"
end
local function join(...)
	return table.concat({ ... }, "/")
end

-- Try in this order:
-- 1) project local ./node_modules/typescript/lib (if present)
-- 2) pnpm global   $(pnpm root -g)/typescript/lib  (works fine under Volta)
-- 3) Mason package <stdpath("data")>/mason/packages/typescript/(node_modules|lib/node_modules)/typescript/lib
-- 4) npm  global   $(npm root -g)/typescript/lib
local function resolve_tsdk()
	local project = "./node_modules/typescript/lib"
	if is_dir(project) and is_file(join(project, "tsserverlibrary.js")) then
		return project
	end

	local function safe_cmd(cmd)
		local ok, out = pcall(vim.fn.system, cmd)
		if not ok then
			return nil
		end
		out = vim.fn.trim(out or "")
		if out == "" then
			return nil
		end
		return out
	end

	local pnpm_root = safe_cmd("pnpm root -g")
	local pnpm_tsdk = pnpm_root and join(pnpm_root, "typescript/lib") or nil
	if is_dir(pnpm_tsdk) and is_file(join(pnpm_tsdk, "tsserverlibrary.js")) then
		return pnpm_tsdk
	end

	local mason_base = vim.fn.stdpath("data") .. "/mason/packages/typescript"
	local mason_a = join(mason_base, "node_modules/typescript/lib")
	local mason_b = join(mason_base, "lib/node_modules/typescript/lib")
	if is_dir(mason_a) and is_file(join(mason_a, "tsserverlibrary.js")) then
		return mason_a
	end
	if is_dir(mason_b) and is_file(join(mason_b, "tsserverlibrary.js")) then
		return mason_b
	end

	local npm_root = safe_cmd("npm root -g")
	local npm_tsdk = npm_root and join(npm_root, "typescript/lib") or nil
	if is_dir(npm_tsdk) and is_file(join(npm_tsdk, "tsserverlibrary.js")) then
		return npm_tsdk
	end

	return nil -- last resort; LSP will complain if nothing found
end

local tsdk = resolve_tsdk()

-- --------- Configure servers with the new API (NVIM 0.11+) ----------
local function base_opts(extra)
	return vim.tbl_deep_extend("force", {
		capabilities = capabilities,
		on_attach = on_attach,
	}, extra or {})
end

-- ts_ls (typescript-language-server) with explicit tsdk
vim.lsp.config(
	"ts_ls",
	base_opts({
		init_options = {
			typescript = {
				tsdk = tsdk, -- must contain tsserverlibrary.js
			},
		},
	})
)

-- other servers (no special options needed here; add if you like)
vim.lsp.config("gopls", base_opts())
vim.lsp.config("lua_ls", base_opts())
vim.lsp.config("html", base_opts())
vim.lsp.config("cssls", base_opts())
vim.lsp.config("jsonls", base_opts())
vim.lsp.config("svelte", base_opts())
vim.lsp.config("astro", base_opts())
vim.lsp.config("tailwindcss", base_opts())
vim.lsp.config("emmet_ls", base_opts())

-- enable them (lazy start by filetype)
for _, name in ipairs({
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
}) do
	vim.lsp.enable(name)
end
