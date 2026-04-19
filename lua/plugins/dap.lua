local dap = require('dap')
local dapui = require("dapui")

vim.keymap.set('n', '<F5>', dap.continue, { desc = "Continue" })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = "Step over" })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = "Step into" })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = "Steb out" })
vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint, { desc = "Breakpoint" })
vim.keymap.set('n', '<leader>B', function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
  end,
  { desc = "Conditional breakpoint" })

-- Автоматическое открытие/закрытие
local dap = require('dap')
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end


vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = '[D]AP [U]I toggle' })
vim.keymap.set('n', '<leader>dc', dapui.close, { desc = '[D]AP [C]lose' })

dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = "dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug (delve)",
    request = "launch",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug with args (delve)",
    request = "launch",
    program = "${file}",
    args = function()
      return vim.fn.input("Arguments: ", "")
    end,
  },
  {
    type = "delve",
    name = "Debug test (delve)",
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug package (delve)",
    request = "launch",
    program = "./${relativeFileDirname}",
  },
}

dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-dap',
  name = 'lldb'
}


-- Конфигурации отладки для C++
dap.configurations.cpp = {
  {
    name = 'Launch (lldb)',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'enable pretty printing',
        ignoreFailures = false
      },
    },
  },
  {
    name = 'Attach to process (lldb)',
    type = 'lldb',
    request = 'attach',
    pid = require('dap.utils').pick_process,
    args = {},
  },
}
