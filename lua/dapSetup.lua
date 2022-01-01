local dap = require('dap')
require("nvim-dap-virtual-text").setup {
    enabled = true, -- enable this plugin (the default)
    enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did notify its termination)
    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true, -- show stop reason when stopped for exceptions
    commented = false, -- prefix virtual text with comment string
-- experimental features:
    virt_text_pos = 'eol', -- position of virtual text, see :h nvim_buf_set_extmark()
    all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
                            -- e.g. 80 to position at column 80 see :h nvim_buf_set_extmark()
}

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

dap.configurations.cpp = 
{ {
    cwd = "${workspaceFolder}",                                                                                                                                                                                            
    miDebuggerPath = "/home/lordmarcusvane/.local/share/nvim/dapinstall/ccppr_vsc/gdb-10.2/gdb/gdb",
    name = "Launch file",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
    request = "launch",
    stopOnEntry = true,
    type = "cpptools",
    args = {"1","8","20","3","print"},
  }, {
    MIMode = "gdb",
    cwd = "${workspaceFolder}",
    miDebuggerPath = "/home/lordmarcusvane/.local/share/nvim/dapinstall/ccppr_vsc/gdb-10.2/gdb/gdb",
    miDebuggerServerAddress = "localhost:1234",
    name = "Attach to gdbserver :1234",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
    request = "launch",
    type = "cppdbg"
  } }

dap.configurations.c = dap.configurations.cpp

dap_install.config(
	"python",
    {
        adapters = {
            type = "executable",
            command = "python3",
            args = {"-m", "debugpy.adapter"}
        },
        configurations = {
            {
                type = "python",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                pythonPath = function()
                  local cwd = vim.fn.getcwd()
                  if vim.fn.executable(cwd .. '/env/bin/python') == 1 then
                    return cwd .. '/env/bin/python'
                  elseif vim.fn.executable(cwd .. '/.env/bin/python') == 1 then
                    return cwd .. '/.env/bin/python'
                  else
                    return '/usr/bin/python3'
                  end
                end
            }
        }
    }
)
require('dapui').setup()
