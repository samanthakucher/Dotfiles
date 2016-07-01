" {{{ Terminal colorspace
set t_Co=256                                      " Use 256-color terminal.
" }}}
set foldmethod=marker                             " Use marker as fold method
set foldlevel=99
set nocompatible                                  " Truly running VI iMproved.
let mapleader = ","                               " Define ',' as leader.
let base16colorspace=256 
set splitbelow                                    " Horizontal split windows appear below current 

" External configurations that affect the VIM experience {{{
"  Also mapped CAPS to give me ctrl! its very convenient!
"  this is accomplished by using Seil (separate program on MAC).
" }}}
" Vim-Plug plugin manager settings {{{
call plug#begin('~/.vim/plugged')
" Plugins {{{
Plug 'scrooloose/nerdtree'                       " NERDTree.
Plug 'jistr/vim-nerdtree-tabs'                   " NERDTree through all tabs.
Plug 'scrooloose/NERDCommenter'                  " NERDCommenter for easy commenting.
Plug 'pablocobelli/vim-tmux-runner'              " Send lines to another tmux pane.
Plug 'osyo-manga/vim-over'                       " Substitute preview in real time.
Plug 'Tpope/vim-surround'                        " Surround test easily.
Plug 'tmhedberg/SimpylFold'                      " Fold code easily.
Plug 'MattesGroeger/vim-bookmarks'               " Bookmark lines in files.
Plug 'davidhalter/jedi-vim'                      " Python jedi.
Plug 'godlygeek/tabular'                         " Align to symbols.
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git' " Fuzzy file search.
Plug 'FelikZ/ctrlp-py-matcher'                   " Best matcher for ctrlp.
Plug 'jeffkreeftmeijer/vim-numbertoggle'         " Clever number toggling.
Plug 'Raimondi/delimitMate'                      " Auto-insert matching delimiters.
Plug 'jeetsukumaran/vim-buffergator'             " Switch buffers with ease.
Plug 'vim-airline/vim-airline'                   " Airline (no python needed).
Plug 'vim-airline/vim-airline-themes'            " Themes for Airline.
Plug 'christoomey/vim-tmux-navigator'            " Navigate tmux panes as vim's.
Plug 'suan/vim-instant-markdown'                 " Instant markdown preview in browser.
Plug 'chriskempson/base16-vim'                   " Base16 colors for vim.
Plug 'majutsushi/tagbar'                         " Tagbar outliner.
Plug 'Yggdroot/indentLine'                       " Show indenting lines.
Plug 'rizzatti/dash.vim'                         " Dash (MacOS only) integration.
Plug 'scrooloose/syntastic'                      " Syntax checking for vim.
Plug 'kshenoy/vim-signature'                     " Toggle, display & navigate marks
Plug 'djoshea/vim-autoread'
" }}}
call plug#end()

" ----------------------------------------------------------------------------
" Vim-Plug Configuration.
" Commands execute in new tab.
let g:plug_window = "tab new"
" ----------------------------------------------------------------------------

" }}}
" AirLine {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tab_nr_type = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='base16'
let g:airline#extensions#tmuxline#enabled = 1
" the following removes arrows from vim-airline (for a change)
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''

