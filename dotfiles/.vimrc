" ============
" VUNDLE SETUP
" ============

" temp. unset for Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'gmarik/vundle'

call vundle#end()



" =============
" REGULAR STUFF
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

au BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html']


" ===========
" LOOK & FEEL
" ===========

color heroku-terminal
"color molokai
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

" tab navigation
nnoremap H gT
nnoremap L gt

" =========
" NETRW CFG
" =========

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

" Spell check git commits
autocmd FileType gitcommit setlocal spell spelllang=en,nl

augroup spellcheck_documentation
  autocmd BufNewFile,BufRead *.md setlocal spell
  autocmd BufNewFile,BufRead *.rdoc setlocal spell
augroup END

" =======
" PLUGINS
" =======

set statusline+=%#warningmsg#
set statusline+=%*
let g:indentLine_enabled = 0

