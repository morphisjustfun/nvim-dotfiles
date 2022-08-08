tnoremap <Esc> <C-\><C-n>
set runtimepath+=~/.vim/config
lua << EOF
require('init')
EOF
