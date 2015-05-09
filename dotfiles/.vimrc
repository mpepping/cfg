" 20140201 - Martijn Pepping <martijn@xbsd.nl>
"
" My .vimrc for Vim, MacVim and Gvim/win32

"   0. VUNDLE SETUP
"   1. FILE HANDLING
"   2. LOOK & FEEL
"   3. FUNCTIONS
"   4. MACVIM
"   5. GVIM/WIN32
"   6. SPELL & DICT
"   7. PLUGINS


" ============
" VUNDLE SETUP
" ============

" temp settings
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#begin()

"Plugin 'gmarik/vundle'

Plugin 'bling/vim-airline'
Plugin 'ddollar/nerdcommenter'
Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'henrik/vim-indexed-search'
Plugin 'mhinz/vim-signify'
Plugin 'rizzatti/dash.vim'
Plugin 'rodjek/vim-puppet'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-ruby/vim-ruby'
Plugin 'yggdroot/indentLine'

call vundle#end()


" =============
" FILE HANDLING
" =============

filetype plugin indent on

if (has("syntax") !=0)
    syntax on
endif

set expandtab         " soft tabs
set tabstop=2         " set tabstops
set shiftwidth=2      " set shiftwidth
set softtabstop=2     " delete this many spaces upon deleting soft tab
set smarttab          " seems smart ;-)
set fdm=marker        " folding {{{ }}}
set encoding=utf8     " set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac  " use Unix as the standard file type

set lbr               " line break
set tw=500            " text width

set ai                " auto indent
set si                " smart indent
set wrap              " wrap lines

"autocmd BufNewFile,BufRead *.pp set filetype=ruby


" ===========
" LOOK & FEEL
" ===========

color heroku-terminal
set title           " set terminal title
set bg=dark
set backspace=2
set nocp
set ruler
set incsearch
set smartcase
set hlsearch
set ignorecase
"set relativenumber
set number
set paste
set ruler             " always show current position
set showmatch         " show matching brackets when text indicator is over them
set mat=2             " how many tenths of a second to blink when matching brackets
set laststatus=2      " always show the status line
set magic             " for regex
"set list              " for whitespace, tabs and line-endings

set complete=.,w,b,u,t,i,kspell "added kspell, to add from dict when spell is set.



" =========
" FUNCTIONS
" =========

" Markdown to HTML
nmap <leader>md :%!/Users/martijn/bin/Markdown.pl --html4tags<cr></cr></leader>

nmap <leader>l :set list!<cr>            " Toggle set list with \+l.
nmap <leader>n :set number!<cr>          " Toggle number with \+n
nmap <leader>N :set relativenumber!<cr>  " Toggle relativenumber with \+N


" Markdown inline syntax highlighting
" ```ruby
" puts foo
" ````
au BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html']


" Copy on mouse-select
:noremap <LeftRelease> "+y<LeftRelease>


" ======
" MACVIM
" ======

" Set options and add mapping specific for MacVim

if has("gui_running")
"if has("mac") || has("macunix")  " messes up vim coloscheme in  terminal (brew vim74)
  set guioptions=-t           "no tearoff menu
  set guioptions-=T           "hide menubar
  set guioptions+=e           "use gui tabs
  set guitablabel=%M\ %t
  set vb                      "no bell
  "set lines=48 columns=160    "sane window size
  set lines=999 columns=999   "max window size

  color heroku
  "color atom-dark
  "color codetool
  "color darkblue
  "color molokai
  "color blackboard
  "color desert
  "color evening

  set guifont=Menlo\ for\ PowerLine:h14
  "set guifont=Menlo\ Regular:h14
  "set guifont=Consolas:h16
  set t_Co=256

endif


" ==========
" GVIM/WIN32
" ==========

if has("win32") || has("win16")
  set guifont=Lucida_Console:h10:cANSI

  " Set options and add mapping such that Vim behaves a lot like MS-Windows
  " Stolen from: source $VIMRUNTIME\mswin.vim

  set directory=.,$TEMP
  set lines=48 columns=120
  set clipboard=unnamed
  set backspace=indent,eol,start

  " backspace in Visual mode deletes selection
  vnoremap <BS> d

  " CTRL-X and SHIFT-Del are Cut
  vnoremap <C-X> "+x
  vnoremap <S-Del> "+x

  " CTRL-C and CTRL-Insert are Copy
  vnoremap <C-C> "+y
  vnoremap <C-Insert> "+y

  " CTRL-V and SHIFT-Insert are Paste
  "map <C-V>    "+gP
  map <S-Insert>    "+gP

  cmap <C-V>    <C-R>+
  cmap <S-Insert>   <C-R>+

  " CTRL-Tab is Next window
  noremap <C-Tab> <C-W>w
  inoremap <C-Tab> <C-O><C-W>w
  cnoremap <C-Tab> <C-C><C-W>w
  onoremap <C-Tab> <C-C><C-W>w

  " CTRL-F4 is Close window
  noremap <C-F4> <C-W>c
  inoremap <C-F4> <C-O><C-W>c
  cnoremap <C-F4> <C-C><C-W>c
  onoremap <C-F4> <C-C><C-W>c
endif


" ============
" SPELL & DICT
" ============

" /usr/share/vim/vim70/doc/spell.txt.gz
" rpm -ivh openoffice.org-langpack-nl
" :mkspell ~/.vim/spell/nl /usr/lib/openoffice.org2.0/share/dict/ooo/nl_NL
" :mkspell ~/.vim/spell/en /usr/lib/openoffice.org2.0/share/dict/ooo/en_GB
" :mkspell! ~/.vim/spell/en /usr/lib/openoffice.org2.0/share/dict/ooo/en_US
"if (has("spell") == 1) && (filereadable("~/.vim/spell") == 1)
if has("spell")
" z= suggesties
" ]s volgende misspelled
" kies een taal & zet spell checking aan (vim>=7.x)
" setlocal spell spelllang=nl
        setlocal spell spelllang=en
        set nospell
        highlight clear SpellBad
        highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline gui=underline
        highlight clear SpellCap
        highlight SpellCap term=underline cterm=underline gui=underline
        highlight clear SpellRare
        highlight SpellRare term=underline cterm=underline gui=underline
        highlight clear SpellLocal
        highlight SpellLocal term=underline cterm=underline gui=underline
endif


" =======
" PLUGINS
" =======

"let g:ctrlp_open_new_file = 't'             " open files in a new tab
"let g:NERDTreeWinPos = "right"              " show filebrowser on the right
"let g:nerdtree_tabs_open_on_gui_startup = 0 " no nerdtree by default in gui
let g:airline_powerline_fonts = 1
"let g:Powerline_symbols = 'fancy'
"let g:Powerline_mode_V="V·LINE"
"let g:Powerline_mode_cv="V·BLOCK"
"let g:Powerline_mode_S="S·LINE"
"let g:Powerline_mode_cs="S·BLOCK"
let loaded_delimitMate = 1
let delimitMate_autoclose = 1
