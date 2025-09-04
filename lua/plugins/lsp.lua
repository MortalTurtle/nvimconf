local lsp = require('lspconfig')

lsp.pyright.setup({})      -- Python
lsp.rust_analyzer.setup({}) -- Rust
lsp.tsserver.setup({})     -- TypeScript

vim.keymap.set('n', 'gd', vim.lsp.buf.definition) -- Переход к определению
vim.keymap.set('n', 'K', vim.lsp.buf.hover)       -- Документация

