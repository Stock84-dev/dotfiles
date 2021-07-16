let g:calendar_first_day= "monday"
let g:calendar_date_endian = "little"
let g:calendar_date_separator = "."

let g:NERDTreeHijackNetrw = 0 " add this line if you use NERDTree
let g:ranger_replace_netrw = 1 " open ranger when vim open a directory


autocmd FileType toml setlocal commentstring=#\ %s
" hide line numbers when ranger opens in vim
autocmd TermOpen term://*:ranger* setlocal nonumber signcolumn=no

"
"
"let g:UltiSnipsExpandTrigger="<C-l>"
"let g:UltiSnipsJumpForwardTrigger="<C-j>"
"let g:UltiSnipsJumpBackwardTrigger="<C-k>"
"let g:UltiSnipsEditSplit="horizontal"
"let g:UltiSnipsSnippetsDir="/home/stock/data/linux/scripts/ultisnips"
"let g:UltiSnipsSnippetDirectories=["/home/stock/data/linux/scripts/ultisnips", "/home/stock/.vim/plugged/vim-snippets/UltiSnips"]
"
"let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
"let g:ycm_add_preview_to_completeopt = 1
"
"let g:EasyMotion_smartcase = 1
let g:crunch_result_type_append = 0
"
"
"let g:vimwiki_list = [{'path': '~/data/wiki/docs/', 'path_html': '~/data/wiki/html/', 'auto_tags': 1}]
"
"if !exists('g:started_by_firenvim')
"endif
"
"let g:AutoPairsMultilineClose=0 "when you enclose object braces cursor will not jump to new line if there is exact same brace underneath it
"" good plugins surround, commentary, ReplaceWithRegister, Titlecase, ctrlp,
"" vim-sparkup, ag - search trough projects, devicons
"" Sort-motion System-copy
"" press K when on function to show man page for it
"set clipboard=unnamedplus  " use the clipboards of vim and win
""set paste               " Paste from a windows or from vim, NOTE: if this is set UltiSnipsExpandTrigger will not work
"set mouse=a
"set tabstop=4
"set autoindent
"set cindent "autoindent braces
"set shiftwidth=4 "tab=4 spaces
"set signcolumn=yes "always show column where errors are showed
"filetype indent plugin on
"set splitright
"set path=.,,**
"" used for vimwiki
"set nocompatible
"
"" manpage viewer: See :help Man
"runtime ftplugin/man.vim
"map K <Leader>K
"let g:ft_man_open_mode = 'vert'
"
""runtime! ftplugin/man.vim
""nnoremap K <Leader>K
""inoremap <C-Enter> <ESC>o
call plug#begin('~/.vim/plugged')
Plug 'nicwest/vim-camelsnek'
Plug 'wakatime/vim-wakatime'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'cespare/vim-toml'
Plug 'petRUShka/vim-opencl'
" Plug 'thaerkh/vim-workspace'
"Plug 'dylanaraps/wal.vim'
""Plug 'SirVer/ultisnips'
"" Snippets are separated from the engine. Add this if you want them:
"Plug 'honza/vim-snippets'
"Plug 'baskerville/vim-sxhkdrc'
"Plug 'lifepillar/vim-solarized8'
""Plug 'ycm-core/YouCompleteMe'
"" Plug 'neoclide/coc.nvim', {'branch': 'release'}
""
""Plug 'jeaye/color_coded'
""Plug 'arakashic/chromatica.nvim'
"Plug 'justinmk/vim-syntax-extra'
""Plug 'flazz/vim-colorschemes'
""Plug 'awesome-vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'https://github.com/chrisbra/Colorizer'
"Plug 'jiangmiao/auto-pairs'
"Plug '907th/vim-auto-save'
"
"Plug 'tpope/vim-surround'
"Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
"Plug 'justinmk/vim-sneak'
Plug 'itchyny/calendar.vim'
"Plug 'hjson/vim-hjson'
"Plug 'vmchale/ion-vim'
"Plug 'vimwiki/vimwiki'
"Plug 'arecarn/vim-selection'
Plug 'arecarn/vim-crunch'
"Plug 'chiedojohn/vim-case-convert'
"
"
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'

