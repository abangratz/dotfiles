set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'kchmck/vim-coffee-script'
Bundle 'lmeijvogel/vim-yaml-helper'
Bundle 'vim-ruby/vim-ruby'
Bundle 'scrooloose/nerdtree'
Bundle 'ack.vim'
Bundle 'utl.vim'
Bundle 'matchit.zip'
Bundle 'chrisbra/NrrwRgn'
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-fugitive'
Bundle 'mhinz/vim-signify'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-endwise'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-sleuth'
Bundle 'vim-scripts/VimClojure'
Bundle 'jceb/vim-orgmode'
Bundle 'kien/ctrlp.vim'
Bundle 'groenewege/vim-less'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'mbbill/undotree'
Bundle 'ShowTrailingWhitespace'
Bundle 'DeleteTrailingWhitespace'
Bundle 'drmikehenry/vim-fontsize'
Bundle 'bling/vim-bufferline'
Bundle 'bling/vim-airline'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'paredit.vim'

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
filetype plugin on
nnoremap <silent> <F8> :TagbarToggle<CR>
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
"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
let g:rails_statusline = 0
autocmd FileType ruby setlocal sw=2
autocmd FileType ruby setlocal ts=2
autocmd FileType ruby setlocal sts=2
autocmd FileType ruby setlocal sta
autocmd FileType ruby setlocal et
set wildignore+=*vendor/*,*/tmp/*,*/.git/*,*/log/*,tags
let g:ctrlp_custom_ignore = '\v[\/](vendor|coverage)/'
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
let g:DeleteTrailingWhitespace_Action = 'delete'
au Syntax * syntax keyword myTodo containedin=.*Comment contained WARNING NOTE
"use symbols in vim-airline
let g:airline_powerline_fonts=1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
