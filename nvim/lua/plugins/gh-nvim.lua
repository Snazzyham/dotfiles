-- lua/plugins/gh-nvim.lua
local status, gh = pcall(require, "gh")
if not status then
  print("gh.nvim not loaded")
  return
end

gh.setup({
  icon_set = "nerd",
  mappings = {
    open = "o",
    expand = "<CR>",
    collapse = "<BS>",
    next = "n",
    prev = "p",
    submit = "s",
    close = "c",
  },
})

-- Optional keybindings
vim.api.nvim_set_keymap('n', '<leader>pr', ':GH PR list<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pd', ':GH PR diff<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>pc', ':GH PR checkout<CR>', { noremap = true, silent = true })
