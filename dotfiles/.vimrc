" 20140201 - Martijn Pepping <martijn@xbsd.nl>
"
" My .vimrc for Vim, MacVim and Gvim/win32

"   0. VUNDLE SETUP
"   1. FILE HANDLING
"   2. LOOK & FEEL
"   3. FUNCTIONS
"   4. NETRW CFG
"   5. MACVIM
"   6. GVIM/WIN32
"   7. SPELL & DICT
"   8. PLUGINS


" ============
" VUNDLE SETUP
" ============

" temp. unset for Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'gmarik/vundle'

"Plugin 'Xuyuanp/nerdtree-git-plugin'
"Plugin 'ervandew/supertab'
"Plugin 'scrooloose/nerdtree'
"Plugin 'rizzatti/dash.vim'
Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'henrik/vim-indexed-search'
Plugin 'mbbill/undotree'
Plugin 'mhinz/vim-signify'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'rodjek/vim-puppet'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
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

" Markdown inline syntax highlighting
" ```ruby
" puts foo
" ````
au BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html']


" ===========
" LOOK & FEEL
" ===========

"color heroku-terminal
color molokai
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
set noshowmode        " disable the -- INSERT -- message, since we use Airline
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

" just don't forget sudo 
noremap  W :w !sudo tee %<CR><CR>
noremap  Q :w !sudo tee %<CR><CR>:q!<CR>

" Toggle set list with \+l
nnoremap <leader>l :set list!<CR>

" Toggle number with \+n
nnoremap <leader>n :set number!<CR>

" Toggle relativenumber with \+N
nnoremap <leader>N :set relativenumber!<CR>

" Toggle indentation chars
nnoremap <leader>m :IndentLinesToggle<CR>

" Toggle set paste with \+p
nnoremap <leader>p :set paste<CR>

" Toggle Syntastic
nnoremap <leader>t :SyntasticToggleMode<CR>

" Strip whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Select pasted text 
nnoremap <leader>v V`]

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Copy on mouse-select
noremap <LeftRelease> "+y<LeftRelease>

" I don't like ex mode
"nnoremap Q <nop>

" Toggle NERDtree
"nnoremap <leader>d :NERDTreeToggle<CR>
"nnoremap <leader>f :NERDTreeFind<CR>


" =========
" NETRW CFG
" =========

" netrw config - https://shapeshed.com/vim-netrw/
let g:netrw_banner=0 "no heading
let g:netrw_browse_split=3 "open in new tab/buffer
let g:netrw_altv=1 "open spilts to the right
let g:netrw_liststyle=3 "tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_winsize = 25

nnoremap <leader>d :Vexplore<CR>


" Toggle Vexplore with CTRL+E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

set autochdir " Change directory to the current buffer when opening files


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

  color molokai
  "color atom-dark
  "color blackboard
  "color codetool
  "color darkblue
  "color desert
  "color dracula
  "color evening
  "color heroku
  "color onedark

  nnoremap <leader>1 :colorscheme heroku<cr>
  nnoremap <leader>2 :colorscheme dracula<cr>
  nnoremap <leader>3 :colorscheme onedark<cr>
  nnoremap <leader>4 :colorscheme blackboard<cr>
  nnoremap <leader>5 :colorscheme molokai<cr>
  nnoremap <leader>6 :colorscheme atom-dark<cr>
  nnoremap <leader>6 :colorscheme desert<cr>
  nnoremap <leader>7 :colorscheme blue<cr>
  nnoremap <leader>8 :colorscheme default<cr>

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

" Spell check git commits
autocmd FileType gitcommit setlocal spell spelllang=en,nl


" =======
" PLUGINS
" =======

"let g:ctrlp_open_new_file = 't'             " open files in a new tab
"let g:NERDTreeWinPos = "right"              " show filebrowser on the right
"let g:nerdtree_tabs_open_on_gui_startup = 0 " no nerdtree by default in gui

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1 " alternate tab line

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:indentLine_enabled = 0

