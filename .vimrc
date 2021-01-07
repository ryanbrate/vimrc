set encoding=utf-8

"set (buffer) working path to current file location
set autochdir

" case options
set ignorecase
set smartcase

"change the leader key
let mapleader = ","

"------
"macros assigned to registers
"------

" let @s="1:w >> removed_line.txt\<CR>d1d"
let @f="a=expand('%:r')" 
let @t='a=strftime("%c")'   " using the expression (=) register to evaluate 

"------
" custom commands
"------

" eval() any line of text, echoing the result
command EE echo eval(getline('.'))

" highlight those words that tend to get miss-typed
let s:mistakes = ["its", "it's", 
            \"there", "their", "they're",
            \"your", "you're",
            \"were", "we're", "where", 
            \"who's", "whose",
            \]
command Mistakes exec '/\(' . join(s:mistakes, '\|') . '\)' 

" highlight (likely unintended) repeated consecutive words
command RepeatedWords /\(\<\w\+\>\)\_s*\<\1\>

" ------
" miscellaneous settings
" ------

" always shows tab bar
set showtabline=2

" Tab creation/deletion/navigation
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

"Gvim font
if has('gui_running')
    set guifont=Ubuntu\ Mono\ 11
endif

" turn off beep
set vb t_vb=

"persistent undo settings
set undofile
set undodir=~/.vim/undodir "set bespoke persistent undo directory
if !isdirectory(&undodir)
    call mkdir(&undodir) 
endif 

" all the cool kids do this, apparently
set lazyredraw

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

"statusbar
set laststatus=2        " Shows status bar on 2nd to last line
set statusline=%f\ %y\ [%{&fileencoding?&fileencoding:&encoding}]\ [%{&fileformat}]  "lhs 
set statusline+=%=
set statusline+=%p%%\ %l:%c  "rhs

set path=.,
" set path+=** "for recursive file searching using :find 
set wildmenu "tab completion of file search
set wildmode=list,full
set wildignore+=*.swp,*.bak
set wildignore+=*.pyc
set wildignore+=*.blg,*.fls,*.bbl,*.aux,*fdb_latexmk,*.pygtex,*.pygstyle
set wildignore+=*/.git/**/*
set wildignore+=tags
set wildignorecase

set foldmethod=indent
set foldlevelstart=1000
filetype plugin indent on
set smarttab "tab in insert mode, inserts shiftwidth of spaces
set backspace=indent,eol,start

"auto update file view if changed outside of vim
set autoread

"set up completion 
set omnifunc=syntaxcomplete#Complete
set completefunc=syntaxcomplete#Complete
set completeopt=menuone,preview,noselect,noinsert
set dictionary+=/usr/share/dict/british-english "setup dictionary completion
inoremap <C-Space> <C-x><C-o>

" for spell checking i.e. set spell
set spelllang=en_gb

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
Plug 'tpope/vim-unimpaired'
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-fugitive'
Plug 'lervag/vimtex'
Plug 'simnalamburt/vim-mundo'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } } 
Plug 'junegunn/fzf.vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'natebosch/vim-lsc'
Plug 'ryanbrate/functional.vim'
Plug 'ryanbrate/vimwiki_block_runner.vim', {'branch':'master'}
call plug#end()

"------
" vimwiki_block_runner.vim
"------
let g:vwbr_commands = {
            \'python':'python3 %s',
            \'R':'Rscript %s',
            \'r':'Rscript %s',
            \}

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
    \'r':['R', '--slave', '-e', 'languageserver::run()'],
    \}
" Note: for list of language servers, see....
" https://github.com/neovim/nvim-lspconfig#jedi_language_server

" Use all the defaults (recommended):
let g:lsc_auto_map = v:true

" Apply the defaults with a few overrides:
let g:lsc_auto_map = {'defaults': v:true, 'FindReferences': '<leader>r'}

" Setting a value to a blank string leaves that command unmapped:
let g:lsc_auto_map = {'defaults': v:true, 'FindImplementations': ''}

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
    \ 'Completion': 'omnifunc',
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
" ale
"------
let g:ale_linters_explicit = 1
let g:ale_linters={'python': ['flake8', 'pydocstyle'], 'tex': ['chktex'], 'json':[], 'r':['lintr']}
let g:ale_fixers={'python': ['black', 'isort', 'remove_trailing_lines', 'trim_whitespace'], 'json':['jq'], 'r':['remove_trailing_lines', 'trim_whitespace']}
nnoremap <Leader>af :ALEFix<CR>

" disable ale from interferring with vimwiki search
" let g:ale_pattern_options = {'.*\.wiki': {'ale_enabled': 0}}

"------
" vim-mundo, persistent undo viewer
"------
nnoremap <F5> :MundoToggle<CR>

"------
" ultisnips
"------
" let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
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

"------
" vimwiki
"------
"
" setup template for vimwiki - taken from https://www.rosipov.com/blog/custom-templates-in-vimwiki/ 
"(allowed for added mathjax to default headers in order to support equations)

let wiki_1 = {
  \ 'path': '$HOME/vimwiki',
  \ 'auto_tags': 1,
  \ 'auto_diary_index': 1,
  \ 'auto_generate_tags': 1,
  \ 'auto_export': 1,
  \ 'template_path': '$HOME/vimwiki/templates',
  \ 'template_default': 'default',
  \ 'template_ext': '.html'}

