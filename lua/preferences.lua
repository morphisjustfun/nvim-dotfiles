-- Preferences

vim.cmd([[
filetype plugin on
syntax enable
let mapleader = " "
let &t_ut=''
set undodir=~/.vim/undodir
]])
vim.opt.compatible = false
vim.opt.number = true
vim.opt.numberwidth = 1
vim.opt.clipboard = {"unnamedplus"}
vim.opt.showcmd = true
vim.opt.ruler = true
vim.opt.encoding = "utf-8"
vim.opt.showmatch = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 3
vim.opt.relativenumber = true
vim.opt.laststatus = 2
vim.opt.showmode = false
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.shortmess:append({c = True})
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.signcolumn = "yes:2"
vim.opt.mouse = {a = true}
vim.opt.incsearch = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldnestmax = 3
vim.opt.foldminlines = 1
vim.opt.conceallevel = 0
vim.opt.foldenable = false
vim.opt.list = true
vim.opt.fillchars = { fold = " " }
vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.o.dictionary="/usr/share/dict/words"



-- Vista
vim.g.vista_default_executive = "nvim_lsp"

-- Dashboard

vim.g.dashboard_default_executive = "telescope"
vim.cmd([[
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
]])

-- Autopep8

vim.g.autopep8_aggressive = 2
vim.g.autopep8_disable_show_diff = 1

-- NvimTree

vim.g.auto_session_pre_save_cmds = {"tabdo NvimTreeClose","tabdo lua require('dapui').close()"}
vim.g.auto_session_post_restore_cmds = {"tabdo NvimTreeClose","tabdo lua require('dapui').close()"}

-- Syntax for cshtml

vim.cmd([[
autocmd BufNewFile,BufRead *.cshtml set syntax=html
autocmd BufNewFile,BufRead *.cshtml set filetype=html
]])

-- Github copilot

vim.g.copilot_no_tab_map = true
