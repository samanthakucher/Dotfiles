let mapleader = ","                               " Define ',' as leader.
set rtp+=/usr/local/opt/fzf                       " fzf fuzzy finder.
set t_Co=256                                      " Use 256-color terminal.
set foldlevel=99                                  " Open files with all folds open
set nocompatible                                  " Truly running VI iMproved.
set splitbelow                                    " Horizontal split windows
set splitright
set showtabline=0                                 " No tabline at the fuck#@g top!

" External configurations that affect the VIM experience {{{
"  Also mapped CAPS to give me ctrl! its very convenient!
"  this is accomplished by using Seil (separate program on MAC).
" }}}
" Vim-Plug plugin manager settings {{{
call plug#begin('~/.vim/plugged')
" Plugins {{{
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'guns/xterm-color-table.vim'
Plug 'mbbill/VimExplorer'
Plug 'tweekmonster/startuptime.vim'
Plug 'godlygeek/tabular', {'on': 'Tabularize'}
Plug 'pablocobelli/vim-tmux-runner'              " Send lines to another tmux pane.
" Plug 'itchyny/lightline.vim'
" Plug 'daviesjamie/vim-base16-lightline'
Plug 'suan/vim-instant-markdown', { 'on': 'InstantMarkdownPreview' }                  " Instant markdown preview in browser.
Plug 'Yggdroot/indentLine'                       " Show indenting lines.
Plug 'mattn/webapi-vim'                          " Needed for gist-vim
Plug 'pablocobelli/gist-vim'                     " Create and manage github gists.
Plug 'chriskempson/base16-vim'                   " Base16 themes.
Plug '/usr/local/opt/fzf'                        " For using fzf with vim. Both lines needed. 
Plug 'junegunn/fzf.vim'                          " For using fzf with vim. Both lines needed.
Plug 'vim-scripts/MatlabFilesEdition'            " Matlab syntax hightlighting and +.
Plug 'tpope/vim-commentary'                      " Commenting
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}                      " FileTree
Plug 'tpope/vim-dispatch'
Plug 'LaTeX-Box-Team/LaTeX-Box'
" }}}
call plug#end()

" ----------------------------------------------------------------------------
" Vim-Plug Configuration.
" Commands execute in new tab.
let g:plug_window = "tab new"
" ----------------------------------------------------------------------------

let g:lightline = {
      \ 'colorscheme': 'base16',
      \ }

set timeout timeoutlen=3000 ttimeoutlen=100

" }}}
" Edit_VIMRC {{{ 
augroup EditVimRC
    autocmd!
    autocmd BufWinEnter ~/.vimrc normal zM 
augroup END
" }}}
" NERDTree configuration {{{
"  Set modified width (default is 31).
let g:NERDTreeWinSize=40
" }}}
" NERDTreeTabs configurations {{{
" Map NERDTree across tabs toggle on/off.
" map <leader>k :NERDTreeTabsToggle<CR><C-w><C-w> 
" Open NERDTree on console vim startup.
let g:nerdtree_tabs_open_on_console_startup=0
let g:nerdtree_tabs_open_on_gui_startup=0
let NERDTreeShowBookmarks=1
" nnoremap <leader>; <C-w><C-w>
" }}}
" Colorcolumn activation/deactivation {{{
"  Slightly color 79th column as a ruler
set colorcolumn=79
"  Define a function to toggle colorcolumn
if !exists("*ColorColumnToggle")
    function ColorColumnToggle()
        if(&colorcolumn > 0)
            set colorcolumn=0
        else
            set colorcolumn=79
        endif
    endfunc
endif
noremap <leader>co :call ColorColumnToggle()<CR>
"  By default, turn it off
call ColorColumnToggle()
" }}}
" Vim-Tmux-Runner configuration {{{
" Do not clear runner before sending lines!
let g:VtrClearBeforeSend = 0
" Highlights the runners running the listed commands
"  when displaying the list of runners to choose from
" let g:vtr_highlight_runner = [ 'Python', 'Vim' ]
let g:vtr_highlight_runner = [ 'python3.5', 'python3.6' ]
" Usage: 
"  <leader>l will send selected block to a tmux session
" If no selected block, <leader>l will execute the whole file. 
let g:vtr_filetype_runner_overrides = {
    \ 'python': '%run {file}',
    \ 'matlab': 'run {file}'}
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 0

