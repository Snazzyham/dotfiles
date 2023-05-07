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
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'numToStr/Comment.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'gabrielelana/vim-markdown'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmhedberg/matchit'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'SirVer/ultisnips'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hoob3rt/lualine.nvim'
" colorschemes 
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'dylanaraps/wal.vim'
Plug 'tiagovla/tokyodark.nvim'
Plug 'tanvirtin/monokai.nvim'
Plug 'tomasiser/vim-code-dark'
Plug 'dylanaraps/wal.vim'
Plug 'projekt0n/github-nvim-theme'
Plug 'Mofiqul/dracula.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'Abstract-IDE/Abstract-cs'
Plug 'rockerBOO/boo-colorscheme-nvim'
Plug 'kvrohit/substrata.nvim'
Plug 'rose-pine/neovim'
Plug 'neanias/everforest-nvim', { 'branch': 'main' }
call plug#end()
