source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/plug-config/lsp-config.vim
luafile $HOME/.config/nvim/lua/plugins/compe-config.lua
luafile $HOME/.config/nvim/lua/plugins/autopairs-config.lua

lua require'lspconfig'.gopls.setup{}
lua require'lspconfig'.tsserver.setup{}
lua require'lspconfig'.svelte.setup{}
lua require'lspconfig'.stylelint_lsp.setup{}
lua require'lsp_signature'.setup()
lua require'lspconfig'.sqls.setup{}
lua require('lualine').setup{ options = { theme = "material-nvim" } }
lua require('nvim-autopairs').setup()
"lua require'colorizer'.setup()
lua require('neoscroll').setup()

" lua <<EOF
"   require'lspconfig'.sqlls.setup{
"     cmd = { "/usr/bin/sql-language-server", "up", "--method", "stdio" }
"   }
" EOF

set ttyfast
set lazyredraw
inoremap " ""<ESC>ha
set clipboard=unnamedplus
set tabstop=2           " tab spacing
set softtabstop=2       " unify tab spacing
set expandtab           " spaces > tabs
set shiftwidth=2
set incsearch           " highlight search when typing
set hlsearch            " highlight search for phrases
set smarttab            " use shiftwidth to tab at line beginning 
inoremap jk <esc>
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"Set relative number, then toggle relative with X-/
		set number relativenumber
"set showmatch
set title
set nobackup
set noswapfile
set mouse=a
syntax on
":set cursorline
set smartindent
set autoindent
set cindent
filetype indent on
filetype plugin indent on


" emmet key to <c-A> rather than C-Y
let g:user_emmet_leader_key='<C-A>'

" set split to right, rather than left, and make vertical splits go down
set splitright
set splitbelow

" COLORSCHEMES
let g:material_style = 'darker'
let g:material_contrast = v:true
highlight Pmenu ctermbg=black gui=bold
set notermguicolors
colorscheme wal

"auto toggle material:



" REMAP VIM SWITCH BETWEEN SPLITS
:nnoremap <C-k> :wincmd k<CR>
:nnoremap <C-j> :wincmd j<CR>
:nnoremap <C-h> :wincmd h<CR>
:nnoremap <C-l> :wincmd l<CR>

" ignore node modules folder ctrl-p
let g:ctrlp_custom_ignore = 'node_modules'


" set highlight on matching parantheses 
:hi MatchParen ctermfg=0 ctermbg=252 guifg=#ffffff guibg=#ff1100

" Auto Close tags JSX
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx,*.js,*.svelte"


nnoremap <Space><Space> <Esc>/_++_<Enter>"_c4l

:nnoremap <C-p> :Telescope find_files<CR>


" vim prettier autoformat
let g:prettier#autoformat = 0
let g:prettier#autoformat_require_pragma = 0
autocmd BufWritePre *.js,*.json,*.css,*.scss,*.less,*.graphql,*.ts,*.jsx,*.html,*.svelte Prettier

" Go config 
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