set timeoutlen=200 " Avoid waiting time when leaving insert mode.
" }}}
" DelimitMate {{{
"  Automagically inserts matching closing parenthesis, brackets, etc.
"  Once the interior of the parenthesis (etc) is set, <C-g>g get you out
"  of the parenthesis to the right, to continue editing.
" }}}
" CTRLP {{{
" Ctrlp (plugin) configuration.
"  This plugin is no longer maintained. We should look for an alternative.
let g:ctrlp_map                 = '<c-p>'
let g:ctrlp_cmd                 = 'CtrlPLastMode'
let g:ctrlp_extensions          = ['buffertag', 'tag', 'line', 'dir']
let g:ctrlp_cmd               = 'CtrlP'
let g:ctrlp_show_hidden         = 1
let g:ctrlp_dotfiles            = 1
let g:ctrlp_use_caching         = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir           = $HOME.'/tmp/ctrlp'
set wildignore+=*/.cache/*,*/tmp/*,*/.git/*,*.log,*.so,*.swp,*.zip,*.gz,*.bz2,*.bmp,*.ppt
set wildignore+=*/__pycache__/*,*.swp
let g:ctrlp_open_new_file = 't'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_max_files = 100
let g:ctrlp_max_depth = 10
let g:ctrlp_working_path_mode = ''
let g:ctrlp_regexp = 1
" }}}
" Numbers {{{ 
" (plugin) configuration.
let g:numbers_exclude = ['nerdtree', 'tagbar', 'startify']
" }}}
" NERDCommenter {{{ 
"  Add extra space before and after comment symbols.
let NERDSpaceDelims = 1  
" }}}
" Edit_VIMRC {{{ 
augroup EditVimRC
    autocmd!
    autocmd BufWinEnter ~/.vimrc normal zM 
augroup END
" }}}
" Vim-LaTeX {{{ 
"  Open PDFs with MacOs Preview app.
let g:Tex_ViewRule_pdf = 'open -a Preview'
let g:tex_flavor='latex'
let g:Tex_TreatMacViewerAsUNIX = 1
let g:Tex_ExecuteUNIXViewerInForeground = 0
augroup LaTeX
    autocmd!
    " Compile TeX file to PDF.
    " autocmd FileType tex call Tex_SetTeXCompilerTarget('View','pdf')
    " When opening TeX file, unfold all folds. [Tip: zM to fold all.]
    autocmd BufWinEnter *.tex normal zR
    autocmd FileType tex nmap <leader>mk :VtrSendCommandToRunner make<CR>
    autocmd FileType tex nmap <leader>cl :VtrSendCommandToRunner make clean<CR>
augroup END
" Smart ctags on latex files.
let g:tagbar_type_tex = {
    \ 'ctagstype' : 'latex',
    \ 'kinds'     : [
        \ 's:sections',
        \ 'g:graphics:0:0',
        \ 'l:labels',
        \ 'r:refs:1:0',
        \ 'p:pagerefs:1:0'
    \ ],
    \ 'sort'    : 0,
\ }
" }}}
" {{{ LaTeX configurations
" To avoid the conceal feature while writing tex files
" which hides symbols from the writer!!! vim is no WYSIWYG!!!
let g:tex_conceal = ""
" }}}
" Vim-Jedi {{{
augroup Jedi
    autocmd!
    " Disable opening the docstring window popup during completion.
    " autocmd FileType python setlocal completeopt-=preview
    autocmd FileType python set completefunc=python3complete#Complete
augroup END
let g:pymode_python = 'python3'
let g:jedi#squelch_py_warning = 1 
let g:jedi#force_py_version = 3
let g:jedi#popup_on_dot = 1                      " Do not pop-up (too slow).
let g:jedi#documentation_command = "K"           " K for documentation.
let g:jedi#use_splits_not_buffers = "bottom"     " Use splits. 
let g:jedi#show_call_signatures = 2              " Show function help in command line.
let g:jedi#auto_close_doc = 1                    " Close preview window automaticaly
" }}}
" Tabular {{{
if exists(":Tabularize")
    nmap <leader>a= :Tabularize /=<CR>
    vmap <leader>a= :Tabularize /=<CR>
    nmap <leader>a" :Tabularize /"<CR>
    vmap <leader>a" :Tabularize /"<CR>
endif
" }}}
" Tagbar {{{ 
" Tagbar toggle with ',t'.
nmap <leader>tb :TagbarToggle<CR> 
" }}}
" NERDTree configuration {{{
"  Set modified width (default is 31).
let g:NERDTreeWinSize=40
" }}}
" NERDTreeTabs configurations {{{
" Map NERDTree across tabs toggle on/off.
map <leader>k :NERDTreeTabsToggle<CR><C-w><C-w> 
" Open NERDTree on console vim startup.
let g:nerdtree_tabs_open_on_console_startup=0
let g:nerdtree_tabs_open_on_gui_startup=0
let NERDTreeShowBookmarks=1
nnoremap <leader>; <C-w><C-w>
" }}}
" Vim-Buffergator {{{
let g:buffergator_viewport_split_policy="B"
let g:buffergator_hsplit_size=6
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
let g:vtr_highlight_runner = [ 'Python' ]
" Usage: 
"  <leader>l will send selected block to a tmux session
" If no selected block, <leader>l will execute the whole file. 
let g:vtr_filetype_runner_overrides = {
    \ 'python': '%run {file}' }
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 0

augroup Pythonic
    autocmd!
    " For IPython integration.
    autocmd FileType python nmap <leader>l :VtrSendFile<CR>
    autocmd FileType python xmap <leader>l :VtrSendLinesToRunner<CR> 
augroup END
augroup Matlabic
    autocmd!
    " For MATLAB integration.
    autocmd FileType matlab nmap <leader>l :VtrSendFile<CR> 
    autocmd FileType matlab xmap <leader>l :VtrSendLinesToRunner<CR>
augroup END
let g:slime_target = "tmux"
" let g:slime_python_ipython = 1
" My very own Vim-Tmux-Runner custom shortcuts
command! VA VtrAttachToPane
" }}}
" Seamlessly change executable bit on a file {{{
"  (i.e., change a file's executable
"  flag on; particularly useful when writing scripts that are to be executed
"  from the command line). 
"  This can be done by just ":!chmod a+x %" within vim, but that causes vim to
"  ask for the file to be reloaded (because it changed); if you do, all history
"  on the buffer changes is lost. This is an elegant solution to this problem.
" Usage: ":Xbit"
function! SetExecutableBit()
    let fname = expand("%:p")
    checktime
    execute "au FileChangedShell " . fname . " :echo"
     !chmod a+x %
    checktime
    execute "au! FileChangedShell " . fname
endfunction
command! Xbit call SetExecutableBit()
" }}}
" Source the vimrc file after saving it {{{
augroup ReloadingVimRC
    autocmd!
    if has("autocmd")
        autocmd bufwritepost ~/.vimrc nested source $MYVIMRC  
    endif
augroup END
" }}}
" Move whole lines up & down {{{
"  <C-k> & <C-j> move lines (or blocks) up and down.
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
" set listchars=tab:▸\ ,eol:¬
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
" Quickly change between light/dark variations of current colorscheme {{{
"  The "AirlineRefresh" at the end makes sure the color theme is not messed up
"  by the changes made to the rendering of the window in the terminal.
noremap <leader>sd :set background=dark<CR>:AirlineRefresh<CR>
noremap <leader>sl :set background=light<CR>:AirlineRefresh<CR>
" }}}
" Backup files, swap files and undo {{{
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" }}}
" Miscellanea {{{
" Auto-indent the whole document.
noremap <leader>ai gg=G``

let g:SimpylFold_docstring_preview = 1           " SimpylFold configuration.

set cmdheight=1                                  " explicitly set the height of the command line.
set showcmd                                      " Show (partial) command in status line.

set showtabline=2                                " Always show tabline.
set incsearch                                    " Pattern is matched as you type.
set hlsearch

set mouse=a    " Use mouse.

set scrolloff=3                    " scroll before reaching bottom edge
nnoremap <leader>vv :e $MYVIMRC<CR>  
" Quickly [Tab]Edit ~/.vimrc
nnoremap <leader>vg :e $MYGVIMRC<CR> 
" Quickly [Tab]Edit ~/.gvimrc
set formatoptions=tcroql  " Reformat/reflow a paragraph of text.
nnoremap Q gqap
set guioptions=       " Remove all scroll bars.
set clipboard=unnamed " Uses system's clipboard.
set laststatus=2      " Always show statusline.
set t_Co=256          " Use 256-color terminal.
set noshowmode        " Hide the default mode text (e.g. -- INSERT -- below the statusline).

set number
set wildmenu 
set wildmode=list:longest,full
set backspace=indent,eol,start

" Open file under cursor in new tab.
nnoremap <leader>fr <C-w>gf
" Insert empty line *below* without leaving normal mode.
noremap <leader><Space> o<Esc>k 

" }}}
" Colorscheme {{{
execute "set background=".$BACKGROUND
execute "colorscheme ".$THEME
highlight LineNr ctermbg=bg
" }}}
" Syntastic customize colors - goes after setting colorscheme {{{
highlight SignColumn ctermbg=bg
highlight SyntasticErrorSign ctermbg=bg ctermfg=yellow
highlight SyntasticStyleErrorSign ctermbg=bg ctermfg=yellow
highlight SyntasticWarningSign ctermbg=bg ctermfg=yellow
highlight SyntasticStyleWarningSign ctermbg=bg ctermfg=yellow
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" }}}
" {{{ Set terminal type for Tmux
if exists('$TMUX')
    set term=screen-256color
endif
" }}}
" {{{ Clear highlighting of found terms on escape in normal mode
"   The first line does the trick, the second one prevents vim from
"   doing weird things after remapping <esc> the first time.
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[
" }}}
nmap <leader>z : !tmux resize-pane -Z<CR> 

" Added to easily replace unicode characters after
" copy-pasting from pdfs or getting text from pdfs by using
" pdftotext (poppler utils)
" To be called by doing
" :call LatexAccents()
function! g:LatexAccents()
    " How to type these next lines is very important for functionality.
    " It should be typed like:
    " :%s/a<Ctrl-v>u0301/\\'a/g
    " with the exception of the line involving accented i, which is typed as:
    " :%s/<Ctrl-v>u0131<Ctrl-v>u0301/\\'\\i/g
    " u0301 = unicode character for spanish accent
    " u0131 = unicode character for dotless i char
    " Note: the 'e' at the end of every line makes the command silent, so
    " the phrase 'Pattern not found' is omitted (if it's the case)
    :%s/á/\\'a/ge
    :%s/é/\\'e/ge
    :%s/ı́/\\'\\i /ge
    :%s/\\'\\i /\\'\\i\\/ge
    :%s/ó/\\'o/ge
    :%s/ú/\\'u/ge
    :%s/Ω/$\\Omega$/ge
    :%s/◦/$^{\\circ}$/ge
endfunction

" Prettier indent symbol for indentLine
let g:indentLine_char = '┆'

" Use Tab & Shift-Tab to cycle through open buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" To prevent the display of error message
" E37: No write since last change (add ! to override)
" when switching buffers!
set hidden

" Open my own cheatsheet
nnoremap <leader>gh :e ~/.vim/my_cheat_sheet<CR>

" Do not show marks on startup,
" use :SignatureToggleSigns to toggle them
let g:SignatureEnabledAtStartup = 0

" Custom Shortcuts 
augroup LookAtLastLineWhenMonitoringHistoryFile 
    au! BufRead,BufEnter ipython3_history.py normal GG
augroup END
command! MonitorIPython3History view ~/.ipython/profile_default/ipython3_history.py 

" Vertical split color
" hi vertsplit ctermfg=green ctermbg=green

" Space as fill char (next line has an extra space at end)
set fillchars+=vert:\ 


