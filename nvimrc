set t_Co=256

set clipboard=unnamed
set hidden
set history=1000
set laststatus=2
set ruler
set scrolloff=3
set title
set viminfo=%,'50,\"100,/50,:100,h,n~/.viminfo

" Spelling
set spell spelllang=en_us

" Sane tabs
set tabstop=4
set shiftwidth=4
set smartindent
set expandtab

" Line numbers
set number relativenumber
:au FocusLost * :set number norelativenumber
:au FocusGained * :set relativenumber

autocmd InsertEnter * :set number norelativenumber
autocmd InsertLeave * :set relativenumber

" Fix % to work with more stuff
runtime macros/matchit.vim

" Command completion ++
set wildmenu

" Smarter searching
set ignorecase
set smartcase

" Backup to set directory instead of current
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Clear search
:command! C let @/=""

set fillchars+=diff:⣿
set fillchars+=vert:│
set fillchars+=fold:-

" A visual cue for line-wrapping.
let &showbreak = '↪ '
set wrap

" Visual cues when in 'list' model.
set listchars+=eol:¬
set listchars+=extends:❯
set listchars+=precedes:❮
set listchars+=trail:⋅
set listchars+=nbsp:⋅
set listchars+=tab:\|\ 

" Keep some spacing.
set sidescrolloff=1

" Filetype settings
autocmd BufRead,BufNewFile inline.html,config.html :set filetype=velocity
autocmd BufRead,BufNewFile *.json :set filetype=javascript
autocmd BufRead,BufNewFile *.aspx :set filetype=html
autocmd BufRead,BufNewFile *.less :set filetype=less
autocmd BufRead,BufNewFile afiedt.buf :set filetype=sql
autocmd BufNewFile,BufReadPost *.md :set filetype=markdown

let mapleader = " "

map <Leader>t :CtrlP<cr>
map <Leader>w :Goyo<cr>
map <Leader>be :CtrlPBuffer<cr>
map <Leader>u :GundoToggle<CR>
map <Leader>n :NERDTreeToggle<CR>

" Swap jump to mark keys
nnoremap ' `
nnoremap ` '

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" Arrow results navigation
nmap <silent> <RIGHT>           :cnext<CR>
nmap <silent> <RIGHT><RIGHT>    :cnfile<CR><C-G>
nmap <silent> <LEFT>            :cprev<CR>
nmap <silent> <LEFT><LEFT>      :cpfile<CR><C-G>

" Perforce...
nnoremap @p4e :!p4 edit '%'<cr>
nnoremap @p4r :!p4 revert '%'<cr>
nnoremap @p4s :!p4 submit '%'<cr>
nnoremap @p4a :!p4 add '%'<cr>

" remap jj kk hh lll in insert to go to normal
inoremap jk <esc>
inoremap jj <esc>jj
inoremap kk <esc>kk
inoremap hh <esc>hh
inoremap lll <esc>lll

" Arrow results navigation
nmap <silent> <RIGHT>           :cnext<CR>
nmap <silent> <RIGHT><RIGHT>    :cnfile<CR><C-G>
nmap <silent> <LEFT>            :cprev<CR>
nmap <silent> <LEFT><LEFT>      :cpfile<CR><C-G>

" Ctrl-P options

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

"let g:ctrlp_working_path_mode = 'ra' " Nearest ancestor with .git, .hg... then current file or current working dir
let g:ctrlp_working_path_mode = 'ra' " It seems the r is having trouble with tetra... go figure. I'll figure it out... eventually...

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Makers
let g:neomake_javascript_eslint_maker = {
    \ 'args': ['--verbose'],
    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
    \ }
let g:neomake_javascript_enabled_makers = ['eslint']

let g:neomake_html_tidy5_maker = {
    \ 'args': ['-e', '-q', '--gnu-emacs', 'true'],
    \ 'errorformat': '%A%f:%l:%c: Warning: %m',
    \ }
let g:neomake_html_enabled_makers = ['tidy5']

let g:neomake_less_lessc_maker = {
    \ 'args': ['--lint', '--no-color'],
    \ 'errorformat':
        \ '%m in %f on line %l\, column %c:,' .
        \ '%m in %f:%l:%c,' .
        \ '%-G%.%#'
    \ }
let g:neomake_less_enabled_makers = ['lessc']

if $TMUX != '' 
  " integrate movement between tmux/vim panes/windows

  fun! TmuxMove(direction)
    " Check if we are currently focusing on a edge window.
    " To achieve that,  move to/from the requested window and
    " see if the window number changed
    let oldw = winnr()
    silent! exe 'wincmd ' . a:direction
    let neww = winnr()
    silent! exe oldw . 'wincmd'
    if oldw == neww
      " The focused window is at an edge, so ask tmux to switch panes
      if a:direction == 'j'
        call system("tmux select-pane -D")
      elseif a:direction == 'k'
        call system("tmux select-pane -U")
      elseif a:direction == 'h'
        call system("tmux select-pane -L")
      elseif a:direction == 'l'
        call system("tmux select-pane -R")
      endif
    else
      exe 'wincmd ' . a:direction
    end
  endfun

  nnoremap <silent> <c-w>j :silent call TmuxMove('j')<cr>
  nnoremap <silent> <c-w>k :silent call TmuxMove('k')<cr>
  nnoremap <silent> <c-w>h :silent call TmuxMove('h')<cr>
  nnoremap <silent> <c-w>l :silent call TmuxMove('l')<cr>

  " Quickly restart your debugger/console/webserver. Eg: if you are developing a node.js web app
  " in the 'serve.js' file you can quickly restart the server with this mapping:
  nnoremap <silent> <f5> :call SlimuxSendKeys('C-C " node serve.js" Enter')<cr>
  " pay attention to the space before 'node', this is actually required as send-keys will eat the first key

endif

autocmd! BufWritePost * Neomake

call plug#begin('~/.vim/plugged')

Plug 'avakarev/vim-watchdog'
Plug 'benekastah/neomake'
Plug 'christoomey/vim-tmux-navigator'
Plug 'janko-m/vim-test'
Plug 'kien/ctrlp.vim'
Plug 'lepture/vim-velocity'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'sheerun/vim-polyglot'
Plug 'sjl/gundo.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'wesQ3/vim-windowswap'
Plug 'willsp/vim-colors-solarized'

call plug#end()

" Colors
syntax enable
set background=dark

let g:solarized_termcolors=16
colorscheme solarized

" Setup toggle for remoting where others don't have solarized on their term
function! ToggleColors()
    if g:solarized_termcolors == 16
        let g:solarized_termcolors=256
        set background=dark
        colorscheme solarized
    else
        let g:solarized_termcolors=16
        set background=dark
        colorscheme solarized
    endif
endfunction

