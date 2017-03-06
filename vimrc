"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.vim/dein'))

" Let dein manage dein
" Required:
call dein#add(expand('~/.vim/dein/repos/github.com/Shougo/dein.vim'))

" Add or remove your plugins here:
" call dein#add('Shougo/vimproc.vim', { 'build': 'make'})
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
"
call dein#add('kchmck/vim-coffee-script')
call dein#add('lmeijvogel/vim-yaml-helper')
call dein#add('vim-ruby/vim-ruby')
call dein#add('scrooloose/nerdtree')
call dein#add('ag.vim')
call dein#add('utl.vim')
call dein#add('matchit.zip')
call dein#add('leafgarland/typescript-vim')
call dein#add('jason0x43/vim-js-indent')
call dein#add('Quramy/tsuquyomi')
call dein#add('majutsushi/tagbar')
call dein#add('tpope/vim-abolish')
call dein#add('tpope/vim-rails')
call dein#add('tpope/vim-cucumber')
call dein#add('tpope/vim-fugitive')
call dein#add('mhinz/vim-signify')
call dein#add('tpope/vim-speeddating')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-haml')
call dein#add('tpope/vim-endwise')
call dein#add('altercation/vim-colors-solarized')
call dein#add('tpope/vim-markdown')
call dein#add('tpope/vim-unimpaired')
call dein#add('tpope/vim-ragtag')
call dein#add('tpope/vim-commentary')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-sleuth')
"call dein#add('vim-scripts/VimClojure')
"call dein#add('jceb/vim-orgmode')
call dein#add('kien/ctrlp.vim')
call dein#add('groenewege/vim-less')
call dein#add('kien/rainbow_parentheses.vim')
call dein#add('mbbill/undotree')
call dein#add('ShowTrailingWhitespace')
call dein#add('DeleteTrailingWhitespace')
call dein#add('drmikehenry/vim-fontsize')
call dein#add('bling/vim-bufferline')
call dein#add('bling/vim-airline')
call dein#add('tpope/vim-flagship')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('paredit.vim')
call dein#add('Matt-Deacalion/vim-systemd-syntax')
call dein#add('elzr/vim-json')
call dein#add('elixir-lang/vim-elixir')
call dein#add('avdgaag/vim-phoenix')
call dein#add('exu/pgsql.vim')
call dein#add('ElmCast/elm-vim')

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
filetype plugin on
syntax on


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
set modelines=3
set printoptions=paper:a4
set ruler
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pdf
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
autocmd FileType ruby,json setlocal sw=2
autocmd FileType ruby,json setlocal ts=2
autocmd FileType ruby,json setlocal sts=2
autocmd FileType ruby,json setlocal sta
autocmd FileType ruby,json setlocal et
" autocmd FileType ruby,json call PareditInitBuffer()
" autocmd FileType javascript call PareditInitBuffer()
" autocmd FileType coffee call PareditInitBuffer()
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

let g:elm_format_autosave = 1
colorscheme solarized
