version 6.0
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'L9'
Bundle 'ack.vim'
Bundle 'utl.vim'
Bundle 'chrisbra/NrrwRgn'
Bundle 'FuzzyFinder'
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-endwise'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-repeat'
Bundle 'jceb/vim-orgmode'

let s:cpo_save=&cpo
set cpo&vim
map! <xHome> <Home>
map! <xEnd> <End>
map! <S-xF4> <S-F4>
map! <S-xF3> <S-F3>
map! <S-xF2> <S-F2>
map! <S-xF1> <S-F1>
map! <xF4> <F4>
map! <xF3> <F3>
map! <xF2> <F2>
map! <xF1> <F1>
vnoremap p :let current_reg = @"gvdi=current_reg
map <xHome> <Home>
map <xEnd> <End>
map <S-xF4> <S-F4>
map <S-xF3> <S-F3>
map <S-xF2> <S-F2>
map <S-xF1> <S-F1>
map <xF4> <F4>
map <xF3> <F3>
map <xF2> <F2>
map <xF1> <F1>
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set backspace=indent,eol,start
set history=50
set modelines=5
set printoptions=paper:a4
set ruler
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pdf
syntax on
set laststatus=2
set viminfo='20,\"50
set tw=120
set sw=4
set ts=4
set bg=dark
"set digraph " unset, no good for programming when you have compose
let php_folding=2
let php_sync_method=0
set smartindent
set softtabstop=4
set smarttab
set nohlsearch
set showmatch
set modeline
set modelines=5
iab YDT         <C-R>=strftime("%Y-%m-%d %H:%M")<CR>
ia  DATE		<C-R>=strftime("%F %T %z")<CR>
ia  SDATENUM      <C-R>=strftime("%Y%m%d001")<CR>
ia  SDATE         <C-R>=strftime("%Y%m%d")<CR>
let g:explVertical=1
let g:explSplitRight=1
let g:explStartRight=0
let g:explWinSize=35
let g:explHideFiles='^\.,\.bak$,\.dia$,\.glx$,\.gxs$,\.gxg$'
let g:proj_flags="imst"
let g:netrw_altv = 1
filetype on
filetype indent on
filetype plugin on
nnoremap <silent> <F8> :TagBarToggle<CR>
nmap <silent> <F12> <Plug>ToggleProject
"noremap <F8> :so `vimspell.sh %`<CR><CR>
"noremap <F7> :syntax clear SpellErrors<CR>
let spell_language_list="de_AT,en_US"
let spell_executable="aspell"
" ruby stuff: completion
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete " Keep that for v7
let g:rubycomplete_buffer_loading = 1
let g_rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_include_object = 1
" ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
"FuF mappings
nnoremap <silent> <F5> :FufBuffer<CR>
nnoremap <silent> <S-F5> :FufTaggedFile<CR>
nnoremap <silent> <F6> :FufFile<CR>
nnoremap <silent> <S-F6> :FufMruFile<CR>
"org mode customization
let g:org_todo_keywords = ['TODO', 'WORK', 'DONE', '|']
let g:org_todo_keyword_faces = [['TODO', 'magenta'],['WORK', 'green'],['DONE', 'yellow']]

