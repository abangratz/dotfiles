set nocompatible
filetype off
set rtp+=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'lmeijvogel/vim-yaml-helper'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'ag.vim'
NeoBundle 'utl.vim'
NeoBundle 'matchit.zip'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'jason0x43/vim-js-indent'
NeoBundle 'Quramy/tsuquyomi'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-cucumber'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'mhinz/vim-signify'
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-haml'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-ragtag'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-sleuth'
"NeoBundle 'vim-scripts/VimClojure'
"NeoBundle 'jceb/vim-orgmode'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'groenewege/vim-less'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'mbbill/undotree'
NeoBundle 'ShowTrailingWhitespace'
NeoBundle 'DeleteTrailingWhitespace'
NeoBundle 'drmikehenry/vim-fontsize'
NeoBundle 'bling/vim-bufferline'
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-flagship'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'paredit.vim'
NeoBundle 'Matt-Deacalion/vim-systemd-syntax'
call neobundle#end()
filetype plugin on
NeoBundleCheck


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
set showtabline=2
set guioptions-=e
set viminfo='20,\"50
set tw=120
set sw=4
set ts=4
set bg=dark
"set digraph " unset, no good for programming when you have compose
set smartindent
set softtabstop=4
set smarttab
set nohlsearch
set showmatch
set modeline
set modelines=5
set number
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
nnoremap <silent> <F8> :TagbarToggle<CR>
nnoremap <silent> <F9> :NERDTreeToggle<CR>
let spell_language_list="de_AT,en_US"
let spell_executable="aspell"
" ruby stuff: completion
" autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete " Keep that for v7
let g:rubycomplete_buffer_loading = 1
let g_rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_include_object = 1
"org mode customization
let g:org_todo_keywords = ['TODO', 'WORK', 'DONE', '|']
let g:org_todo_keyword_faces = [['TODO', 'magenta'],['WORK', 'green'],['DONE', 'yellow']]
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
let g:rails_statusline = 0
autocmd FileType ruby setlocal sw=2
autocmd FileType ruby setlocal ts=2
autocmd FileType ruby setlocal sts=2
autocmd FileType ruby setlocal sta
autocmd FileType ruby setlocal et
autocmd FileType ruby call PareditInitBuffer()
autocmd FileType javascript call PareditInitBuffer()
autocmd FileType coffee call PareditInitBuffer()

set wildignore+=*vendor/*,*/tmp/*,*/.git/*,*/log/*,tags,*node_modules/*
let g:ctrlp_custom_ignore = '\v[\/](vendor|coverage)/'
let g:ctrlp_open_new_file = 't'
" less settings
au FileType less setl sw=2 sts=2 et
au FileType cucumber setl sw=2 sts=2 et
" Rainbow Parentheses settings
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" Show Trailing Whitespace
let g:ShowTrailingWhitespace = 1
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'ask'
au Syntax * syntax keyword myTodo containedin=.*Comment contained WARNING NOTE
"use symbols in vim-airline
let g:airline_powerline_fonts=1

set fillchars=stl:\ ,stlnc:\ "

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" " unicode symbols
" let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.whitespace = 'Ξ'

" " powerline symbols
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.space = " "
" PostgreSQL
let g:dbext_default_profile_PG_event = 'type=PGSQL:user=tony:dbname=event'
let g:dbext_default_profile_PG_falter = 'type=PGSQL:user=tony:dbname=falter'
let g:solarized_termtrans = 1
colorscheme solarized
