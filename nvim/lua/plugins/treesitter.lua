local ts_utils = require("nvim-treesitter.ts_utils")

ts_utils.get_node_text = vim.treesitter.get_node_text

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"lua" },

  sync_install = false,

  auto_install = false,

  highlight = {
    enable = true,
    use_languagetree = true
  },

  indent = {
    enable = true
  },

  autotag = {
    enable = true,
  },

  -- context_commentstring = {
  --   enable = true,
  --   enable_autocmd = false
  -- },
}
