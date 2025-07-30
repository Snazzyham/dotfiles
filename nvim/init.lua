-- Load Lazy.nvim setup
require("plugins.lazy-setup")

-- Load individual plugin configs
require("plugins.cmp")
require("plugins.autopairs-config")
require("plugins.treesitter")
require("plugins.conform")
require("plugins.comment")
require("plugins.lsp")
require("plugins.diagnostics")

-- Statusline
require("lualine").setup({ options = { theme = "auto" } })

-- General Vim options
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.title = true
vim.opt.mouse = "a"
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.termguicolors = true
vim.opt.cursorline = true

-- Emmet leader key
vim.g.user_emmet_leader_key = "<C-A>"

-- Tmux Navigator
vim.g.tmux_navigator_no_mappings = 1
vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })
vim.keymap.set("n", "<C-\\>", ":TmuxNavigatePrevious<CR>", { silent = true })

-- Highlight matching parentheses
vim.cmd([[hi MatchParen ctermfg=0 ctermbg=252 guifg=#ffffff guibg=#ff1100]])

-- Colorscheme
vim.opt.termguicolors = true
vim.cmd("colorscheme tokyonight-night")

-- keymaps

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<Space><Space>", '<Esc>/_++_<Enter>"_c4l')
vim.keymap.set("n", "<C-b>", ":GitBlameToggle<CR>")
vim.keymap.set("n", "vp", "<C-v>")
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, { noremap = true, silent = true })
vim.keymap.set("n", "<C-o>", builtin.live_grep, { noremap = true, silent = true })
