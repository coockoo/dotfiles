" Use Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" Let Vundle manage itself
Plugin 'VundleVim/Vundle.vim'

Plugin 'dense-analysis/ale'
Plugin 'hail2u/vim-css3-syntax'
" Plugin 'juleswang/css.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'preservim/nerdtree'
Plugin 'chr4/nginx.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'SirVer/ultisnips'
Plugin 'airblade/vim-gitgutter'
Plugin 'jparise/vim-graphql'
Plugin 'pangloss/vim-javascript'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'groenewege/vim-less'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'stephpy/vim-yaml'
Plugin 'itchyny/vim-gitbranch'

call vundle#end()

filetype plugin indent on

syntax on

set hidden
set nobackup
set nowritebackup
set cmdheight=1
set nowrap
set number
set tabstop=2
set shiftwidth=2
" Expand tabs to spaces
set expandtab
set backspace=indent,eol,start
set ruler
" default updatetime 4000ms is not good for async update
set updatetime=100
" Hide mode at the bottom
set noshowmode

" Show tabs, trailing spaces, endofilnes in by pressing F2
nnoremap <F2> :<C-U>setlocal lcs=tab:>-,space:.,trail:-,eol:$ list! list? <CR>

" Set encoding to utf-8
scriptencoding utf-8
set encoding=utf-8

" Ctrl-P
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_map = '<C-O>'
let g:ctrlp_open_new_file = 't'
let g:ctrlp_prompt_mappings = { 'AcceptSelection("e")': ['<c-t>'], 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'] }
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Vim-javascript
let javascript_enable_domhtmlcss=1

" Set cursor on the left side of the tab sign
set list lcs=tab:\ \ 
" extra space after tab

" UltiSnips
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsEditSplit="vertical"

" Disable <C-c> for SQL files and replace it with C-j
let g:ftplugin_sql_omni_key = '<C-j>'

" NERDComment
let g:NERDComToggleComment = '<C-/>'

" NERDTree
let g:NERDTreeCascadeSingleChildDir = 0
" Reveal current file in tree
nmap ,r :NERDTreeFind<CR>
let g:nerdtree_tabs_open_on_console_startup=1
let g:NERDTreeIgnore = ['\.swp$', '^.DS_Store$']

" coc.nvim
" Use tab for trigger completion with characters ahead and navigate.
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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
let g:coc_global_extensions = [ 'coc-tsserver' ]
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Colorscheme
let g:rehash256=1
set background=light " Kappa. IDK why
colorscheme custom

" Normal mouse selection and scroll
set mouse=a

" Get word group for word under cursor
function! SyntaxItem()
	return synIDattr(synID(line("."),col("."),1),"name")
endfunction

let s:mode_map = {
\   'n': 'NORMAL', 'i': 'INSERT', 'R': 'REPLACE', 'v': 'VISUAL', 'V': 'V-LINE', "\<C-v>": 'V-BLOCK',
\   'c': 'COMMAND', 's': 'SELECT', 'S': 'S-LINE', "\<C-s>": 'S-BLOCK', 't': 'TERMINAL'
\ }

function! GetMode() abort
  return get(s:mode_map, mode(), '')
endfunction

" Statusline configuration
set statusline=%#StatusLineMode#\ %{GetMode()}\ %#StatusLineDefault#\  " Mode
set statusline+=%f\                                                    " Filename + separator
set statusline+=%y\                                                    " Filetype + separator
set statusline+=%=                                                     " Switch to the right side
set statusline+=%{SyntaxItem()}\                                       " Display word group (for syntax)
set statusline+=%#StatusLineGitBranch#\ %{gitbranch#name()}\           " Git branch

" Vertical line for 100 symbols
set colorcolumn=100
hi ColorColumn ctermbg=7 guibg=#666666

" ALE settings
let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ 'typescript': ['eslint']
  \ }
let g:ale_fixers = {
  \ 'javascript': ['prettier'],
  \ 'javascript.jsx': ['prettier'],
  \ 'json': ['prettier'],
  \ 'typescript': ['prettier'],
  \ 'typescriptreact': ['prettier'],
  \ 'css': ['prettier'],
  \ 'less': ['prettier'],
  \ 'html': [],
  \ 'sql': []
  \ }
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_set_highlights = 0
let g:ale_typescript_tslint_use_global = 0
let g:ale_typescript_eslint_use_global = 0
let g:ale_typescript_eslint_options = '--cache'
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '>>'
" let g:ale_sql_pgformatter_options = '--function-case 1 --keyword-case 1 --spaces 2'

" Setup command aliases
" https://stackoverflow.com/a/3879737/1162326
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("W","w")
call SetupCommandAlias("Tabm","tabm")
call SetupCommandAlias("Tabo","tabo")

" Use fzf
set rtp+=/usr/local/opt/fzf
