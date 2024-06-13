"must be activated with autocmd to work properly
let g:rainbow_active = 0 
let g:rainbow_conf = {
\	'guifgs': ['#B58900', '#CB4B16', '#93A1A1', '#2AA198', '#859900'],
\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\	'guis': [''],
\	'cterms': [''],
\	'operators': '',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold', 'start=/</ end=/>/ fold'],
\	'separately': {
\		'*': {},
\		'nerdtree': 0,
\	},
\}

"	'guifgs': ['#B58900', '#859900', '#93A1A1', '#6C71C4', '#D33682', '#CB4B16', '#2AA198'],
"	'ctermfgs': ['#B58900', '#859900', '#93A1A1', '#6C71C4', '#D33682', '#CB4B16', '#2AA198'],
"\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
"\	'operators': '_,\|+\|-\|*\|\/\|=\|!=|=>_',
"
"
"autocmd BufRead,BufNewFile *.rs set filetype=rs
"syntax match MyOperator '=|\(==\)'
"syntax match MyOperator '+\|-\|_\|=\|\*\|&\|\^\|%\|\$\|#\|@\|!\|\~\|\,\|;\|:\|.'
"highlight MyOperator ctermfg=lightyellow guifg=#B58900
"highlight MyOperator ctermfg=lightyellow guifg=#FF0000
"
let g:rnvimr_layout = {
            \ 'relative': 'editor',
            \ 'width': float2nr(round(1.0 * &columns)),
            \ 'height': float2nr(round(1.0 * &lines)),
            \ 'col': float2nr(round(0.15 * &columns)),
            \ 'row': float2nr(round(0.15 * &lines)),
            \ 'style': 'minimal'
            \ }
" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1
" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1
" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_enable_bw = 1
" Map Rnvimr action
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
" Show the files included in gitignore
let g:rnvimr_hide_gitignore = 0

" Replace `$EDITOR` candidate with this command to open the selected file
let g:rnvimr_edit_cmd = 'drop'

" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END
"

" ==============================================================================
" Name:          ShowPairs
" Description:   Highlights the pair surrounding the current cursor location.
" Maintainer:    Anthony Kruize <trandor@gmail.com>
" Version:       2.1
" Modified:      8 February 2006
" ChangeLog:     See :help showpairs-changelog
"
" Usage:         Copy this file into the plugin directory so it will be
"                automatically sourced.
"
" Configuration: ***********************************************************
"                * PLEASE read the included help file(showpairs.txt) for a *
"                * more thorough explanation of how to use ShowPairs.      *
"                ***********************************************************
"                If you'd like to have the pair to the character just entered
"                in insert mode highlighted, the 'showmatch' and 'matchtime'
"                global options can be used.
"                For more information see  :help showmatch
"
"                To enable or disable ShowPairs while editing, map a key
"                sequence to the command 'ShowPairsToggle'
"                Example: map <F5> :ShowPairsToggle<cr>
"
"                The following options can be used to customize the behaviour
"                of ShowPairs.  Simply include them in your vimrc file with
"                the desired settings.
"
"                showpairs_enable    (Default: 1)
"                   Defines whether ShowPairs is enabled by default or not.
"                   Example: let g:showpairs_enable=0
"
"                showpairs_limit     (Default: 150)
"                   Defines the number of lines to search on either side of
"                   the cursor.
"                   Example: let g:showpairs_limit=20
"
" ==============================================================================

" Check if we should continue loading
if exists( "loaded_showpairs" )
	finish
endif
let loaded_showpairs = 1

" Options: Set up some nice defaults
if !exists('g:showpairs_enable'  ) | let g:showpairs_enable   = 1   | endif
if !exists('g:showpairs_limit'   ) | let g:showpairs_limit    = 150 | endif

" Not used yet: see s:pairs/opairs/cpairs below
if !exists('g:showpairs_pairs')
	let g:showpairs_pairs = "(:),{:},[:],<:>,#ifdef:#endif"
endif

" Commands
com! -nargs=0 ShowPairsToggle :silent call <sid>ShowPairsToggle()

" Initialize globals
let s:mps = '(:),{:},<:>,[:]'
let s:pairs  = substitute(s:mps,",","","g")
" let s:pairs  = substitute(&mps,",","","g")
let s:opairs = substitute(s:pairs,":.","","g")
let s:cpairs = substitute(s:pairs,".:","","g")
let s:pairs  = substitute(s:pairs,":","","g")
" Special case for '[' and ']'
if( match(s:opairs,"[") > 0 )
	let s:opairs = "[".substitute(s:opairs,"[","","")
endif
if( match(s:cpairs,"]") > 0 )
	let s:cpairs = "]".substitute(s:cpairs,"]","","")
endif
if( match(s:pairs,"]") > 0 )
	let s:pairs  = "]".substitute(s:pairs,"]","","")
endif
let s:pairs = "[".s:pairs."]"
let s:oln   = -1
let s:ocl   = -1
let s:cln   = -1
let s:ccl   = -1

com! -nargs=0 PairDebug :silent call <sid>PairDebug()
fun! s:PairDebug() 
	execute('!notify-send "vimmer' . s:opairs . '"')
endf

" AutoCommands: Only if ShowPairs is enabled
if g:showpairs_enable == 1
	aug ShowPairs
		au!
		autocmd CursorHold * call s:ShowPairs()
" For Vim 7 only		autocmd InsertEnter * match none
	aug END
endif

" Highlighting: Set up some nice colours to show the pairs (by default we'll bold them)
"hi default ShowPairsHL ctermfg=white ctermbg=bg cterm=bold guifg=white guibg=bg gui=bold
"hi default ShowPairsHLp ctermfg=white ctermbg=bg cterm=bold guifg=white guibg=bg gui=bold
hi default ShowPairsHL guibg=#064b72
hi default ShowPairsHLp guibg=#064b72
hi default link ShowPairsHLe Error


