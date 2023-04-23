if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin("~/.config/nvim/autoload/plugged")
Plug 'neovim/nvim-lspconfig'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'astro', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hrsh7th/nvim-compe'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'fatih/vim-go'
Plug 'tpope/vim-commentary'
Plug 'ray-x/lsp_signature.nvim'
Plug 'gabrielelana/vim-markdown'
Plug 'amadeus/vim-mjml'
Plug 'andreypopp/vim-colors-plain'
Plug 'karb94/neoscroll.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'alvan/vim-closetag'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'elzr/vim-json'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline-themes'
Plug 'tmhedberg/matchit'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'SirVer/ultisnips'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'jparise/vim-graphql'
Plug 'hoob3rt/lualine.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" colorschemes 
Plug 'tomasr/molokai'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'dylanaraps/wal.vim'
Plug 'dikiaap/minimalist'
Plug 'joshdick/onedark.vim'
Plug 'tanvirtin/monokai.nvim'
Plug 'tomasiser/vim-code-dark'
Plug 'rafamadriz/neon'
Plug 'dylanaraps/wal.vim'
Plug 'marko-cerovac/material.nvim'
Plug 'glepnir/zephyr-nvim'
Plug 'projekt0n/github-nvim-theme'
Plug 'Mofiqul/dracula.nvim'
Plug 'rose-pine/neovim'
call plug#end()
