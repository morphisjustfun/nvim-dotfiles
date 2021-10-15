" General keymaps

nmap qq :q<CR>
nmap ww :w<CR>
nmap wa :wa<CR>
nmap <C-X> :noh<CR>
nnoremap <Leader>. 10<C-w>>
nnoremap <Leader>, 10<C-w><
nnoremap <Leader>m 10<C-w>+
nnoremap <Leader>/ 10<C-w>-
nnoremap <leader>; :tabnew<CR>

" Telescope keymaps

nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>x <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>aa :Telescope lsp_document_diagnostics<CR>
nnoremap <leader>ad :Telescope lsp_workspace_diagnostics<CR>
nnoremap <leader><leader> :Telescope<CR>
nmap // :Telescope current_buffer_fuzzy_find<CR>

" Lspsaga keymaps

nnoremap <leader>s :Lspsaga code_action <CR>
nnoremap <silent><leader>s :Lspsaga code_action<CR>
vnoremap <silent><leader>s :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent><leader>cc <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>
nnoremap <silent> [d <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]d <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal('lazygit')<CR> 
tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>

" Vista keymaps

nnoremap <leader>i :Vista!!<CR>

" NvimTree

nmap <Leader>nt :NvimTreeToggle<CR>
