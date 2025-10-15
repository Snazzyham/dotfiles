-- Source Vim-Plug plugins
vim.cmd('source $HOME/.config/nvim/vim-plug/plugins.vim')

-- Source LSP configuration
vim.cmd('source $HOME/.config/nvim/plug-config/lsp-config.vim')

-- Load Lua configurations
require('plugins.compe-config')
require('plugins.autopairs-config')
require('plugins.mason')
require('plugins.treesitter')
require('plugins.conform')
require('plugins.comment')

-- Setup Lualine
require('lualine').setup({ options = { theme = "auto" } })

-- Setup nvim-autopairs
require('nvim-autopairs').setup()

-- Set some global options
vim.o.ttyfast = true
vim.o.lazyredraw = true
vim.o.clipboard = "unnamedplus"
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.smarttab = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.title = true
vim.o.backup = false
vim.o.swapfile = false
vim.o.mouse = "a"
vim.o.syntax = "on"
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.cindent = true

-- Set emmet key
vim.g.user_emmet_leader_key = '<C-A>'

-- Set splits behavior
vim.o.splitright = true
vim.o.splitbelow = true

-- Set colorscheme
vim.o.termguicolors = true
vim.o.t_Co = 256
vim.cmd('colorscheme oxocarbon')

-- Remap vim switch between splits
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<CR>', { noremap = true, silent = true })

-- Ignore node_modules folder in CtrlP
vim.g.ctrlp_custom_ignore = 'node_modules'

-- Remap vp for insert in Vim WSL
vim.api.nvim_set_keymap('n', 'vp', '<c-v>', { noremap = true })

-- Highlight on matching parentheses
vim.cmd('hi MatchParen ctermfg=0 ctermbg=252 guifg=#ffffff guibg=#ff1100')

-- Auto close tags for JSX
vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx,*.js,*.svelte,*.tsx,*.ts,*.astro"

-- Set key mapping for searching under the cursor
vim.api.nvim_set_keymap('n', '<Space><Space>', '/_++_<CR>"_c4l', { noremap = true, silent = true })

-- Set key mappings for Telescope
vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-o>', ':Telescope live_grep<CR>', { noremap = true, silent = true })

-- Toggle Git blame
vim.api.nvim_set_keymap('n', '<C-b>', ':GitBlameToggle<CR>', { noremap = true, silent = true })

-- Function to format code
local function format_code()
    vim.cmd(':Format')
end

-- Key mapping to format code
vim.api.nvim_set_keymap('n', '<Space>p', '<cmd>lua format_code()<CR>', { noremap = true, silent = true })

-- Go config
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_operators = 1
vim.g.go_fmt_autosave = 1
vim.g.go_fmt_command = "goimports"
vim.g.go_auto_type_info = 1

