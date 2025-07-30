-- lua/diagnostic_keymaps.lua
local M = {}

vim.diagnostic.config({
	virtual_text = false,
	signs = false,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

function M.setup()
	-- First, try to remove the default diagnostic mappings
	pcall(vim.keymap.del, "n", "<C-P>")
	pcall(vim.keymap.del, "n", "<C-N>")

	-- Set new diagnostic keymaps
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Prev Diagnostic" })
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Next Diagnostic" })
	vim.keymap.set(
		"n",
		"<leader>e",
		vim.diagnostic.open_float,
		{ noremap = true, silent = true, desc = "Show Diagnostic" }
	)
	vim.keymap.set(
		"n",
		"<leader>q",
		vim.diagnostic.setloclist,
		{ noremap = true, silent = true, desc = "Diagnostics List" }
	)
end

return M
