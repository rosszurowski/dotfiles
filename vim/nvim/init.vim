call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'justinmk/vim-dirvish'

" Git
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'gavocanov/vim-js-indent'
Plug 'mxw/vim-jsx'
Plug 'sbdchd/neoformat'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

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
set shiftwidth=2
set visualbell
set noerrorbells
set number
set noincsearch
set nowrap
set noshowmode
set hlsearch
" performance: don't highlight beyond 400 columns
set synmaxcol=400
" style: show the 81th line
set colorcolumn=81
set wildignore+=node_modules
set splitright
set ttimeoutlen=0
set shell=/usr/local/bin/zsh

" Keybindings
nnoremap <C-k> :tabnext<CR>
nnoremap <C-j> :tabprevious<CR>
nnoremap <C-p> :FZF<CR>

" Appearance
let $PATH .= ':node_modules/.bin/:/Users/tmcw/.cargo/bin/'
set termguicolors
set background=dark
colorscheme nord

" vim-airline/vim-airline
set laststatus=2
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