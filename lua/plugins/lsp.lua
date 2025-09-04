local lsp = require('lspconfig')

lsp.pyright.setup({})      -- Python

vim.keymap.set('n', 'gd', vim.lsp.buf.definition) -- Переход к определению
vim.keymap.set('n', 'K', vim.lsp.buf.hover)       -- Документация


vim.keymap.set('gD', vim.lsp.buf.declaration)
vim.keymap.set('gd', vim.lsp.buf.definition)
vim.keymap.set('K', vim.lsp.buf.hover)
vim.keymap.set('gi', vim.lsp.buf.implementation)
vim.keymap.set('<C-k>', vim.lsp.buf.signature_help)
vim.keymap.set('<space>wa', vim.lsp.buf.add_workspace_folder)
vim.keymap.set('<space>wr', vim.lsp.buf.remove_workspace_folder)
vim.keymap.set('<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
vim.keymap.set('<space>D', vim.lsp.buf.type_definition)
vim.keymap.set('<space>rn', vim.lsp.buf.rename)
vim.keymap.set('<space>ca', vim.lsp.buf.code_action)
vim.keymap.set('gr', vim.lsp.buf.references)
vim.keymap.set('<space>e', vim.diagnostic.open_float)
vim.keymap.set('[d', vim.diagnostic.goto_prev)
vim.keymap.set(']d', vim.diagnostic.goto_next)
vim.keymap.set('<space>q', vim.diagnostic.setloclist)
vim.keymap.set('<space>f', vim.lsp.buf.formatting)
vim.keymap.set('<F12>', function() require('telescope.builtin').lsp_definitions() end)
vim.keymap.set('<S-F12>', function() require('telescope.builtin').lsp_references({jump_type="never"}) end)
