-- General keymaps

vim.api.nvim_set_keymap("n", "qq", "<CMD>q<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "ww", "<CMD>w<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "wa", "<CMD>wa<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<C-X>", "<CMD>noh<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<LEADER>,", "10<C-w><", {noremap = true})
vim.api.nvim_set_keymap("n", "<LEADER>.", "10<C-w>>", {noremap = true})
vim.api.nvim_set_keymap("n", "<LEADER>m", "10<C-w>+", {noremap = true})
vim.api.nvim_set_keymap("n", "<LEADER>/", "10<C-w>-", {noremap = true})
vim.api.nvim_set_keymap("n", "<LEADER>;", "<CMD>tabnew<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<S-j>", "<CMD>m .+1<CR>==", {noremap = true})
vim.api.nvim_set_keymap("n", "<S-l>", "<CMD>m .-2<CR>==", {noremap = true})


vim.cmd([[
vnoremap <S-j> :m '>+1<CR>gv=gv
vnoremap <S-l> :m '<-2<CR>gv=gv
]])

-- Telescope keymaps

vim.api.nvim_set_keymap("n", "<LEADER>f", "<CMD>lua require('telescope.builtin').find_files()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<LEADER>x", "<CMD>lua require('telescope.builtin').live_grep()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<LEADER>aa", "<CMD>Telescope diagnostics bufnr=0<CR>", {noremap = true})

vim.api.nvim_set_keymap("n", "<LEADER>ad", "<CMD>Telescope diagnostics<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<LEADER><LEADER>", "<CMD>Telescope<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "//", "<CMD>Telescope current_buffer_fuzzy_find<CR>", {noremap = true})

-- Lspsaga keymaps

vim.api.nvim_set_keymap("n", "[d", "<CMD>Lspsaga diagnostic_jump_prev<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "]d", "<CMD>Lspsaga diagnostic_jump_next<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<A-d>", "<CMD>lua require('lspsaga.floaterm').open_float_terminal('lazygit')<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("t", "<A-d>", "<C-\\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<LEADER>s", "<CMD>Lspsaga code_action<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<LEADER>s", "<CMD><C-U>Lspsaga code_action<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<LEADER>cc", "<CMD>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>", {noremap = true, silent = true})

-- Vista keymaps

vim.api.nvim_set_keymap("n", "<LEADER>i", "<CMD>Vista!!<CR>", {noremap = true})

-- NvimTree keymaps
vim.api.nvim_set_keymap("n", "<LEADER>nt", "<CMD>NvimTreeToggle<CR>", {noremap = true})


-- Copilot

vim.api.nvim_set_keymap("i", "<C-l>", "copilot#Accept('\\<CR>')", {noremap = true, silent = true, expr = true})
