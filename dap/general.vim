lua << EOF
local dap = require('dap')
require("dapui").setup()
vim.g.dap_virtual_text = 'all frames'

local dap_install = require("dap-install")
local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

for _, debugger in ipairs(dbg_list) do
   dap_install.config(debugger,{})
end
dap.configurations.javascript = dap.configurations.javascriptreact
dap.configurations.javascript = 
{ {
    cwd = vim.fn.getcwd(),
    port = 9222,
    program = "${file}",
    protocol = "inspector",
    request = "attach",
    sourceMaps = true,
    type = "chrome",
    webRoot = "${workspaceFolder}",
    runtimeExecutable = "chromium"
} }
EOF
