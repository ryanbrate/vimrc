"saved macro example
" let @s="1:w >> removed_line.txt\<CR>d1d"

"cnext, cprevious shortcuts. e.g., for Glog, inspired by unimpaired
nnoremap ]q :cnext<CR>
nnoremap ]Q :clast<CR>
nnoremap [q :cprevious<CR>
nnoremap [Q :cfirst<CR>

"paste current file name
let @f=":put! =expand('%:r')"

" turn off beep
set vb t_vb=

"persistent undo settings
set undofile
set undodir=~/.vim/undodir "set bespoke persistent undo directory

"auto update file view if changed outside of vim
set autoread

" always shows tab bar
set showtabline=2

" all the cool kids do this, apparently
set lazyredraw

set encoding=utf-8

"set minimum number of lines above/below cursor on screen
set scrolloff=1 

" enable syntax highlighting
syntax enable
let python_highlight_all=1

" show line numbers
set nu relativenumber

" set tabs to 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" backspace whole expanded tabs
set softtabstop=4

" when using the > or < commands (in visual mode), shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
set cursorline

" highlight the matching part of the pair for [] {} and ()
set showmatch

"search options
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase
set smartcase

"statusbar
set laststatus=2                       " Shows status bar on 2nd to last line
set statusline=%f                      " Show path in status bar (relative, %F for absolute)

"extra settings from ....vim video
set path=.,,
" set path+=** "for recursive file searching using :find 
set wildmenu "tab completion of file search
set wildmode=longest:full,full
set wildignore+=tags,*.pyc "invisible to wildmenu and netrw
set wildignore+=*.blg,*.fls,*.bbl,*.aux,*fdb_latexmk,*.pygtex,*.pygstyle "latex file ignore

set nocompatible "turn off enforced vi compatibility
set foldmethod=indent
set foldlevelstart=1000
filetype plugin indent on
set smarttab "tab in insert mode, inserts shiftwidth of spaces
set backspace=indent,eol,start

"set working path to current file location
set autochdir

"change the leader key
let mapleader = ","

"set up completion 
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set completeopt=menuone,preview,noselect,noinsert
set dictionary+=/usr/share/dict/british-english "setup dictionary completion
inoremap <C-Space> <C-x><C-u>

"open preview below
set splitbelow

"toggle folds
nnoremap <Space> za 

"toggle nohls
nnoremap ,<space> :nohlsearch<CR>

"recognise .tex files
let g:tex_flavor='latex'

"ignore spell check on latex comments
let g:tex_comment_nospell=1

"open a html link (in browser) with gx
let g:netrw_browsex_viewer="setsid xdg-open"

"----------------------
" vim-plug plugin manager from https://github.com/junegunn/vim-plug
"----------------------
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'vimwiki/vimwiki'
" Plug 'majutsushi/tagbar'
Plug 'SirVer/ultisnips' 
Plug 'honza/vim-snippets'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'lervag/vimtex'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'simnalamburt/vim-mundo'
Plug 'dense-analysis/ale'
" Plug 'tmhedberg/SimpylFold'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } } 
Plug 'junegunn/fzf.vim'
" Plug 'davidhalter/jedi-vim'
Plug 'rafi/awesome-vim-colorschemes'
" Plug 'ycm-core/YouCompleteMe'
Plug 'natebosch/vim-lsc'
Plug 'vim-airline/vim-airline'
call plug#end()

"------
" fugitive
"------
nnoremap <Leader>gl :Git log --oneline --graph --all --decorate<CR>

"------
" vim-lsc
"------
let g:lsc_hover_popup = v:false
let g:lsc_enable_diagnostics = v:false          " let ale do the linting
let g:lsc_server_commands = {
            \'python': 'jedi-language-server',
            \}
" Note: for list of language servers, see....
" https://github.com/neovim/nvim-lspconfig#jedi_language_server

" Use all the defaults (recommended):
let g:lsc_auto_map = v:true

" Apply the defaults with a few overrides:
let g:lsc_auto_map = {'defaults': v:true, 'FindReferences': '<leader>r'}

" Setting a value to a blank string leaves that command unmapped:
let g:lsc_auto_map = {'defaults': v:true, 'FindImplementations': ''}

" ... or set only the commands you want mapped without defaults.
" Complete default mappings are:
let g:lsc_auto_map = {
    \ 'GoToDefinition': '<C-]>',
    \ 'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
    \ 'FindReferences': 'gr',
    \ 'NextReference': '<C-n>',
    \ 'PreviousReference': '<C-p>',
    \ 'FindImplementations': 'gI',
    \ 'FindCodeActions': 'ga',
    \ 'Rename': 'gR',
    \ 'ShowHover': v:true,
    \ 'DocumentSymbol': 'go',
    \ 'WorkspaceSymbol': 'gS',
    \ 'SignatureHelp': 'gm',
    \ 'Completion': 'completefunc',
    \}

"------
" fzf
"------
nnoremap <Leader>fF :FZF ~<CR>
nnoremap <Leader>ff :cd .<CR>:FZF<CR>
nnoremap <Leader>fg :FzfGFiles<CR>
nnoremap <Leader>fb :FzfBuffers<CR>
nnoremap <Leader>fT :FzfTags<CR>
nnoremap <Leader>ft :FzfBTags<CR>
nnoremap <Leader>fl :FzfLines<CR>
nnoremap <Leader>fs :FzfSnippets<CR>

let g:fzf_command_prefix = 'Fzf'

"------
" SimplyFold
"------
" let g:SimpylFold_docstring_preview = 1
" let g:SimpylFold_fold_docstring = 0

"------
" ale
"------
let g:ale_linters_explicit = 1
let g:ale_linters={'python': ['flake8', 'pydocstyle'], 'tex': ['chktex'], 'json':[], 'r':['lintr']}
let g:ale_fixers={'python': ['black', 'isort', 'remove_trailing_lines', 'trim_whitespace'], 'json':['jq'], 'r':['remove_trailing_lines', 'trim_whitespace']}
nnoremap <Leader>af :ALEFix<CR>

" disable ale from interferring with vimwiki search
" let g:ale_pattern_options = {'.*\.wiki': {'ale_enabled': 0}}

""------
"" ycm
""------
" let g:ycm_filetype_whitelist  = {'python' : 1, 'tex' : 1, 'vim' : 1, 'golang' : 1}
" let g:ycm_semantic_triggers = {'python' : ['.'], 'tex' : ['{'], 'golang' : ['.']}
" let g:ycm_auto_hover=''

" nnoremap <buffer> <S-k> :YcmCompleter GetDoc<cr> 
" nnoremap <buffer> <S-t> :YcmCompleter GetType<cr> 
" nnoremap <buffer> <c-]> :YcmCompleter GoTo<cr> 

" ------
" gutentags 
" ------
" set statusline+=%{gutentags#statusline()} "notify when updating
" let g:gutentags_project_root = ["tags"] "starts working if tags file present

"------
" vim-mundo, persistent undo viewer
"------
nnoremap <F5> :MundoToggle<CR>

"------
" netrw + vinegre; don't show hidden files on open
"------
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" ------
"  tagbar binding (recommended)
" ------
" nmap <F8> :TagbarToggle<CR>

"------
" ultisnips
"------
" let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:ultisnips_python_style = "google"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"------
" vimtex
"------
map <Leader>ll :VimtexCompile <cr><cr>
map <Leader>le :VimtexTocToggle<cr><cr>
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \ '-pdf',
    \ '-shell-escape',
    \ '-verbose',
    \ '-file-line-error',
    \ '-synctex=1',
    \ '-interaction=nonstopmode',
    \ ]
    \}