" Function: ShowPairsToggle()
" Description: Toggles whether pairs are highlighted or not.
fun! s:ShowPairsToggle()
	let g:showpairs_enable = !g:showpairs_enable
	if g:showpairs_enable == 1
		aug ShowPairs
			autocmd CursorHold * call s:ShowPairs()
		aug END
	else
		match none
		aug ShowPairs
			au!
		aug END
	endif
endf

" Function: Showpairs()
" Description: Highlights the pair that the cursor is currently inside.
" Version 1.x used searchpair() to do it's magic, but the problem is that it
" moves the cursor around and affects the jump list which is undesirable.
" This version does it's own searching, hence the more complicated implementation.
fun! s:ShowPairs()
	if g:showpairs_enable == 1
		match none

		let ch = strpart(getline(line('.')), col('.') - 1, 1)
		if strlen(ch) && match(s:opairs, ch) > -1
			call <sid>FindUnMatchedClosingPair(strpart(s:cpairs, match(s:opairs, ch), 1))
			if s:ccl > -1
				exe 'match ShowPairsHL /\%'.line('.').'l\%'.col('.').'c\|\%'.s:cln.'l\%'.s:ccl.'c/'
			endif
		elseif strlen(ch) && match(s:cpairs, ch) > -1
			call <sid>FindUnMatchedOpeningPair(strpart(s:opairs, match(s:cpairs, ch), 1))
			if s:ocl > -1
				exe 'match ShowPairsHL /\%'.s:oln.'l\%'.s:ocl.'c\|\%'.line('.').'l\%'.col('.').'c/'
			endif
		else
			let opair = s:FindUnMatchedOpeningPair(s:opairs)
			if s:ocl > -1
				call <sid>FindUnMatchedClosingPair(strpart(s:cpairs, match(s:opairs, opair), 1))
				if s:ccl > -1
					exe 'match ShowPairsHLp /\%'.s:oln.'l\%'.s:ocl.'c\|\%'.s:cln.'l\%'.s:ccl.'c/'
				else
					"exe 'match ShowPairsHLe /\%'.s:oln.'l\%'.s:ocl.'c/'
				endif
			else
				call <sid>FindUnMatchedClosingPair(s:cpairs)
				if s:ccl > -1
					" exe 'match ShowPairsHLe /\%'.s:cln.'l\%'.s:ccl.'c/'
				endif
			endif
		endif
	endif
endf

" Function: FindUnMatchedOpeningPair()
fun! s:FindUnMatchedOpeningPair(opairs)
	let found = 0
	let pos = col('.')
	let curline = line('.')
	let line_count = 0
	let ch = ''
	let charpos = 0

	while found == 0 && line_count < g:showpairs_limit
		let str = getline(curline - line_count)
		while pos > -1
			let pos = <sid>Matchr(str, s:pairs, pos - 1)
			if pos > -1
				let ch = strpart(str, pos - 1, 1)
				if match(s:cpairs, ch) == -1
					if match(a:opairs, ch) > -1
						let p = match(s:opairs, ch)
						if exists('count_'.p) == 0
							let count_{p} = 0
						endif
						if count_{p} <= 0
							let found = 1
							let charpos = pos
							let pos = -1
						else
							let count_{p} = count_{p} - 1
						endif
					endif
				else
					let p = match(s:cpairs, ch)
					if exists('count_'.p) == 0
						let count_{p} = 0
					endif
					let count_{p} = count_{p} + 1
				endif
			endif
		endw
		let line_count = line_count + 1
		let pos = match(getline(curline - line_count), "$") + 1
	endw
	if found == 1
		let s:oln = curline - line_count + 1
		let s:ocl = charpos
		return ch
	else
		let s:oln = -1
		let s:ocl = -1
	endif
endf

" Function: FindUnMatchedClosingPair()
fun! s:FindUnMatchedClosingPair(cpairs)
	let found = 0
	let pos = col('.')
	let curline = line('.')
	let line_count = 0
	let ch = ''
	let charpos = 0

	while found == 0 && line_count < g:showpairs_limit
		let str = getline(curline + line_count)
		while pos > -1
			let pos = matchend(str, s:pairs, pos)
			if pos > -1
				let ch = strpart(str, pos - 1,1)
				if match(s:opairs, ch) == -1
					if match(a:cpairs, ch) > -1
						let p = match(s:cpairs, ch)
						if exists('count_'.p) == 0
							let count_{p} = 0
						endif
						if count_{p} <= 0
							let found = 1
							let charpos = pos
							let pos = -1
						else
							let count_{p} = count_{p} - 1
						endif
					endif
				else
					let p = match(s:opairs, ch)
					if exists('count_'.p) == 0
						let count_{p} = 0
					endif
					let count_{p} = count_{p} + 1
				endif
			endif
		endw
		let line_count = line_count + 1
		let pos = 0
	endw
	if found == 1
		let s:cln = curline + line_count - 1
		let s:ccl = charpos
		return ch
	else
		let s:cln = -1
		let s:ccl = -1
	endif
endf

" Function: Matchr()
" Parameters: expr  - Specifies the string to search
"             pat   - specifies the pattern to search for.
"             start - Specifies the position to search from.
" Description: Behaves similar to match() but searches backwards.
fun! s:Matchr(expr, pat, start)
	let npos = -1
	let pos = matchend(a:expr, a:pat)
	while pos > -1 && pos <= a:start
		let npos = pos
		let pos = matchend(a:expr, a:pat, pos)
	endw
	return npos
endf

