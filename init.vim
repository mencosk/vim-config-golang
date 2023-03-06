set number
set mouse=r
set numberwidth=1
set clipboard=unnamed
syntax enable
set showcmd
set ruler
set encoding=utf-8
set showmatch
set sw=2
set laststatus=2

" Searching
set hlsearch          " highlight matches
set incsearch         " incremental searching
set ignorecase        " searchs are case insensitive ...
set smartcase         " unless they contain at least one capital letter


" coc.nvim default setting
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=200
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes


" Pluggin 
"
call plug#begin('~/.vim/plugged')

" syntax
"
Plug 'sheerun/vim-polyglot'

" status bar
"
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/lightline.vim'

" Theme
"
" Plug 'morhetz/gruvbox'
" Plug 'shinchu/lightline-gruvbox.vim'
Plug 'jacoborus/tender.vim'

" IDE
"
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'scrooloose/nerdcommenter'
Plug 'fatih/vim-go'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" Typing
"
Plug 'jiangmiao/auto-pairs'

" tmux
"
Plug 'benmills/vimux'
" Allow move between windows open with nerdTree
Plug 'christoomey/vim-tmux-navigator'


call plug#end()

" colorscheme gruvbox

if (has("termguicolors"))
	set termguicolors
endif
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme tender

let g:airline_theme = 'tender'

" let g:gruvbox_contrast_dark = "hard"
let mapleader=" "

" Plugs
"
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeShowLineNumbers=1


" Plugs Maps
"
map <Leader>s <Plug>(easymotion-s2)
map <Leader>nt :NERDTreeFind<CR>
map <Leader>p :Files<CR>
map <Leader>ag :Ag<CR>

" split resize
"
nnoremap <Leader>> 10<C-w>>
nnoremap <Leader>< 10<C-w><

" Easy save and close
"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" disable vim-go :GoDef short cut
" this is handler by LanguageClient
let g:go_def_mapping_enabled=0

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Show all diagnostics
nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p :<C-u>CocListResume<CR>

