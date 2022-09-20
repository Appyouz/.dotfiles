syntax on
filetype plugin indent on

set nu rnu ai si ts=2 sts=2 sw=2 et 
set mouse=a smarttab
set clipboard+=unnamedplus

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs' " auto pairs 
Plug 'preservim/nerdtree' " NerdTree for toggling directories
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'lukas-reineke/indent-blankline.nvim' "Indentation guide to all the lines

" themes start
Plug 'gruvbox-community/gruvbox' 
Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes' "status bar
Plug 'kaicataldo/material.vim'
Plug 'dracula/vim'
Plug 'sickill/vim-monokai'
"themes end

"Fuzzy-Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"Tagbar
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }

Plug 'mxw/vim-jsx'
" Syntax hightlight for .js
" Plug 'pangloss/vim-javascript'

 " Plug 'glepnir/dashboard-nvim'
call plug#end()

set encoding=UTF-8



 " coc-react-refactor
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

"Prettier
nmap <Leader>z <Plug>(Prettier)
 let g:prettier#autoformat_config_present = 1
" let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#exec_cmd_async = 1
" when running at every change you may want to disable quickfix
  " let g:prettier#quickfix_enabled = 1
  " autocmd TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
    " remap for complete to use tab and <cr>
    inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1):
        \ <SID>check_back_space() ? "\<Tab>" :
        \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
    inoremap <silent><expr> <c-space> coc#refresh()

     " hi CocSearch ctermfg=12 guifg=#18A3FF
     " hi CocMenuSel ctermbg=109 guibg=#13354A
    

" Themes
 set termguicolors
 color gruvbox

"NerdTree keybindings
inoremap <c-t> <Esc>:NERDTreeToggle<cr>
nnoremap <c-t> <Esc>:NERDTreeToggle<cr>
nnoremap <c-f> <Esc>:NERDTreeFocus<cr>
nnoremap <c-n> <Esc>:NERDTree<cr>
" nnoremap <c-l> <Esc>:call CocActionAsync('jumpDefinition')<cr>
nmap <F8> :TagbarToggle<CR>


" Fuzzy Finder
nnoremap <c-p> :Files <cr>

" to paste from system clipboard use Control+Shift+v
" vmap <C-c> "+y
"map key Control+y for copy from vim to system clipboard on 16-July-2020
vnoremap <C-c> "*y :let @+=@*<CR>
" easy paste long text from clipboard
nnoremap <leader>pp "+p


" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l


"NerdTree
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' '



 
