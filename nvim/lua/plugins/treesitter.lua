local parsers = {
  "lua",
  "vim",
  "vimdoc",
  "query",
  "markdown",
  "markdown_inline",
  "html",
  "css",
  "scss",
  "javascript",
  "typescript",
  "tsx",
  "jsdoc",
  "json",
  "jsonc",
  "astro",
  "svelte",
  "go",
  "bash",
  "regex",
}

local installed = require("nvim-treesitter.config").get_installed()
local to_install = vim.iter(parsers)
  :filter(function(p)
    return not vim.tbl_contains(installed, p)
  end)
  :totable()

if #to_install > 0 then
  require("nvim-treesitter").install(to_install)
end

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ok = pcall(vim.treesitter.start, args.buf)
    if ok then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
