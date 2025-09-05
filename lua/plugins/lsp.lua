local lsp = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem = {
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },  -- Поддержка тегов (например, deprecated)
  resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  }
}

vim.diagnostic.config({
  virtual_text = true,  -- Показывает ошибки в тексте
  signs = true,         -- Значки на полях
  update_in_insert = false,
})

-- Общая функция для keymaps
local on_attach = function(client, bufnr)
  -- Опции для буферных keymaps
  local opts = { buffer = bufnr }

  require('which-key').register({
    ['<space>'] = {
      e = { vim.diagnostic.open_float, "Show diagnostic" },
      f = { "Format file" },
      -- ... остальные хинты
    },
    g = {
      D = { "Go to declaration" },
      d = { "Go to definition" },
      -- ... 
    },
  }, { buffer = bufnr })

  -- Навигация
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

  -- Рабочее пространство
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)

  -- Действия
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format({ async = true })
  end, opts)

  -- Диагностика
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  -- Telescope (если установлен)
  pcall(function()
    vim.keymap.set('n', '<F12>', function()
      require('telescope.builtin').lsp_definitions()
    end, opts)
    vim.keymap.set('n', '<S-F12>', function()
      require('telescope.builtin').lsp_references({ jump_type = "never" })
    end, opts)
  end)
end

lsp.gopls.setup{
    cmd = {
        "ya",
        "tool",
        "gopls",
        "-rpc.trace",
        "-logfile",
        "/home/mortalturtle/.local/state/nvim/gopls.log",
    },
    capabilities = capabilities,
    settings = {
        gopls = {
          directoryFilters = {
              "-",
              "-library",
              "+junk/mortalturtle",
              "+xiva/core/gocommon",
              "+xiva/private_api",
              "+xiva/sms_relay",
              "+library/go",
          },
          expandWorkspaceToModule = false,
          analyses = {
              unreachable = true,
              unusedparams = true,
              shadow = true,
          },
          staticcheck = true,
          gofumpt = true,
          completeUnimported = true,
          usePlaceholders = true,
          hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
          }}
    },
    root_markers = {
        "ya.make",
        "go.work",
        "go.mod",
        ".git",
    },
}

lsp.clangd.setup(
  {
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=never",
      "--all-scopes-completion",
      "--cross-file-rename"
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
  }
)

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- Линтинг
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.pylint,

    -- Форматирование
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.stylua, -- для Lua
    null_ls.builtins.formatting.black,   -- для Python

    -- Действия с кодом
    null_ls.builtins.code_actions.gitsigns,
  },
})
