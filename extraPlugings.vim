lua << EOF
local saga = require "lspsaga"
saga.init_lsp_saga(
{
    error_sign = '', -- 
    warn_sign = '',
    hint_sign = '',
    infor_sign = '',
}
)
require "lsp_signature".setup()

require("twilight").setup {}

require("trouble").setup {}

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

require("telescope").load_extension("flutter")
local telescope = require("telescope")

telescope.setup {
    defaults = {
        mappings = {
            i = {["<c-t>"] = trouble.open_with_trouble},
            n = {["<c-t>"] = trouble.open_with_trouble}
        }
    }
}

require("todo-comments").setup {}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = true
    }
)
require "colorizer".setup()

require("lualine").setup(
    {
        options = {disabled_filetypes = {"dashboard","NvimTree"},
        -- theme = "tokyonight"
        theme = "catppuccin"
        },
    }
)
EOF
