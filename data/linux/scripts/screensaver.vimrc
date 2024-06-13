set nocompatible
let g:calendar_first_day= "monday"
let g:calendar_date_endian = "little"
let g:calendar_date_separator = "."

call plug#begin('~/.vim/plugged')
Plug 'itchyny/calendar.vim'
call plug#end()

func ExitFile(timer)
    :q
endfunc