" setup template for vimwiki - taken from https://www.rosipov.com/blog/custom-templates-in-vimwiki/ 
"(allowed for added mathjax to default headers in order to support equations)
let g:vimwiki_list = [{
  \ 'path': '$HOME/vimwiki',
  \ 'template_path': '$HOME/vimwiki/templates',
  \ 'template_default': 'default',
  \ 'template_ext': '.html'}]

" for spell checking i.e. set spell
set spelllang=en_gb
" set spelllang=~/.vim/british-english.utf-8.spl  " mksp ~/.vim/british-english /usr/share/dict/british-english

" set basic colorscheme
set termguicolors
set background=dark
colorscheme gruvbox

" highlight (likely unintended) repeated phrases (e.g., the the), with the :Rep command
command Rep /\(\<.\+\>\)\_s*\<\1\>

" highlight where inadequate spaces between lists
command ListFormat /\w\(,\|\.\|\:\|\;\)\+\w

"---
" Tab creation/deletion/navigation
"---
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>tc :tabclose<CR>

nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>6 6gt
nnoremap <Leader>7 7gt
nnoremap <Leader>8 8gt
nnoremap <Leader>9 9gt 

"---
" new buffer (doc) settings
"---

augroup FileType *
    au!
    au FileType * match none "clear previous highlighted matches in new buffer
