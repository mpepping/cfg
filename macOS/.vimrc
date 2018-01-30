" 20140201 - Martijn Pepping <martijn.pepping@automiq.nl>
"
" My .vimrc for Vim, MacVim and Gvim/win32

"   1. LOOK & FEEL
"   2. FILE HANDLING
"   3. MAPPINGS
"   4. NETRW CFG
"   5. GVIM/WIN32
"   6. SPELL & DICT
"   7. PLUGINS

" ===========
" LOOK & FEEL
" ===========

color molokai
"color heroku-terminal

set background=dark
set backspace=2
set hlsearch
set ignorecase
set matchtime=2                " how many tenths of a second to blink when matching brackets
set noshowmode                 " disable the -- INSERT -- message, since we use Airline
set number                     " set relativenumber is <leader>N
set paste
set ruler                      " always show current position
set showmatch                  " show matching brackets when text indicator is over them
set smartcase
set title                      " set terminal title
set complete+=i,kspell         " added kspell, to add from dict when spell is set.


" =============
" FILE HANDLING
" =============

set encoding=utf8              " set utf8 as standard encoding and en_US as the standard language
set fileformats=unix,dos       " use Unix as the standard file type
set foldmethod=marker          " folding {{{ }}}
set linebreak                  " line break
set textwidth=500              " text width

set autoindent                 " indent per filetype
filetype plugin indent on      " https://www.reddit.com/r/vim/wiki/vimrctips#wiki_do_not_use_smartindent

set tabstop=4                  " the width of a hard tab, measured in spaces
set shiftwidth=2               " set shiftwidth, e.g. tab inserts two spaces
set expandtab                  " spaces instead of hard tabs

" Syntax highlighting for fenced languages
let g:markdown_fenced_languages = ['css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html', 'python', 'bash=sh']

" Jenkinsfile == groovy
augroup set_filetypes
  autocmd!
  autocmd BufNewFile,BufRead Jenkinsfile setf groovy
augroup END

" Spell check filetype or buffer
augroup spellcheck_documentation
  autocmd!
  autocmd BufNewFile,BufRead *.md setlocal spell
  autocmd BufNewFile,BufRead *.rdoc setlocal spell
  autocmd BufNewFile,BufRead *.txt setlocal spell
  autocmd FileType gitcommit setlocal spell
augroup END


" ========
" MAPPINGS
" ========

" Just don't forget sudo
nnoremap W :w !sudo tee %<CR><CR>
nnoremap Q :w !sudo tee %<CR><CR>:q!<CR>

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
noremap <leader>v V`]

" Copy on mouse-select
noremap <LeftRelease> "+y<LeftRelease>


" ======
" MACVIM
" ======

if has("gui_running") && has("mac")
"  set guioptions=-t            "no tearoff menu
"  set guioptions-=T            "hide menubar
"  set guioptions+=e            "use gui tabs
"  set guitablabel=%M\ %t
  set visualbell               "no bell
  set lines=999 columns=999    "max window size

  color blackboard
  "color atom-dark
  "color codetool
  "color darkblue
  "color desert
  "color dracula
  "color evening
  "color heroku
  "color molokai
  "color onedark

  nnoremap <leader>1 :colorscheme heroku<cr>
  nnoremap <leader>2 :colorscheme dracula<cr>
  nnoremap <leader>3 :colorscheme onedark<cr>
  nnoremap <leader>4 :colorscheme blackboard<cr>
  nnoremap <leader>5 :colorscheme molokai<cr>
  nnoremap <leader>6 :colorscheme atom-dark<cr>
  nnoremap <leader>7 :colorscheme blue<cr>
  nnoremap <leader>8 :colorscheme default<cr>

  set guifont=Menlo\ for\ PowerLine:h14
  "set guifont=Menlo\ Regular:h14
endif


" ==========
" GVIM/WIN32
" ==========

if has("win32") || has("win16")
  set guifont=Lucida_Console:h10:cANSI

  " set options and add mapping such that Vim behaves a lot like MS-Windows
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
  "map <C-V> "+gP
  map <S-Insert> "+gP

  cmap <C-V> <C-R>+
  cmap <S-Insert> <C-R>+

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

" :mkspell ~/.vim/spell/nl /usr/lib/openoffice.org2.0/share/dict/ooo/nl_NL
" :mkspell ~/.vim/spell/en /usr/lib/openoffice.org2.0/share/dict/ooo/en_GB
" :mkspell! ~/.vim/spell/en /usr/lib/openoffice.org2.0/share/dict/ooo/en_US
"if (has("spell") == 1) && (filereadable("~/.vim/spell") == 1)
if has("spell")
  " z= suggesties
  " ]s volgende misspelled
  setlocal spell spelllang=en,nl
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

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:indentLine_enabled = 0