let wiki_2 = {
  \ 'path': '$HOME/Diary',
  \ 'auto_tags': 1,
  \ 'auto_diary_index': 1,
  \ 'auto_generate_tags': 1,
  \ 'auto_export': 1,
  \ 'template_path': '$HOME/Diary/templates',
  \ 'template_default': 'default',
  \ 'template_ext': '.html'}

let wiki_3 = {
  \ 'path': '$HOME/Github_Pages',
  \ 'auto_tags': 1,
  \ 'auto_diary_index': 1,
  \ 'auto_generate_tags': 1,
  \ 'auto_export': 1,
  \ 'template_path': '$HOME/Github_Pages/templates',
  \ 'template_default': 'default',
  \ 'template_ext': '.html'}

let g:vimwiki_list = [wiki_1, wiki_2, wiki_3]

" let g:vimwiki_global_ext = 0  " turns off temporary wiki behaviour
let g:vimwiki_auto_header = 1  " auto fill .wiki title
" let g:vimwiki_folding = 'list'  "turn off - it's too slow

" ------
"  colorscheme
" ------
" set basic colorscheme
set termguicolors
set background=dark
colorscheme gruvbox

"---
" General operator-pending mappings
"---

" items between commas (i.e., lists)
onoremap i, :<c-u>normal! T,wvt,<cr>
onoremap a, :<c-u>normal! T,wvf,wh<cr> 

"---
" new buffer (doc) settings
"---

augroup FileType *
    au!
    au FileType * match none "clear previous highlighted matches in new buffer

    " added operator-pending mapping for items in between commas
augroup End

augroup FileType vim
    au!
    au FileType vim setlocal colorcolumn=80
augroup End

augroup Filetype r
    au!
    au Filetype r setlocal colorcolumn=80
    au Filetype r command Styler exec 
                \"!R --slave -e 'library(styler); style_file(\"%:p\")'"
augroup END

augroup FileType python 
    au!
    au FileType python setlocal colorcolumn=80
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

    "wrap token (or visual select) with \textbf{}
    au Filetype tex nnoremap <buffer> <Leader>tb :normal ciw\textbf{<esc>pa}<esc>
    au Filetype tex vnoremap <buffer> <Leader>tb :normal gvc\textbf{<esc>pa}<esc>

    "wrap token (or visual select) with \textit{}
    au Filetype tex nnoremap <buffer> <Leader>ti :normal ciw\textit{<esc>pa}<esc>
    au Filetype tex vnoremap <buffer> <Leader>ti :normal gvc\textit{<esc>pa}<esc>

    "wrap token (or visual select) with \underline{}
    au Filetype tex nnoremap <buffer> <Leader>tu :normal ciw\underline{<esc>pa}<esc>
    au Filetype tex vnoremap <buffer> <Leader>tu :normal gvc\underline{<esc>pa}<esc>

augroup END

" settings when email app calls vim as an external editor
augroup FileType email
    au!
    au Filetype email iabbrev <buffer> sig Kind regards,<cr><cr>Ryan
    au FileType email setlocal spell
    au FileType email match ErrorMsg /\(\<\w\+\>\)\_s*\<\1\>/

augroup END

augroup FileType vimwiki
    au!

    au FileType vimwiki iabbrev <buffer> uva UvA 
    au FileType vimwiki iabbrev <buffer> eg e.g.,
    au FileType vimwiki iabbrev <buffer> Eg E.g.,
    au FileType vimwiki iabbrev <buffer> ie i.e.,
    au Filetype vimwiki iabbrev <buffer> Ie I.e.,
    au Filetype vimwiki iabbrev <buffer> etc etc.

    au FileType vimwiki cabbrev VWST VimwikiSearchTags

    au FileType vimwiki setlocal spell
    au FileType vimwiki set complete+=k

    " make text or visual selection bold
    au Filetype vimwiki nnoremap <buffer> <Leader>tb :normal ciw**<esc>P
    au Filetype vimwiki vnoremap <buffer> <Leader>tb :normal gvc**<esc>P

    " make text or visual selection italic
    au Filetype vimwiki nnoremap <buffer> <Leader>ti :normal ciw__<esc>P
    au Filetype vimwiki vnoremap <buffer> <Leader>ti :normal gvc__<esc>P

    " added operator-pending mapping for headings
    au Filetype vimwiki onoremap i= :<c-u>normal! T=vt=<cr> 

    " ----
    " Add a command to populate a location list by 0,1 or more vimwiki tags,
    " matching incomplete ToDo lists preceeded by the tags (or any page if tag
    " not specified)
    " ----
    " Example:
    "
    "   :TD
    "   :TD tag1 tag2
    
    function g:Todopen(...) abort
        " Args:
        "   a000: (list): \s\+ separated tags

        let l:tags = split(a:1, '\s\+')

        if len(tags) == 0
            exec 'VWS /\[\s\+\]/'
        else  " search for 1 or more tags simultaneously
            exec 'VWS /:\(' . join(tags, '\|') . '\):\_.\+\[\s\+\]/'
        endif
    endfunction

    au FileType vimwiki 
                \command! -buffer -nargs=? -complete=custom,vimwiki#tags#complete_tags -bang 
                \TD execute Todopen(<q-args>) 

    " vimwiki_block_runner
    au Filetype vimwiki nnoremap <buffer> <Leader>wb :call Execute_Block()<CR><CR>
augroup END