augroup End

augroup Filetype r
    au!
    au Filetype r setlocal colorcolumn=80
augroup END

augroup FileType python 
    au!
    " au FileType python match ErrorMsg /\%>80v.\+/ 
    au FileType python setlocal colorcolumn=80
    au FileType python setlocal completefunc = "lsc#complete#complete"
augroup END

augroup FileType tex
    au!
    au FileType tex iabbrev <buffer> eg e.g.,
    au FileType tex iabbrev <buffer> Eg E.g.,
    au FileType tex iabbrev <buffer> ie i.e.,
    au FileType tex iabbrev <buffer> Ie I.e.,
    au FileType tex iabbrev <buffer> etc etc.
    au Filetype tex iabbrev <buffer> etal et al.,
    au Filetype tex iabbrev <buffer> teh the
    au Filetype tex iabbrev <buffer> api API
    
    au FileType tex :setlocal spell

    " (saved as execute example - but can be done as map directly)
    " function! Ntext_bold()
    "     :execute "normal ciw\\textbf{\<esc>pa}"
    " endfunction

    "wrap token (or visual select) with \textbf{}
    " gv denotes visual selection
    au Filetype tex nnoremap <buffer> ,tb :normal ciw\textbf{<esc>pa}<esc>
    au Filetype tex vnoremap <buffer> ,tb :normal gvc\textbf{<esc>pa}<esc>

    "wrap token (or visual select) with \textit{}
    au Filetype tex nnoremap <buffer> ,ti :normal ciw\textit{<esc>pa}<esc>
    au Filetype tex vnoremap <buffer> ,ti :normal gvc\textit{<esc>pa}<esc>

    "wrap token (or visual select) with \underline{}
    au Filetype tex nnoremap <buffer> ,tu :normal ciw\underline{<esc>pa}<esc>
    au Filetype tex vnoremap <buffer> ,tu :normal gvc\underline{<esc>pa}<esc>

    "find word repetitions
    " au FileType tex match ErrorMsg /\(\<\w\+\>\)\_s*\<\1\>/

    " find sequence repetitions
    " au FileType tex match ErrorMsg /\(\<.\+\>\)\_s*\<\1\>/

augroup END

augroup FileType email
    au!
    " au Filetype email iabbrev <buffer> sig Kind regards,<cr><cr>Ryan

    au FileType email :setlocal spell
    
    " find word repetitions
    " au FileType email match ErrorMsg /\(\<\w\+\>\)\_s*\<\1\>/
    
    " find sequence repetitions
    au FileType email match ErrorMsg /\(\<.\+\>\)\_s*\<\1\>/

augroup END

augroup FileType vimwiki
    au!

    au FileType vimwiki iabbrev <buffer> uva UvA 
    au FileType vimwiki iabbrev <buffer> eg e.g.,
    au FileType vimwiki iabbrev <buffer> Eg E.g.,
    au FileType vimwiki iabbrev <buffer> ie i.e.,
    au Filetype vimwiki iabbrev <buffer> Ie I.e.,
    au Filetype vimwiki iabbrev <buffer> etc etc.

    au FileType vimwiki :setlocal spell
    " setlocal nospell 

    "functions mapped
    au Filetype vimwiki nnoremap <buffer> <Leader>ls :VWS 
    au Filetype vimwiki nnoremap <buffer> <Leader>lo :lopen<CR> 
    au Filetype vimwiki nnoremap <buffer> <Leader>ln :lnext<CR> 
    au Filetype vimwiki nnoremap <buffer> <Leader>lp :lprevious<CR> 

    "make text or visual selection bold
    au Filetype vimwiki nnoremap <buffer> ,tb :normal ciw**<esc>P
    au Filetype vimwiki vnoremap <buffer> ,tb :normal gvc**<esc>P

    "make text or visual selection italic
    au Filetype vimwiki nnoremap <buffer> ,ti :normal ciw__<esc>P
    au Filetype vimwiki vnoremap <buffer> ,ti :normal gvc__<esc>P


    " find word repetitions
    " au FileType vimwiki match ErrorMsg /\(\<\w\+\>\)\_s*\<\1\>/

    " find sequence repetitions
    " au FileType vimwiki match ErrorMsg /\(\<.\+\>\)\_s*\<\1\>/
augroup END