augroup Pythonic
    autocmd!
    " For IPython integration.
    autocmd FileType python nmap <leader>l :VtrSendFile<CR>
    autocmd FileType python xmap <leader>l :VtrSendLinesToRunner<CR> 
    " Completion via (default) omni-completion using pyhthon3
    autocmd FileType python set omnifunc=python3complete#Complete
augroup END
augroup Matlabic
    autocmd!
    " For MATLAB integration.
    autocmd FileType matlab nmap <leader>l :VtrSendFile<CR>h
    autocmd FileType matlab nmap <leader>k ?%%<CR>v*:VtrSendLinesToRunner<CR>''<ESC>
    autocmd FileType matlab xmap <leader>l :VtrSendLinesToRunner<CR>
augroup END
let g:slime_target = "tmux"
" My very own Vim-Tmux-Runner custom shortcuts
command! VA VtrAttachToPane
" }}}
" Source the vimrc file after saving it {{{
augroup ReloadingVimRC
    autocmd!
    if has("autocmd")
        autocmd BufWritePost ~/.vimrc nested source $MYVIMRC  
    endif
augroup END
augroup ReloadingVimINIT (for neovim)
    autocmd!
    if has("autocmd")
        autocmd BufWritePost ~/.vim/init.vim nested source $MYVIMRC  
    endif
augroup END
" }}}
let g:move_key_modifier = 'C'
" }}}
" Indent-related configurations to comply with PEP8 {{{
set textwidth=79   " Lines longer than 79 columns will be broken.
set shiftwidth=4   " Operation >> indents 4 columns; << unindents 4 columns.
set tabstop=4      " A hard TAB displays as 4 columns.
set expandtab      " Insert spaces when hitting TABs.
set softtabstop=4  " Insert/delete 4 spaces when hitting a TAB/BACKSPACE.
set shiftround     " Round indent to multiple of 'shiftwidth'.
set autoindent     " Align the new line indent with the previous line.
set relativenumber " Set relative numbering of lines.
set number
" }}}
" View invisible characters such as 'tab' and 'end of line' with glyphs {{{
"  Use :set nolist to turn off invisible chars
set listchars=tab:▸\ ,eol:¬
" List toggle (activation/deactivation).
noremap <leader>sc :set list!<CR>
" }}}
" Instant Markdown Preview {{{
" Open manually
let g:instant_markdown_autostart = 0
" }}}
" Stop using arrow keys to move {{{
"  in normal mode, input mode and visual mode.
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
vnoremap <Up> <NOP>
vnoremap <Down> <NOP>
vnoremap <Left> <NOP>
vnoremap <Right> <NOP>
" }}}
" Backup files, swap files and undo {{{
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" }}}
" Miscellanea {{{
set cmdheight=1                                  " explicitly set the height of the command line.
set showcmd                                      " Show (partial) command in status line.

set incsearch                                    " Pattern is matched as you type.
set hlsearch

set mouse=a    " Use mouse.

set scrolloff=5                    " scroll before reaching bottom edge
nnoremap <leader>vf :e $MYVIMRC<CR>  
nnoremap <leader>vg :e $MYGVIMRC<CR> 
set formatoptions=tcroql  " Reformat/reflow a paragraph of text.
nnoremap Q gqap
set guioptions=       " Remove all scroll bars.
set clipboard=unnamed " Uses system's clipboard.
set laststatus=2      " Always show statusline.
set noshowmode        " Hide the default mode text (e.g. -- INSERT -- below the statusline).

set wildmenu 
set wildmode=list:longest,full
set backspace=indent,eol,start