"Plug 'AndrewRadev/sideways.vim'
"Plug 'AndrewRadev/splitjoin.vim'
"Plug 'AndrewRadev/switch.vim'
"" Use nvim in web browser.
"if exists('g:started_by_firenvim')
"	Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(1337) } }
"endif
Plug 'easymotion/vim-easymotion'
""Plug 'racer-rust/vim-racer'
""Plug 'yuratomo/w3m.vim'
call plug#end()
"
""let g:chromatica#libclang_path="/usr/lib/libLLVM-8.0.1.so"
"let g:solarized_termcolors=256
set background=dark
"highlight clear SignColumn " column where errors appear is the same color as background of linenumbers
""
"" more readable highlight
""
"" having vertical line that connects start and end of indentation block
"set listchars=tab:\|\ 
"set list
"highlight! link SpecialKey Comment
"
""spell checker
"map<F6> :setlocal spell! spelllang=en_us<CR>
"nmap <S-y> y$
"
nmap <C-j> <Plug>(easymotion-w)
nmap <C-k> <Plug>(easymotion-b)
"
"let &t_SI = "\<Esc>[6 q"
"let &t_SR = "\<Esc>[4 q"
"let &t_EI = "\<Esc>[2 q"
"
"" settings for todo list
"au BufEnter *.todo imap <C-d> <C-R>=strftime("%d.%m.%y")<CR>
"au BufEnter *.todo imap <C-e> <C-R>=strftime("%d.%m.%y-%H:%M")<CR>
"au BufEnter *.todo nmap <C-t> o[ ] <C-e> -> <C-e>: 
"au BufEnter *.todo nmap <C-i> o[ ] <C-d> -> <C-d>: 
"au BufEnter *.todo nmap <C-b> o[ ] 
"au BufEnter *.todo nmap <C-f> 0lrX2la<C-R>=strftime("%d.%m.%y")<CR><Space><ESC>
"au BufEnter *.todo nmap <C-a> 0i<C-e> - <ESC>"":.w! >> ~/data/Documents/Documents/completed.todo<CR>dd
"au BufEnter *.html :AutoSaveToggle
"au BufEnter *.css :AutoSaveToggle
autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
":au FocusLost * silent! wa
"" needed
"func ExitFile(timer)
"    :q
"endfunc
"
""firenvim specific
"au BufEnter github.com_*.txt set filetype=markdown
"au BufEnter localhost_notebooks-*.txt set filetype=python
"if exists('g:started_by_firenvim')
"	set termguicolors
"	colorscheme solarized8
"	autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
"endif
"function! s:IsFirenvimActive(event) abort
"  if !exists('*nvim_get_chan_info')
"    return 0
"  endif
"  let l:ui = nvim_get_chan_info(a:event.chan)
"  return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
"      \ l:ui.client.name =~? 'Firenvim'
"endfunction
"
"function! OnUIEnter(event) abort
"  if s:IsFirenvimActive(a:event)
"	  set lines=65
"	  set columns=100
"  endif
"endfunction
"
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1, 20) : "\<C-d>"
  nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0, 20) : "\<C-u>"
  inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1, 20)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0, 20)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1, 20) : "\<C-d>"
  vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0, 20) : "\<C-u>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"rust-analyzer.moveItemUp	Move item up
"rust-analyzer.moveItemDown	Move item down
"rust-analyzer.joinLines	Join lines
"rust-analyzer.explainErro
"r	Explain the currently hovered error message
"rust-analyzer.debug	List available runnables of current file and debug the selected one
"rust-analyzer.expandMacro
"

let g:solarized_termtrans=1
colorscheme solarized
set smartcase
set ignorecase
set colorcolumn=99
" terminal window has a title which has a name of current focused file
set title
set cursorline "highlight line that cursor is currently in
syntax on
" highlighting in visual becomes the same as status line
" NOTE: this must always come after colorscheme is selected
highlight! link Visual StatusLine
highlight! link Visual StatusLine
" change floating documentation window background color to lighter background color
hi CocFloating ctermbg=0
set number relativenumber

" Treesitter Symbols
" LSP Code Actions
" LSP Definitions
" LSP Workspace Symbols
" Loclist
" Find Files
"
nnoremap <C-h> <cmd>Telescope find_files<cr>
noremap <C-a> <cmd>Telescope lsp_code_actions<cr>
noremap <C-p> <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
noremap <leader>d <cmd>Telescope lsp_definitions<cr>
noremap <leader>l <cmd>Telescope loclist<cr>
autocmd FileType rust noremap <F5> <cmd>RustRunnables<cr>
autocmd FileType rust noremap <leader>e <cmd>RustExpandMacro<cr>
autocmd FileType rust noremap <C-m> <cmd>RustParentModule<cr>
autocmd FileType rust noremap <S-j> <cmd>RustJoinLines<cr>
autocmd FileType rust noremap <A-j> <cmd>RustMoveItemDown<cr>
autocmd FileType rust noremap <A-k> <cmd>RustMoveItemUp<cr>


" RustSetInlayHints
" RustDisableInlayHints
" RustToggleInlayHints
"
" RustRunnables
" RustExpandMacro
" RustOpenCargo 
" RustParentModule
" RustJoinLines
" RustHoverActions
" RustMoveItemDown
" RustMoveItemUp

lua << EOF
local opts = {
    tools = { -- rust-tools options
        -- automatically set inlay hints (type hints)
        -- There is an issue due to which the hints are not applied on the first
        -- opened file. For now, write to the file to trigger a reapplication of
        -- the hints or just run :RustSetInlayHints.
        -- default: true
        autoSetHints = true,

        -- whether to show hover actions inside the hover window
        -- this overrides the default hover handler
        -- default: true
        hover_with_actions = true,

        runnables = {
            -- whether to use telescope for selection menu or not
            -- default: true
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },

        inlay_hints = {
            -- wheter to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,

            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<-",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix  = "=>",

            -- whether to align to the lenght of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
              {"╭", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╮", "FloatBorder"},
              {"│", "FloatBorder"},
              {"╯", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╰", "FloatBorder"},
              {"│", "FloatBorder"}
            },
        }
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {}, -- rust-analyer options
}

require('rust-tools').setup(opts)
EOF



