let g:currentmode={ 'n' : 'Normal', 'no' : 'N·Operator Pending ', 'v' : 'Visual ', 'V' : 'V·Line ', '^V' : 'V·Block ', 's' : 'Select ', 'S': 'S·Line ', '^S' : 'S·Block ', 'i' : 'Insert ', 'R' : 'Replace ', 'Rv' : 'V·Replace ', 'c' : 'Command ', 'cv' : 'Vim Ex ', 'ce' : 'Ex ', 'r' : 'Prompt ', 'rm' : 'More ', 'r?' : 'Confirm ', '!' : 'Shell ', 't' : 'Terminal '}

function! ModeCurrent() abort
    let l:modecurrent = mode()
    " use get() -> fails safely, since ^V doesn't seem to register
    " 3rd arg is used when return of mode() == 0, which is case with ^V
    " thus, ^V fails -> returns 0 -> replaced with 'V Block'
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·Block '))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction

syntax on
set nonumber
set hidden
set showmatch

" Set ~ of empty lines as same color as bg (hide them)
highlight EndOfBuffer ctermfg=black ctermbg=black
set autoindent
set copyindent
set wrap
set autoread
set ruler
set linebreak
set tabstop=4
set shiftwidth=4
set history=1000
set nobackup
set noswapfile
set pastetoggle=<F2>
set mouse=a
set laststatus=2
set statusline=
set statusline+=%2*\ %l
set statusline+=\ %*
set statusline+=%1*\ ‹‹
set statusline+=%1*\ %t\ %*
set statusline+=%1*\ ››
set statusline+=\ %{ModeCurrent()}

set statusline+=%=
set statusline+=\ %{strftime('%H:%M')}
set statusline+=\ %Y
