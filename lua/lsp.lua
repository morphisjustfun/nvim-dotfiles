-- Lsp servers

local win = require("lspconfig.ui.windows")
local _default_opts = win.default_opts

win.default_opts = function(opts)
	---@diagnostic disable-next-line: redefined-local
	local opts = _default_opts(opts)
	opts.border = "rounded"
	return opts
end

local lsp_installer = require("nvim-lsp-installer")

local on_attach = function(client, bufnr)
	require("lsp_signature").on_attach()
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
	-- Mappings.
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", ":Telescope lsp_definitions<CR>", opts)
	buf_set_keymap("n", "K", ":Lspsaga hover_doc<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", ":Lspsaga rename<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
	buf_set_keymap("n", "<space>e", ":Lspsaga show_line_diagnostics<CR>", opts)
	buf_set_keymap("n", "<S-M>", ":Lspsaga preview_definition<CR>", opts)

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		buf_set_keymap("n", ";;", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("n", ";;", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end

	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.cmd(
			[[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
			false
		)
	end
end

-- config that activates keymaps and enables snippet support
local function make_config()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.preselectSupport = true
	capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
	capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
	capabilities.textDocument.completion.completionItem.deprecatedSupport = true
	capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
	capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	}
	return {
		-- enable snippet support
		capabilities = capabilities,
		-- map buffer local keybindings when the language server attaches
		on_attach = on_attach,
	}
end

require("flutter-tools").setup({
	lsp = make_config(),
})

-- lsp-install
local function setup_servers()
	lsp_installer.on_server_ready(function(server)
		local config = make_config()

		vim.api.nvim_set_keymap(
			"n",
			"<LEADER>b",
			"<CMD>lua require'dap'.toggle_breakpoint()<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap("n", "==", "<CMD>lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "--", "<CMD>lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "\\", "<CMD>lua require'dap'.continue()<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap(
			"n",
			"<LEADER>qt",
			"<CMD>lua require'dapui'.toggle()<CR>",
			{ noremap = true, silent = true }
		)

		if server.name == "pyright" then
			vim.api.nvim_set_keymap("n", ";;", "<CMD>Autopep8<CR>", { noremap = true, silent = true })
			-- require "lspconfig"[server].setup(config)
			server:setup(config)
		elseif server.name == "tsserver" then
			config.settings = {
				format = { enable = false },
			}

			config.on_attach = function(client, bufnr)
				require("lsp_signature").on_attach()
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end
				local function buf_set_option(...)
					vim.api.nvim_buf_set_option(bufnr, ...)
				end

				buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
				-- Mappings.
				local opts = { noremap = true, silent = true }
				buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				buf_set_keymap("n", "gd", ":Telescope lsp_definitions<CR>", opts)
				buf_set_keymap("n", "K", ":Lspsaga hover_doc<CR>", opts)
				buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
				buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
				buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
				buf_set_keymap(
					"n",
					"<space>wl",
					"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
					opts
				)
				buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
				buf_set_keymap("n", "<space>rn", ":Lspsaga rename<CR>", opts)
				buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
				buf_set_keymap("n", "<space>e", ":Lspsaga show_line_diagnostics<CR>", opts)
				buf_set_keymap("n", "<S-M>", ":Lspsaga preview_definition<CR>", opts)

				-- Set some keybinds conditional on server capabilities
				if client.resolved_capabilities.document_formatting then
					buf_set_keymap("n", ";;", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
				elseif client.resolved_capabilities.document_range_formatting then
					buf_set_keymap("n", ";;", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
				end

				-- Set autocommands conditional on server_capabilities
				if client.resolved_capabilities.document_highlight then
					vim.cmd(
						[[
             augroup lsp_document_highlight
             autocmd! * <buffer>
             autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
             autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
             augroup END
             ]],
						false
					)
				end
			end
			server:setup(config)
		elseif server.name == "eslint" then
			config.settings = {
				format = { enable = true },
			}
			config.on_attach = function(client, bufnr)
				require("lsp_signature").on_attach()
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end
				local function buf_set_option(...)
					vim.api.nvim_buf_set_option(bufnr, ...)
				end

				buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
				-- Mappings.
				local opts = { noremap = true, silent = true }
				buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				buf_set_keymap("n", "gd", ":Telescope lsp_definitions<CR>", opts)
				buf_set_keymap("n", "K", ":Lspsaga hover_doc<CR>", opts)
				buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
				buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
				buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
				buf_set_keymap(
					"n",
					"<space>wl",
					"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
					opts
				)
				buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
				buf_set_keymap("n", "<space>rn", ":Lspsaga rename<CR>", opts)
				buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
				buf_set_keymap("n", "<space>e", ":Lspsaga show_line_diagnostics<CR>", opts)
				buf_set_keymap("n", "<S-M>", ":Lspsaga preview_definition<CR>", opts)

				client.resolved_capabilities.document_formatting = true

				-- Set some keybinds conditional on server capabilities
				if client.resolved_capabilities.document_formatting then
					buf_set_keymap("n", ";;", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
				elseif client.resolved_capabilities.document_range_formatting then
					buf_set_keymap("n", ";;", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
				end

				-- Set autocommands conditional on server_capabilities
				if client.resolved_capabilities.document_highlight then
					vim.cmd(
						[[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
						false
					)
				end
			end
			server:setup(config)
		elseif server.name == "jsonls" then
			config.settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
				},
			}
			server:setup(config)
		else
			server:setup(config)
		end
	end)
end

setup_servers()

-- lsp kind (pictograms like VS Code)

local lspkind = require("lspkind")

-- LuaSnip (snippets)

local luasnip = require("luasnip")

luasnip.snippets = {
	html = {},
}

luasnip.snippets.javascript = luasnip.snippets.html
luasnip.snippets.javascriptreact = luasnip.snippets.html

require("luasnip/loaders/from_vscode").load({ include = { "html" } })
require("luasnip/loaders/from_vscode").lazy_load()

-- cmp auto-completion

local cmp = require("cmp")

cmp.setup({
	formatting = {
		format = function(_, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			return vim_item
		end,
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
			elseif luasnip.jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "emoji" },
		{ name = "calc" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "neorg" },
		-- {name = "dictionary", keyword_length =2,}
	},
})

-- Custom command to reinstall all servers

function _G.lsp_reinstall_all()
	local lspinstall = require("lspinstall")
	for _, server in ipairs(lspinstall.installed_servers()) do
		lspinstall.install_server(server)
	end
end

vim.cmd("command! -nargs=0 LspReinstallAll call v:lua.lsp_reinstall_all()")
