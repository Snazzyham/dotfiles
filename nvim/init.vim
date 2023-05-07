source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/plug-config/lsp-config.vim
luafile $HOME/.config/nvim/lua/plugins/compe-config.lua
luafile $HOME/.config/nvim/lua/plugins/autopairs-config.lua
luafile $HOME/.config/nvim/lua/plugins/mason.lua
luafile $HOME/.config/nvim/lua/plugins/treesitter.lua
luafile $HOME/.config/nvim/lua/plugins/formatter.lua
luafile $HOME/.config/nvim/lua/plugins/comment.lua


lua require('lualine').setup{ options = { theme = "auto" } }
lua require('nvim-autopairs').setup()


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
" highlight Pmenu ctermbg=black gui=bold
"set notermguicolors
set t_Co=256
colorscheme kanagawa-dragon

" theme specific 
"
let g:github_keyword_style= "NONE"

let g:onedark_config = {
      \ 'style': 'darker'
\}

if (has("termguicolors"))
  set termguicolors
endif


" REMAP VIM SWITCH BETWEEN SPLITS
:nnoremap <C-k> :wincmd k<CR>
:nnoremap <C-j> :wincmd j<CR>
:nnoremap <C-h> :wincmd h<CR>
:nnoremap <C-l> :wincmd l<CR>

" ignore node modules folder ctrl-p
let g:ctrlp_custom_ignore = 'node_modules'

" remap control v for insert in vim wsl 
nnoremap vp <c-v>


" set highlight on matching parantheses 
:hi MatchParen ctermfg=0 ctermbg=252 guifg=#ffffff guibg=#ff1100

" Auto Close tags JSX
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx,*.js,*.svelte,*.tsx,*.ts,*.astro"


nnoremap <Space><Space> <Esc>/_++_<Enter>"_c4l

:nnoremap <C-p> :Telescope find_files<CR>
:nnoremap <C-o> :Telescope live_grep<CR>

" autoformat on save with Prettier only on these files
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*ts,*.tsx,*.jsx,*.json,*.css,*.scss,*.less,*.graphql Prettier

" autoformat svelte, astro on save
autocmd BufWritePre *.astro,*.svelte,*.go lua vim.lsp.buf.format()



" Go config 
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
