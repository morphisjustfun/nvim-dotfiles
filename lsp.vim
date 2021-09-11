lua << EOF
require "lspinstall".setup() -- important

local on_attach = function(client, bufnr)
    require "lsp_signature".on_attach()
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
    -- Mappings.
    local opts = {noremap = true, silent = true}
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", ":Telescope lsp_definitions<CR>", opts)
    buf_set_keymap("n", "K", ":Lspsaga hover_doc<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
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
        vim.api.nvim_exec(
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
    capabilities.textDocument.completion.completionItem.documentationFormat = {"markdown", "plaintext"}
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.preselectSupport = true
    capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
    capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
    capabilities.textDocument.completion.completionItem.deprecatedSupport = true
    capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
    capabilities.textDocument.completion.completionItem.tagSupport = {valueSet = {1}}
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits"
        }
    }
    return {
        -- enable snippet support
        capabilities = capabilities,
        -- map buffer local keybindings when the language server attaches
        on_attach = on_attach
    }
end

-- lsp-install
local function setup_servers()
    require "lspinstall".setup()

    -- get all installed servers
    local servers = require "lspinstall".installed_servers()
    -- ... and add manually installed servers
    -- table.insert(servers, "clangd")
    -- table.insert(servers, "sourcekit")

    for _, server in pairs(servers) do
        local config = make_config()
        -- language specific nvim_win_get_config

        -- Debugging keymaps

        vim.api.nvim_exec([[
       nnoremap <leader>b :lua require'dap'.toggle_breakpoint()<CR>
       ]], false)
        vim.api.nvim_exec([[
       nnoremap <leader>qo :lua require'dap'.step_over()<CR>
       ]], false)
        vim.api.nvim_exec([[
       nnoremap <leader>qi :lua require'dap'.step_into()<CR>
       ]], false)
        vim.api.nvim_exec([[
       nnoremap <leader>qc :lua require'dap'.continue()<CR>
       ]], false)
        vim.api.nvim_exec([[
       nnoremap <leader>qt :lua require'dapui'.toggle()<CR>
       ]], false)

        if server == "typescript" then
            require("null-ls").config {}
            require("lspconfig")["null-ls"].setup {}
            config.on_attach = function(client, bufnr)
                require "lsp_signature".on_attach()
                local function buf_set_keymap(...)
                    vim.api.nvim_buf_set_keymap(bufnr, ...)
                end
                local function buf_set_option(...)
                    vim.api.nvim_buf_set_option(bufnr, ...)
                end

                buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

                -- Mappings.
                local opts = {noremap = true, silent = true}
                buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
                buf_set_keymap("n", "gd", ":Telescope lsp_definitions<CR>", opts)
                buf_set_keymap("n", "K", ":Lspsaga hover_doc<CR>", opts)
                buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
                buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
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

                client.resolved_capabilities.document_formatting = false
                client.resolved_capabilities.range_formatting = false

                local ts_utils = require("nvim-lsp-ts-utils")

                ts_utils.setup {
                    debug = true,
                    disable_commands = false,
                    enable_import_on_completion = false,
                    -- import all
                    import_all_timeout = 5000, -- ms
                    import_all_priorities = {
                        buffers = 4, -- loaded buffer names
                        buffer_content = 3, -- loaded buffer content
                        local_files = 2, -- git files or files with relative path markers
                        same_file = 1 -- add to existing import statement
                    },
                    import_all_scan_buffers = 100,
                    import_all_select_source = false,
                    -- eslint
                    eslint_enable_code_actions = true,
                    eslint_enable_disable_comments = true,
                    eslint_bin = "eslint",
                    eslint_enable_diagnostics = false,
                    eslint_opts = {},
                    -- formatting
                    enable_formatting = false,
                    formatter = "prettier",
                    formatter_opts = {},
                    -- update imports on file move
                    update_imports_on_move = false,
                    require_confirmation_on_move = false,
                    watch_dir = nil,
                    -- filter diagnostics
                    filter_out_diagnostics_by_severity = {},
                    filter_out_diagnostics_by_code = {}
                }

                ts_utils.setup(client)

                -- Set some keybinds conditional on server capabilities
                buf_set_keymap("n", ";;", ":lua vim.lsp.buf.range_formatting()<CR>", opts)
                buf_set_keymap("n", ";;", ":TSLspFormat<CR>", opts)

                -- Set autocommands conditional on server_capabilities
                if client.resolved_capabilities.document_highlight then
                    vim.api.nvim_exec(
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
            require "lspconfig"[server].setup(config)
        elseif server == "python" then
           -- Use autopep8 when using python

            vim.api.nvim_exec([[
       nnoremap <silent> ;; :Autopep8<CR>
       ]], false)
            require "lspconfig"[server].setup(config)
        else
            require "lspconfig"[server].setup(config)
        end
    end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require "lspinstall".post_install_hook = function()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

vim.o.completeopt = "menuone,noselect"
local luasnip = require "luasnip"
local cmp = require "cmp"
local lspkind = require("lspkind")

cmp.setup {
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            return vim_item
        end
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ["<Tab>"] = function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
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
        end
    },
    sources = {
        {name = "nvim_lsp"},
        {name = "luasnip"},
        {name = "emoji"},
        {name = "calc"},
        {name = "path"}
    }
}
luasnip.snippets = {
    html = {}
}
luasnip.snippets.javascript = luasnip.snippets.html
luasnip.snippets.javascriptreact = luasnip.snippets.html

require("luasnip/loaders/from_vscode").load({include = {"html"}})
require("luasnip/loaders/from_vscode").lazy_load()

function _G.lsp_reinstall_all()
    local lspinstall = require "lspinstall"
    for _, server in ipairs(lspinstall.installed_servers()) do
        lspinstall.install_server(server)
    end
end

vim.cmd "command! -nargs=0 LspReinstallAll call v:lua.lsp_reinstall_all()"
EOF
