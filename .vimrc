let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsSnippetsDir="/home/stock/data/linux/scripts/ultisnips"
let g:UltiSnipsSnippetDirectories=["/home/stock/data/linux/scripts/ultisnips", "/home/stock/.vim/plugged/vim-snippets/UltiSnips"]

let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
let g:ycm_add_preview_to_completeopt = 1

let g:EasyMotion_smartcase = 1

let g:solarized_termtrans=1

let g:AutoPairsMultilineClose=0 "when you enclose object braces cursor will not jump to new line if there is exact same brace underneath it
let g:auto_save = 1
" good plugins surround, commentary, ReplaceWithRegister, Titlecase, ctrlp,
" vim-sparkup, ag - search trough projects, devicons
" Sort-motion System-copy
" press K when on function to show man page for it
set clipboard=unnamedplus  " use the clipboards of vim and win
"set paste               " Paste from a windows or from vim, NOTE: if this is set UltiSnipsExpandTrigger will not work
set mouse=a
set tabstop=4
set autoindent
set cindent "autoindent braces
set shiftwidth=4 "tab=4 spaces
set number relativenumber
set signcolumn=yes "always show column where errors are showed
filetype indent plugin on
set colorcolumn=94
set cursorline "highlight line that cursor is currently in
set splitright
set path=.,,**
set smartcase

" manpage viewer: See :help Man
runtime ftplugin/man.vim
map K <Leader>K
let g:ft_man_open_mode = 'vert'

"runtime! ftplugin/man.vim
"nnoremap K <Leader>K
"inoremap <C-Enter> <ESC>o
call plug#begin('~/.vim/plugged')

Plug 'dylanaraps/wal.vim'
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
Plug 'baskerville/vim-sxhkdrc'
Plug 'lifepillar/vim-solarized8'
Plug 'ycm-core/YouCompleteMe'
"Plug 'jeaye/color_coded'
"Plug 'arakashic/chromatica.nvim'
Plug 'justinmk/vim-syntax-extra'
"Plug 'flazz/vim-colorschemes'
"Plug 'awesome-vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'jiangmiao/auto-pairs'
Plug '907th/vim-auto-save'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'itchyny/calendar.vim'
Plug 'easymotion/vim-easymotion'
call plug#end()

"let g:chromatica#libclang_path="/usr/lib/libLLVM-8.0.1.so"
"let g:solarized_termcolors=256
set background=dark
colorscheme solarized
highlight clear SignColumn " column where errors appear is the same color as background of linenumbers
"
" more readable highlight
highlight! link Visual StatusLine
"
" having vertical line that connects start and end of indentation block
set listchars=tab:\|\ 
set list
highlight! link SpecialKey Comment
"spell checker
map<F6> :setlocal spell! spelllang=en_us<CR>

nmap <C-j> <Plug>(easymotion-w)
nmap <C-k> <Plug>(easymotion-b)

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" settings for todo list
au BufEnter *.todo imap <C-d> <C-R>=strftime("%d.%m.%y")<CR>
au BufEnter *.todo imap <C-e> <C-R>=strftime("%d.%m.%y-%H:%M")<CR>
au BufEnter *.todo nmap <C-t> o[ ] <C-e> -> <C-e>: 
au BufEnter *.todo nmap <C-i> o[ ] <C-d> -> <C-d>: 
au BufEnter *.todo nmap <C-b> o[ ] 
au BufEnter *.todo nmap <C-f> 0lrX
au BufEnter *.todo nmap <C-a> 0i<C-e> - <ESC>"":.w! >> ~/data/Documents/Documents/completed.todo<CR>dd
