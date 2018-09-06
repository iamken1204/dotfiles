" Enable Vim specific features
if &compatible | set nocompatible | endif

" Install vim-plug if not present (nvim)
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'jiangmiao/auto-pairs'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'terryma/vim-multiple-cursors'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'posva/vim-vue'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'cocopon/colorswatch.vim', { 'for': 'css' }
Plug 'hashivim/vim-terraform'
Plug 'itchyny/lightline.vim'
Plug 'neovimhaskell/haskell-vim'

" color schemes
Plug 'NLKNguyen/papercolor-theme'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'rakr/vim-one'
Plug 'ajmwagar/vim-deus'
Plug 'liuchengxu/space-vim-dark'
Plug 'jnurmine/Zenburn'
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'fenetikm/falcon'
Plug 'BrainDeath0/Hypsteria'
" Plug 'trevordmiller/nova-vim'
" Plug 'yuttie/hydrangea-vim'
" Plug 'foooomio/vim-colors-japanesque'
" Plug 'drewtempelmeyer/palenight.vim'
call plug#end()

" general settings
language en_US                  " Set NeoVim's localization language
filetype off                    " Reset filetype detection first ...
filetype plugin indent on       " ... and enable filetype detection
set ttyfast                     " Indicate fast terminal conn for faster redraw
set laststatus=2                " Display status line in all windows, always
set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically read changed files
set noerrorbells                " No error beeps
set novisualbell                " No visual mode beeps
set number                      " Show line numbers
set showcmd                     " Show me what I'm typing
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
set noshowmode                  " Hide --- INSERT --- under statusline
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set autowrite                   " Automatically save before :next, :make etc.
set cursorline                  " Highlight current line
set lazyredraw                  " Redraw only when we need to
set hlsearch                    " Highlight match result
set incsearch                   " Shift cursor to match result
set scrolloff=3                 " lines to keep above & below cursor while moving
set ignorecase                  " Ignore case in search patterns
set smartcase                   " Override 'ignorecase' if the search pattern
                                " contains upper case characters
set mouse=a                     " Enable mouse interactive with vim
set backspace=2                 " Make backspace can delete words in insert mode
set history=10                  " Reduce storage of :command history(default is 20)
set updatetime=300              " Reduce the time to trigger CursorHold event,
                                " default is 4000(millisecond)
set clipboard+=unnamed          " Let vim pass its yanked contents to OS clipboard.
                                " https://stackoverflow.com/questions/41798130/copy-paste-in-iterm-vim
set path+=**                    " Search down into subfolders
                                " Provides tab-completion, use :find and * to do fuzzy finding
