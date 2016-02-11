set nocompatible
filetype off

"
" NeoBundleInstall ... install plugin
" NeobundleUpdate  ... update plugin
" NeoBundleClean   ... remove plugin (execute this command after modifiing
"                      vimrc
if has('vim_starting')
    set rtp+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell'

call neobundle#end()

filetype plugin indent on

" display the ruler on the right side of the status line
set ruler
" display the line number
set number
" convert tabs to spaces
set expandtab
" insert 4 spaces for tab
set tabstop=4
" change the number of space inserted for indentation
set shiftwidth=4
" make the backspace key treat the 4 spaces like a tab
set softtabstop=4
set autoindent
set smartindent

set list
set listchars=eol:¬,tab:▸\ 
" highlight all search matches
set hlsearch
" cursor will briefly jump to the matching brace
set showmatch
" show command
set showcmd
set ignorecase
set smartcase
set nowrapscan

"------------------------------------------------------------
" Neocomplete
"
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_enable_camel_case_completion = 0
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"------------------------------------------------------------
" jedi-vim Setting

autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'


