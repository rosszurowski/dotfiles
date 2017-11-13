call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'justinmk/vim-dirvish'
Plug 'ervandew/supertab'

" Git
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'gavocanov/vim-js-indent'
Plug 'mxw/vim-jsx'
Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }

" Completion
Plug 'ervandew/supertab'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins', 'for': ['javascript', 'javascript.jsx'] }
Plug 'flowtype/vim-flow', { 'for': ['javascript', 'javascript.jsx'] }

" Searching
Plug 'junegunn/fzf'

" Vimscript
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'

" Syntax highlighting
Plug 'w0rp/ale'

" Theme
Plug 'arcticicestudio/nord-vim'

call plug#end()

set nocompatible
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:· " Display tabs and trailing spaces visually
set shell=/usr/local/bin/zsh
set visualbell
set noerrorbells
set number
set noincsearch
set nowrap
set linebreak
set noshowmode
set hlsearch
set splitright
set splitbelow
" performance: don't highlight beyond 400 columns
set synmaxcol=400
" style: show the 81th line
set colorcolumn=81
set wildignore+=node_modules
set splitright
set ttimeoutlen=0
" Disable swap files
set noswapfile
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Appearance
let $PATH .= ':node_modules/.bin/'
set termguicolors
set background=dark
colorscheme nord

" Keybindings
nnoremap <C-k> :tabnext<CR>
nnoremap <C-j> :tabprevious<CR>
nnoremap <C-p> :FZF<CR>
" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Disable arrow keys
map  <down>  <nop>
imap <left>  <nop>
imap <right> <nop>
imap <up>    <nop>
map  <down>  <nop>
map  <left>  <nop>
map  <right> <nop>
map  <up>    <nop>

" justinmk/vim-dirvish
let loaded_netrwPlugin = 1
augroup my_dirvish_events
  autocmd FileType dirvish sort r /[^\/]$/
augroup END
command! E Dirvish

" Flow
let g:flow#enable = 0
let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
  let local_flow= getcwd() . "/" . local_flow
endif
if executable(local_flow)
  let g:flow#flowpath = local_flow
endif

" vim-airline/vim-airline
set laststatus=2
let g:airline_extensions = ['branch']
let g:airline_skip_empty_sections = 1
let g:airline_powerline_fonts = 0
let g:airline_section_z = '%l:%L'
let g:airline#extensions#default#layout = [
    \ [ 'c' ],
    \ [ 'x', 'b', 'error', 'warning' ]
    \ ]
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = '⎇'

" airblade/vim-gitgutter
set signcolumn=yes
let g:gitgutter_eager = 0

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0
set completeopt-=preview

" mxw/vim-jsx
let g:jsx_ext_required = 0

set mouse=a

autocmd BufNewFile,BufRead *.json set filetype=javascript
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.wah set filetype=ast
autocmd BufWinLeave * call clearmatches()

" never engage ex mode
" http://www.bestofvim.com/tip/leave-ex-mode-good/
nnoremap Q <nop>