set inccommand=split            " Enables interactive search and replace
set wildmenu                    " Display all matching files when tab complete
set wildignore=*/.git/*,*/tmp/*,*/node_modules/*
set tabstop=4                   " A <Tab> represents 4 spaces
set shiftwidth=4                " Indent with 4 spaces
set completeopt-=preview        " Disable annoying popup window

let mapleader = "\<Space>"      " Remap <Leader> from <Bslash> to <Space>

" Map <Space>. to edit neovim rc
execute 'nnoremap <Leader>. :vs' resolve(expand('~/.config/nvim/init.vim')) '<CR>'

" If you leave terminal buffer and enter again, you have to start
" insert mode(press i) in order to interactive with terminal.
" This autocmd ensures we can enter insert mode automatically.
autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
autocmd BufEnter * if &buftype == 'terminal' | setlocal nonumber | endif

" map Ctrl+s as :update in insert, normal mode, place 'stty -ixon'
" into .zshrc to enable Ctrl+s within vim.
" http://vim.wikia.com/wiki/Map_Ctrl-S_to_save_current_or_new_files
inoremap <C-s> <Esc>j:w<CR>
nnoremap <C-s> :w<CR>
" If there's a long line gets visually wrapped to 2 lines by vim,
" make cursor movement by j, k won't skip the fake lines.
nnoremap j gj
nnoremap k gk
" <Esc> also cancels search highlighting
nnoremap <Esc> :nohlsearch<CR><Esc>

" Map ESC to close terminal window
tnoremap <Esc> <C-\><C-n><C-w><C-c>
" Map CTRL+h,j,k,l to switch active buffers in terminal and normal mode
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Map Shift + <- -> to move between tabs
tnoremap <S-Right> <C-\><C-N>gt
tnoremap <S-Left> <C-\><C-N>gT
nnoremap <S-Right> gt
nnoremap <S-Left> gT

" Disable EX-mode
nnoremap Q <Nop>
nnoremap gQ <Nop>
" Disable recording mode
nnoremap q <Nop>

" number toggle
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * if &buftype != 'terminal' | set relativenumber | endif
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" javascript
augroup js
	autocmd!
	autocmd BufNewFile,BufRead *.js setlocal expandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.vue setlocal expandtab tabstop=2 shiftwidth=2
augroup END

" Makefile
augroup makefile_k
	autocmd!
	" In Makefiles DO NOT use spaces instead of tabs
	autocmd filetype make setlocal noexpandtab
augroup END

" haskell
augroup haskell_k
	autocmd!
	autocmd filetype haskell setlocal expandtab
augroup END

" Move to the driectory each buffer
" autocmd BufEnter * silent! cd %:p:h

" deoplete
let g:deoplete#enable_at_startup = 1

" vim-go
" https://github.com/fatih/vim-go/blob/master/doc/vim-go.txt
let g:go_fmt_command           = "goimports"
let g:go_def_mode              = 'godef'
let g:go_highlight_types       = 1
let g:go_highlight_fields      = 1
let g:go_highlight_functions   = 1
let g:go_highlight_methods     = 1
let g:go_highlight_operators   = 1
let g:go_highlight_extra_types = 1
let g:go_auto_type_info        = 1
let g:go_highlight_variable_declarations = 1
let g:go_addtags_transform     = "snakecase" " :GoAddTags
augroup go
	autocmd!
	" represent a tab as 2 spaces
	autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 shiftwidth=2
	" map :GoBuild as Ctrl+b
	autocmd filetype go nmap <C-b> <Plug>(go-build)
	" map :GoDef(vertical) as Ctrl+d
	autocmd filetype go nmap <C-d> <Plug>(go-def-vertical)
augroup END

" colorscheme
set termguicolors
set background=dark
colorscheme falcon
" color comments as grey
" hi Comment guifg=#5C6370 ctermfg=59
" make LineNr blend into background color at terminal
" hi LineNr ctermbg=NONE guibg=NONE

" NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden=1
let NERDTreeIgnore=[
	\ '\.git$',
	\ '^\.DS_Store$',
	\ '^node_modules$',
	\ '^vendor$'
	\]
map <Leader><Space> :NERDTreeToggle<CR>
augroup nerd_loader
	autocmd!
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter *
		\	if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
		\ | 	exe 'NERDTree' argv()[0]
		\ | 	wincmd p
		\ | 	ene
		\ | endif
	" Close vim automatically when there is only NERDTree buffer left.
	autocmd bufenter *
		\   if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree())
		\ | 	q
		\ | endif
augroup END

" NERDCommenter
let g:NERDSpaceDelims = 1   " append 1 space after comment syntax
nmap <C-_> <leader>c<space> " map Ctrl+/ as NERDComToggleComment in normal mode
vmap <C-_> <leader>c<space> " map Ctrl+/ as NERDComToggleComment in visual mode

" ack.vim
" :Ack will jump to first matched file automatically,
" use :Ack! to stay at current editing file.
execute 'map <C-f> :Ack! '
" replace ack with ag(the_silver_searcher)
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif

" fzf
map <C-p> :FZF<CR>

" lightline
let g:lightline = {
  \ 'colorscheme': 'falcon',
  \ 'active': {
  \   'left': [ [ 'mode' ], [ 'filepath', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'filetype' ], [ 'hamb' ] ]
  \ },
  \ 'component': { 'hamb': '☰' },
  \ 'component_function': {
  \   'filepath': 'LightLineFilepath',
  \ },
  \ }
function! LightLineFilepath()
	" Absolute path: expand('%:p')
	" Relative path: expand('%')
	return (expand('%') == '' ? '[No Name]' : expand('%'))
endfunction

" vim-terraform
let g:terraform_align       = 1
let g:terraform_fmt_on_save = 1

" haskell-vim
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:haskell_indent_case = 2
