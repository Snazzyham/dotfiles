require'nvim-treesitter.configs'.setup {
  ensure_installed = {"lua", "vim", "help" },

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

  context_commentstring = {
    enable = true,
    enable_autocmd = false
  },
}