" Open file under cursor in new tab.
nnoremap <leader>fr <C-w>gf
" }}}
" {{{ Clear highlighting of found terms on escape in normal mode
"   The first line does the trick, the second one prevents vim from
"   doing weird things after remapping <esc> the first time.
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[
" }}}

" Added to easily replace unicode characters after
" copy-pasting from pdfs or getting text from pdfs by using
" pdftotext (poppler utils)
" To be called by doing
" :call LatexAccents()
" function! g:LatexAccents()
"     " How to type these next lines is very important for functionality.
"     " It should be typed like:
"     " :%s/a<Ctrl-v>u0301/\\'a/g
"     " with the exception of the line involving accented i, which is typed as:
"     " :%s/<Ctrl-v>u0131<Ctrl-v>u0301/\\'\\i/g
"     " u0301 = unicode character for spanish accent
"     " u0131 = unicode character for dotless i char
"     " Note: the 'e' at the end of every line makes the command silent, so
"     " the phrase 'Pattern not found' is omitted (if it's the case)
"     :%s/á/\\'a/ge
"     :%s/é/\\'e/ge
"     :%s/ı́/\\'\\i /ge
"     :%s/\\'\\i /\\'\\i\\/ge
"     :%s/ó/\\'o/ge
"     :%s/ú/\\'u/ge
"     :%s/Ω/$\\Omega$/ge
"     :%s/◦/$^{\\circ}$/ge
" endfunction

" Send command to runner (needs VTR)
abbrev SC VtrSendCommandToRunner

" Prettier indent symbol for indentLine
let g:indentLine_char = '│'
let g:indentLine_enabled = 1

" Use Tab & Shift-Tab to cycle through open buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" To prevent the display of error message
" E37: No write since last change (add ! to override)
" when switching buffers!
set hidden

" Hardcopy header customization
set pheader=%<%f%h%m%40{strftime(\"%I:%M:%S\ \%p,\ %a\ %b\ %d,\ %Y\")}%=Page\ %N

" Surround character with spaces (for python)
noremap <leader>ss diwi<SPACE><C-R>"<SPACE><ESC>B

" Gist-vim setup
" Options
let g:gist_post_private = 1
let g:gist_show_privates = 1
let g:gist_detect_filetype = 1
let g:gist_clip_command = 'pbcopy'
let g:gist_list_rightbelow = 0
let g:gist_get_multiplefile = 0
" let g:gist_edit_with_buffers = 0
" Shortcut for listing my gists on github
nnoremap <leader>gh :Gist -l pablocobelli<CR>

" TURBO FAST MODE
" Ejecutar esto para cambiar el keyrepeat: defaults write NSGlobalDomain KeyRepeat -int 1
set lazyredraw            " Wait to redraw
set ttyfast

" Changes the theme to coincide with the shell theme
" (if base16 is installed)
let base16colorspace=256 
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif
highlight LineNr cterm=NONE ctermbg=0 ctermfg=0
highlight CursorLineNr cterm=NONE ctermbg=0 ctermfg=3
" }}}
"
" Remember last position on file when starting up
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Nerdtree
map <leader>o :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Comfortable motion vim
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k" 

" See all symbols in tex
let g:tex_conceal = ""

" The following line is to allow to see special markdown symbols in the
" source (.md, .markdown) file, which tend to be hidden by default.
" This solution works particularly when using indentLine plugin (as I am, right
" now).
let g:indentLine_fileTypeExclude = ['md', 'markdown']

" FZF fuzzy finder configuration
"  Open in TMUX pane
let g:fzf_prefer_tmux = 1
"  Mappings on fzf
nnoremap <C-T> :Files<CR>
nnoremap <C-C> :Buffers<CR>
nnoremap <silent> <leader>tv :call fzf#run({ 'source': 'ag -g ""', 'sink': 'vsplit' })<cr>
nnoremap <silent> <leader>th :call fzf#run({ 'source': 'ag -g ""', 'sink': 'split' })<cr>

" Mapping to change to current file directory
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Remember cursor position and file location in window when switching buffers
if v:version >= 700
  au BufLeave * let b:winview = winsaveview()
  au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
endif

" LatexBox TOC is genius!
"  Setting width
let g:LatexBox_split_width=70
"  <leader>+kk toggles the LatexTOC and changes back to originating window
nnoremap <leader>kk :LatexTOCToggle<CR><C-W>p
" These two are needed (both!) for the TOC to be built from the 'auxfiles/' directory
" where all .aux files are! Otherwise TOC doesn't show and gives error
let g:LatexBox_aux_dir="auxfiles"
let g:LatexBox_build_dir="auxfiles"

" For completion using (default) omnicomplete
filetype plugin on
set omnifunc=syntaxcomplete#Complete
autocmd CompleteDone * pclose
set completeopt+=longest,menuone

" Tabularize
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" More indenting (2 spaces) for wrapped lines
if has('linebreak')
    set breakindent
    if exists('&breakindentopt')
        set breakindentopt=shift:2
    endif
end

" Vertical split color (leave as reference)
hi vertsplit ctermfg=green ctermbg=black
" Space as fill char (next line has an extra space at end)
" set fillchars+=vert:\ 
if has('windows')
    set fillchars=vert:│
endif
" Special character indicating a wrapped line
if has('linebreak')
    let &showbreak='⤷ '                 
endif

" move easily between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" easily resize splits
" ???


" Italics in vim for comments
highlight Comment cterm=italic

" Wipe buffer using '-' key
nnoremap - :bw<CR>

" netrw (ejecutar con :Sex)
" do not use banner
let g:netrw_banner = 0
" open files in new tab
let g:netrw_browse_split = 3
" tree-style
let g:netrw_liststyle = 3

set cursorline

" Abbreviations for command-line
cnoreabbrev tmuxconf ~/.tmux.conf
cnoreabbrev hsconf ~/.hammerspoon/init.lua
cnoreabbrev baliases ~/.bash_aliases
cnoreabbrev bprofile ~/.bash_profile

augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au BufEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
    au BufLeave * setlocal nocursorline
augroup END

" Help in another tab
nnoremap <leader>h :tab h 

" - Nueva funcionalidad que me gustaria tener
"     - customizar la statusline
"     - customizar como cambia la statusline cuando tengo foco y cuando abandono
"        foco

function! StatusLineGetPath  () 
  let g:Statusline_Max_Path = 30 
  let p = expand('%') "relative to current path, and head path only 
  " let p = substitute(p,'','/','g') 
  let p = substitute(p, '^\V' . $HOME, '~', '') 
  if len(p) > g:Statusline_Max_Path 
    let p = simplify(p) 
    let p = pathshorten(p) 
  endif 
  return p 
endfunction 

" Resetting pre-defined styles
hi StatusLine   ctermfg=19  ctermbg=19  cterm=NONE
hi StatusLineNC ctermfg=19  ctermbg=19  cterm=NONE
" Defining my own styles
hi StatusLineItalicStyle    cterm=italic  ctermbg=19   ctermfg=19
hi StatusLineLeftArrowBody  cterm=none    ctermbg=14   ctermfg=19
hi StatusLineModeIndicator  cterm=bold    ctermbg=14   ctermfg=19
hi StatusLineLeftArrowTip   cterm=none    ctermbg=19   ctermfg=14
hi StatusLineRightArrowTip  cterm=none    ctermbg=19   ctermfg=20
hi StatusLineRightArrowBody cterm=none    ctermbg=20   ctermfg=19

function! SetActiveStatusLine ()
  setlocal statusline=
  setlocal statusline+=%#StatusLineLeftArrowBody#
  setlocal statusline+=\ \ 
  setlocal statusline+=%#StatusLineModeIndicator#
  setlocal statusline+=%{mode()}
  setlocal statusline+=\ \  
  setlocal statusline+=%#StatusLineLeftArrowTip#
  setlocal statusline+=
  setlocal statusline+=\ 
  setlocal statusline+=%m
  setlocal statusline+=\ 
  " setlocal statusline+=%f}
  setlocal statusline+=%-0.30{StatusLineGetPath()}%0* 
  setlocal statusline+=\ %y

  setlocal statusline+=%=        " Switch to the right side
  setlocal statusline+=%#StatusLineRightArrowTip#
  setlocal statusline+=
  setlocal statusline+=%#StatusLineRightArrowBody#
  setlocal statusline+=\ 
  setlocal statusline+=%l
  setlocal statusline+=/ 
  setlocal statusline+=%L
  setlocal statusline+=\ 
  setlocal statusline+=c
  setlocal statusline+=\ 
  setlocal statusline+=%c
  setlocal statusline+=\ 
  setlocal statusline+=%P
  setlocal statusline+=\ 
endfunction

function! SetInactiveStatusLine ()
  setlocal statusline=
  setlocal statusline+=%#StatusLineItalicStyle#
  setlocal statusline+=\ \ \ \ \ \ \ 
  setlocal statusline+=\ 
  setlocal statusline+=%-0.30{StatusLineGetPath()}%0* 
  setlocal statusline+=%=        
endfunction

augroup statuslinecustomization
    au!
    autocmd VimEnter * :call SetActiveStatusLine()
    autocmd BufEnter * :call SetActiveStatusLine()
    autocmd WinEnter * :call SetActiveStatusLine()
    autocmd BufLeave * :call SetInactiveStatusLine()
    autocmd WinLeave * :call SetInactiveStatusLine()
augroup END


