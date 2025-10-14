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

vim.keymap.set('n', 'tgd', function()
  require('telescope.builtin').lsp_definitions()
end, { desc = '[T]elescope [G]oto [D]efinition' })

vim.keymap.set('n', 'tgr', function()
  require('telescope.builtin').lsp_references({ jump_type = "never" })
end, { desc = '[T]elescope [G]oto [R]eferences' })

vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {desc = "Rename symbol"})

require('which-key').register({
    ['<space>'] = {
      d = {name="Dapui"},
      g = {
        name = "Go to",
        d = { function() require('telescope.builtin').lsp_definitions() end, "Go to Definition" },
        r = { function() require('telescope.builtin').lsp_references({ jump_type = "never" }) end, "Go to References" }
      },
      e = { '<cmd>lua vim.diagnostic.open_float()<CR>', "Show diagnostic" },
      f = { '<cmd>lua vim.lsp.buf.format({async=true})<CR>', "Format file" },
      D = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', "Type definition" },
      q = { '<cmd>lua vim.diagnostic.setloclist()<CR>', "Diagnostics to loclist" },
      w = {
        name = "Workspace",
        a = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', "Add folder" },
        r = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', "Remove folder" },
        l = { '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', "List folders" },
      },
      c = {
        a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', "Code action" },
      },
      r = {
        n = { vim.lsp.buf.rename, "Rename symbol" }
      },
    },
    g = {
      name = "Go to",
      D = { '<cmd>lua vim.lsp.buf.declaration()<CR>', "Declaration" },
      d = { '<cmd>lua vim.lsp.buf.definition()<CR>', "Definition" },
      i = { '<cmd>lua vim.lsp.buf.implementation()<CR>', "Implementation" },
      r = { '<cmd>lua vim.lsp.buf.references()<CR>', "References" },
    },
    ['['] = {
      d = { '<cmd>lua vim.diagnostic.goto_prev()<CR>', "Prev diagnostic" },
    },
    [']'] = {
      d = { '<cmd>lua vim.diagnostic.goto_next()<CR>', "Next diagnostic" },
    },
  }, { buffer = bufnr })

vim.diagnostic.config({
  virtual_text = true,  -- Показывает ошибки в тексте
  signs = true,         -- Значки на полях
  update_in_insert = false,
})

-- Общая функция для keymaps
local on_attach = function(client, bufnr)
  -- Опции для буферных keymaps
  local opts = { buffer = bufnr }

  -- Сначала регистрируем все LSP keymaps
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
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format({ async = true })
  end, opts)

  -- Диагностика
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
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
              "+xiva/sms_feedback",
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

lsp.pylsp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = true,
                    maxLineLength = 120,
                },
                pylint = {
                    enabled = true,
                },
                autopep8 = {
                    enabled = false,  -- если используете black
                },
                black = {
                    enabled = true,
                    line_length = 120,
                },
                mypy = { enabled = true },
            },
        },
    },
})


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
