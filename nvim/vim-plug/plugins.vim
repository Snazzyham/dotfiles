if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin("~/.config/nvim/autoload/plugged")
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'fatih/vim-go'
Plug 'tpope/vim-commentary'
Plug 'ray-x/lsp_signature.nvim'
Plug 'gabrielelana/vim-markdown'
Plug 'amadeus/vim-mjml'
Plug 'dylanaraps/wal.vim'
Plug 'andreypopp/vim-colors-plain'
Plug 'prettier/vim-prettier'
Plug 'karb94/neoscroll.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'alvan/vim-closetag'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'elzr/vim-json'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline-themes'
Plug 'tmhedberg/matchit'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'SirVer/ultisnips'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jparise/vim-graphql'
Plug 'hoob3rt/lualine.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'pangloss/vim-javascript'
call plug#end()
