set nocompatible
set number
filetype off

"
" Vundle Install -> NeoBundleInstall!
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \   'windows' : 'make -f make_mingw64.mak',
    \   'cygwin' : 'make -f make_cygwin.mak',
    \   'mac' : 'make -f make_mac.mak',
    \   'unix' : 'make -f make_unix.mak',
    \ }}
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Sixeight/unite-grep'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'vim-scripts/SingleCompile'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tsukkee/unite-tag'


filetype plugin indent on
NeoBundleCheck

"--------------------
" Tab
set tabstop=4
set expandtab
set softtabstop=0
set shiftwidth=4
set smarttab

"--------------------
" Encode
set encoding=UTF-8
set fileencodings=iso-2022-jp,utf-8,cp932,euc-jp,default,latin
set termencoding=UTF-8


""" unite.vim
let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <C-P> :Unite buffer<CR>
" ファイル一覧
nnoremap <C-N> :Unite -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <C-R> :Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <C-Z> :Unite file_mru<CR>
" VimFiler
nnoremap <F2> :VimFiler -buffer-name=explorer -split -winwidth=45 -toggle -no-quit<CR>
" VimShell
nnoremap <C-C> :VimShell<CR>

au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')


au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')

au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>



call unite#set_substitute_pattern('file', '\$\w\+', '\=eval(submath(0))', 200)
call unite#set_substitute_pattern('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/"', 2)
call unite#set_substitute_pattern('file', '^@', '\getcwd()."/*"',1)
call unite#set_substitute_pattern('file', '^;r', '\=$VIMRUNTIME."/"')
call unite#set_substitute_pattern('file', '^\~',escape($HOME,'\'),-2)
call unite#set_substitute_pattern('file', '\\\@<! ', '\\ ', -20)
call unite#set_substitute_pattern('file', '\\ \@!', '/', -30)

let $BOOST_ROOT = '/usr/include/boost'
let $OPENCV_ROOT = '/usr/local/include/opencv'
let $OPENCV2_ROOT = '/usr/local/include/opencv2'
let $CPP_ROOT = '/usr/include/c++/4.7.3'
let $C_ROOT = '/usr/include'
set path+=$C_ROOT
set path+=$CPP_ROOT
set path+=$BOOST_ROOT
set path+=$OPENCV_ROOT
set path+=$OPENCV2_ROOT
"-------------------
" neocomplcache
" Disable AutoCompPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup=1
" Use smartcase.
let g:neocomplcache_enable_smart_case=1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length=3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>    neocomplcache#undo_completion()
inoremap <expr><C-l>    neocomplcache#complete_common_string()

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    " return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
 
" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'





"--------------------
" neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"--------------------
" vimfiler
let g:vimfiler_as_default_explorer=1
let g:vimfiler_safe_mode_by_default=0
nnoremap <Space>f :<C-u>VimFiler<CR>

"--------------------
" vimgrep
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :<C-u>cfirst<CR>
nnoremap ]Q :<C-u>clast<CR>

"--------------------
" easymotion
" Usage:
" 'k line upware
" 'j line downward
" 'b Begining of word backward
" 'w Begining of word forward
" 'f Find {char} to the right.
" 'F find {char} to the left.
"
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
let g:EasyMotion_leader_key="'"
let g:EasyMotion_grouping=1
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade ctermbg=none ctermfg=blue

"--------------------
" colorscheme
"colorscheme jellybeans

"--------------------
" Comment or uncomment lines from mark a to mark b.
" Usage:
" \ciB comment inner block (between braces)
" \c} comment to end paragraph
" \cG comment to end buffer
" \Vjjj\c comment visually-selected lines
"
function! CommentMark(docomment, a, b)
    if !exists('b:comment')
       let b:comment = CommentStr() . ' '
    endif
    if a:docomment
        exe "normal! '" . a:a . "_\<C-V>'" . a:b . 'I' . b:comment
    else
        exe "'".a:a.",'".a:b . 's/^\(\s*\)' . escape(b:comment,'/') . '/\1/e'
    endif
endfunction

" Comment lines in marks set by g@ operator.
function! DoCommentOp(type)
    call CommentMark(1, '[', ']')
endfunction
" Uncomment lines in marks set by g@ operator.
function! UnCommentOp(type)
    call CommentMark(0, '[', ']')
endfunction

" Return string used to comment line for current filetype.
function! CommentStr()
    if &ft == 'c' || &ft == 'h' || &ft == 'hpp' || &ft == 'cpp' || &ft == 'java' || &ft == 'javascript'
        return '//'
    elseif &ft == 'vim'
        return '"'
    elseif &ft == 'python' || &ft == 'perl' || &ft == 'sh' || &ft == 'R' || &ft == 'ruby'
        return '#'
    elseif &ft == 'lisp'
        return ';'
    endif
    return ''
endfunction

nnoremap <Leader>c <Esc>:set opfunc=DoCommentOp<CR>g@
nnoremap <Leader>C <Esc>:set opfunc=UnCommentOp<CR>g@
vnoremap <Leader>c <Esc>:call CommentMark(1,'<','>')<CR>
vnoremap <Leader>C <Esc>:call CommentMark(0,'<','>')<CR>

" jedi
let g:jedi#auto_initialization=0
let g:jedi#popup_on_dot=0
