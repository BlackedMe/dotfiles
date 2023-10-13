call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'sainnhe/everforest'
Plug 'vim-airline/vim-airline'
call plug#end()
set number
let g:everforest_better_performance = 1
colorscheme everforest
set tabstop=4
set background=dark
set wildmenu
set wildmode=list:longest
set cursorline
nnoremap <F2> :NERDTreeToggle <CR>
