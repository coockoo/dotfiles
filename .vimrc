call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'jistr/vim-nerdtree-tabs'
  Plug 'itchyny/vim-gitbranch'
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'dense-analysis/ale'
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'airblade/vim-gitgutter'
  Plug 'hail2u/vim-css3-syntax'
  Plug 'mattn/emmet-vim'
  Plug 'jparise/vim-graphql'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'groenewege/vim-less'
  Plug 'stephpy/vim-yaml'
call plug#end()

" Line numbers to the left
set number
" The maximum width of the <Tab> character
set tabstop=2
" The size of the indent
set shiftwidth=2
" Replace tabs with spaces
set expandtab
" Bye folds!
set nofoldenable
" Set cursor on the left side of the tab sign. Note extra space after the last slash
set list lcs=tab:\ \
" Make backspace work great
set backspace=indent,eol,start
" Vertical line for 120 symbols
set colorcolumn=120
" Colorscheme. For some reason, it doesn't work with the background=dark
colorscheme custom
" Setup detection plugin and indent on
filetype plugin indent on
" Enable vim syntax colors
syntax on
" Set encoding to utf-8
scriptencoding utf-8
set encoding=utf-8
" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=1
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Duration of the timeouts for command-pending commands (such as <leader>...)
set timeoutlen=1000
" Duration of the timeouts for key codes (esc, left, right etc)
set ttimeoutlen=0
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" Normal mouse selection and scroll
set mouse=a
" Prevent long line wrapping
set nowrap
" Don't show mode in the cmd line, as we have it in the statusline
set noshowmode
" Ruler
set ruler
" Autoread. Load file on it was changed from the global
set autoread
" This option controls the behavior when switching between buffers.
set switchbuf=useopen,usetab
" this has to do something with the buffer
set re=1

" leaders
let maplocalleader = ','

" Copy a file to the buffer
nnoremap <localleader>yf ggVG"+y
" Copy filename to the buffer
nnoremap <localleader>p :let @+ = expand("%")<cr>

" Show tabs, trailing spaces, endofilnes in by pressing F2
nnoremap <F2> :<C-U>setlocal lcs=tab:>-,space:.,trail:-,eol:$ list! list? <CR>

" Reveal current file in tree.
nnoremap <localleader>r :NERDTreeFind<CR>
let g:NERDTreeIgnore = ['\.swp$', '^.DS_Store$']

" Remove Press ? for help and (up a dir)
let NERDTreeMinimalUI = 1
" Makes small menu for add/delete/move commands
" related to this issue https://github.com/preservim/nerdtree/issues/1321#issuecomment-1229071986
let NERDTreeMinimalMenu=1
" Open NERDTree on console vim startup.
let g:nerdtree_tabs_open_on_console_startup = 1
" make nerdtee reuse
" let g:NERDTreeMapCustomOpen = 't'
" let g:NERDTreeMapOpenInTab = '<CR>'
" let g:NERDTreeCustomOpenArgs = {'file': {'reuse': 'all', 'where': 'p', 'keepopen':1, 'stay':0}, 'dir':{}}

" Statusline configuration
set statusline=%#StatusLineMode#\ %{GetMode()}\ %#StatusLineDefault#\  " Mode
set statusline+=%{expand('%:~:.')}\                                    " Filename + separator
set statusline+=%y\                                                    " Filetype + separator
set statusline+=%=                                                     " Switch to the right side
set statusline+=%{coc#status()}                                        " Display coc status
set statusline+=%#StatusLineGitBranch#\ %{gitbranch#name()}\           " Git branch

" Get word group for word under cursor
function! SyntaxItem()
  return synIDattr(synID(line("."), col("."), 1), "name")
endfunction
" Display current syntax group under the cursor
nnoremap <localleader>si :echo SyntaxItem()<CR>

let s:mode_map = {
\   'n': 'NORMAL', 'i': 'INSERT', 'R': 'REPLACE', 'v': 'VISUAL', 'V': 'V-LINE', "\<C-v>": 'V-BLOCK',
\   'c': 'COMMAND', 's': 'SELECT', 'S': 'S-LINE', "\<C-s>": 'S-BLOCK', 't': 'TERMINAL'
\ }
function! GetMode() abort
  return get(s:mode_map, mode(), '')
endfunction

" Setup command aliases
" https://stackoverflow.com/a/3879737/1162326
function! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from.' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'") ? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

call SetupCommandAlias("W","w")
call SetupCommandAlias("Tabm","tabm")
call SetupCommandAlias("Tabo","tabo")

" ale
let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint'],
\ 'json': []
\ }
let g:ale_fixers = {
\ 'javascript': ['prettier'],
\ 'javascript.jsx': ['prettier'],
\ 'json': ['prettier'],
\ 'typescript': ['prettier'],
\ 'typescript.tsx': ['prettier'],
\ 'typescriptreact': ['prettier'],
\ 'css': ['prettier'],
\ 'less': ['prettier'],
\ 'scss': ['prettier'],
\ 'html': ['prettier'],
\ 'markdown': ['remove_trailing_lines', 'trim_whitespace']
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

" coc
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Use ctrl + j for expanding snippets
imap <C-j> <Plug>(coc-snippets-expand-jump)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'

" Symbol renaming.
nmap <localleader>rn <Plug>(coc-rename)

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Set filetype to typescript.tsx
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
" Set filetype for Wix javascript files
autocmd BufNewFile,BufRead *.jsw set filetype=javascript

" Ctrl + L will move to another tab
noremap <C-l> :tabn<CR>
noremap <C-h> :tabp<CR>

" Disable <C-c> for SQL files and replace it with C-j
let g:ftplugin_sql_omni_key = '<C-j>'

" Vim-javascript
let g:javascript_enable_domhtmlcss=1

" Typos
iabbrev cosnt  const
iabbrev ocnst  const
iabbrev retunr return
iabbrev THursday Thursday
iabbrev thursday Thursday
iabbrev lenght length
iabbrev pslit split

" operator-pending mappings
" parentheses
onoremap p i(
" next parentheses
onoremap np :<c-u>normal! f(vi(<cr>

autocmd FileType markdown call <SID>setupMarkdown()
function! s:setupMarkdown()
  set wrap
  set linebreak
endfunction

" fzf
nnoremap <C-o> :GFiles<CR>
nnoremap <C-p> :Files<CR>
let g:fzf_action = {
\ 'enter': 'tabedit'
\ }
