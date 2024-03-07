syntax on
filetype indent plugin on
set omnifunc=syntaxcomplete#Complete
set number
set relativenumber
" Edit vimr configuration file
nnoremap confe :e $MYVIMRC<CR>
" Reload vims configuration file
nnoremap confr :source $MYVIMRC<CR>
" Toggle paste
set pastetoggle=<F3>
" Statusline
set laststatus=2
set statusline=%f%=%c:%l/%L\|%{&filetype}
" Tabs
set autoindent expandtab tabstop=2 shiftwidth=2
" Catppuccin
let g:lightline = {'colorscheme': 'catppuccin_mocha'}
" Colorscheme
colorscheme catppuccin_mocha
" Indent guides
set background=dark
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let g:indent_guides_enable_on_vim_startup=1
" Cursor modes:
" line in insert mode
" block in normal mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" Strip trailing whitespace on save
function! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
