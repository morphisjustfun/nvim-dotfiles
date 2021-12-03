set nocompatible
filetype plugin on
set number
set numberwidth=1
set clipboard+=unnamedplus
syntax enable
set showcmd 
set ruler
set encoding=utf-8
set showmatch
set expandtab
set shiftwidth=3
set relativenumber
set laststatus=2
set noshowmode
set hidden
set nobackup
set nowritebackup
set noswapfile
set cmdheight=2
set updatetime=300
set shortmess+=c
set termguicolors
set cursorline
set cursorcolumn
set splitright
set splitbelow
let mapleader = " "
let &t_ut=''
set signcolumn=yes:2
set mouse=a
set incsearch

" Vista

let g:vista_default_executive = 'nvim_lsp'

" Dashboard

let g:dashboard_default_executive ='telescope'
let g:dashboard_custom_header =[
         \'               (%%%##%%%/%%##%%&%%/%%%#%#%%%%%%%%%%//%%%%%%##%#%#%%#            ',
         \'              %&%%%%%&%/%%%%%&&&&%/%/%%%%&&%%%%%&&%%%/%%&%%&%%%%%%%%%           ',
         \'             &%%&%%%%%/%%%%%&&&&/%/%/%%%%&&%%*%%%&%%%%%/%%&&%%%%%%/%%,          ',
         \'             %&%%%%%%%%%%%%%&&&**%/%%%%%%&%%%..%%%%%%%%%%%%&&%%%%%%%%%          ',
         \'             %%&%%%&%/%%%%%&&&...%%%%%%%%&%%%...%%%%%%%%%%#%&%%%%%%/%%          ',
         \'             %%&%%&%%%%%%%&&&....%%%%%%%%&%%......%%%%%%%%%%%%%%%%%%%%          ',
         \'             %&&%%&%%%%%%&#...**%.%%%%%%%&%%..&&....%%%%%%%%%%%%%%%%%%          ',
         \'             %%&%&&%%%%%%.&&&....*%%&%%%%%%..*/.......%%%%%%%%%%%%%%%%          ',
         \'              %&%.%%%%%&,    &&&&..&%%&%%%&...&&  &&&&,%%%%%%%%%%%%%%           ',
         \'              &..%%%%%.&  &&#&%& ,..%%%%%%%... &&%&&&& .&%%%%%%%%&%%%           ',
         \'               %%%%%.....  &%*(& ....%..%%%%.. &&#%#&  ....%%%%%%%%%            ',
         \'              %%%.,*......................&%..............*&&%%&%%&%            ',
         \'            %# %&#..*(.....,..............................%%&&%%&&%&            ',
         \'              %&&&&......................................%%%%&%%%%%.            ',
         \'             %&& &&&&&&&.................................%%%%%%%&%%             ',
         \'            #&   &&&&&&&..............,        ........&%%%%%%%&&%%,            ',
         \'            %    &&&&&&&&&..........,         ........&&%%%%%%&& &%%            ',
         \'                  &&&&&&&&&&&.......................&&&%%%%%%&&   %%            ',
         \'                  .&& &&&&&&&&&&%,..............&&&&&&%%%%%%&&,     %           ',
         \'                  &   &&&*&&&&.,,****#....%*****,,&&&&%%%%% &&                  ',
         \'                 *    &&&  &##  ,***************, ##&&%%# &  &                  ',
         \'                      #######     ,(*********,,   %##&%&      *                 ',
         \'    &#######################&         ,&*,.        ###%##########&,             ',
         \' ###########################         ,,//(,        %######%####################&',
\]

" Vim autopep8

let g:autopep8_aggressive=2

" Nvim tree

let g:auto_session_pre_save_cmds = ["tabdo NvimTreeClose","tabdo lua require('dapui').close()"]
autocmd BufNewFile,BufRead *.cshtml set syntax=html
autocmd BufNewFile,BufRead *.cshtml set filetype=html
