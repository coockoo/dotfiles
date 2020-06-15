execute pathogen#infect()
syntax on
filetype plugin indent on
let g:nerdtree_tabs_open_on_console_startup=1
set nowrap
set number
set tabstop=2
set shiftwidth=2
" Expand tabs to spaces
set expandtab
set backspace=indent,eol,start
set ruler

" Show tabs, trailing spaces, endofilnes in by pressing F2
nnoremap <F2> :<C-U>setlocal lcs=tab:>-,space:.,trail:-,eol:$ list! list? <CR>

" Set encoding to utf-8
scriptencoding utf-8
set encoding=utf-8

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


" Neocomplete
let g:neocomplete#enable_at_startup = 1
autocmd VimEnter * NeoCompleteEnable " Enable NeoComplete at startup
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ neocomplete#start_manual_complete()
function! s:check_back_space() "{{{
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

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

" Statusline configuration
set statusline=%f               " Filename
set statusline+=\ -\            " Separator
set statusline+=%y              " Filetype
set statusline+=%=              " Switch to the right side
set statusline+=%{SyntaxItem()} " Display word group (for syntax)
set statusline+=%4l             " Current line
set statusline+=/               " Separator
set statusline+=%L              " Total lines

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
      \ 'css': ['prettier'],
      \ 'less': ['prettier'],
      \ 'html': [],
      \ 'sql': []
      \ }
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_set_highlights = 0
let g:ale_typescript_tslint_use_global = 0
let g:ale_typescript_eslint_use_global = 0
let g:ale_typescript_eslint_options = '--cache'
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
