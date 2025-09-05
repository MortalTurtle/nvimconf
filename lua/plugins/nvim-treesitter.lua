return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'p00f/nvim-ts-rainbow',  -- Радужные скобки
      'RRethy/nvim-treesitter-endwise',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'Badhi/nvim-treesitter-cpp-tools',
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'c', 'cpp', 'cmake', 'python', 'lua', 'rust', 'go',
          'javascript', 'typescript', 'bash', 'comment'
        },

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          custom_captures = {
            ['cpp.parameter'] = 'TSParameter',
            ['cpp.template.parameter'] = 'TSType',
          },
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },

        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['aC'] = '@class.outer',
              ['iC'] = '@class.inner',
              ['aT'] = '@template.outer',
              ['aS'] = '@scope.outer',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
          },
        },

        -- Настройки радужных скобок
        rainbow = {
          enable = true,
          extended_mode = true,  -- Работает и с HTML-тегами
          max_file_lines = 1000,  -- Максимальное количество строк для обработки
          colors = {
            '#ffd700',  -- золотой
            '#da70d6',  -- орхидея
            '#179fff',  -- голубой
            -- Дополнительные цвета (если нужно больше уровней вложенности):
            '#98ff98',  -- мятный
            '#ff6347',  -- томатный
            '#9370db',  -- пурпурный
          },
          termcolors = {
            'brown',
            'Darkblue',
            'lightgray',
            'cyan',
            'magenta',
            'yellow',
            'white'
          }
        },

        endwise = { enable = true },
        require('ts_context_commentstring').setup {},
      })

       -- Специальные настройки для C++
      require('nt-cpp-tools').setup({
        preview = {
          quit = 'q',  -- Закрытие превью
          accept = '<CR>'  -- Принять вариант
        },
        header_extension = 'h',  -- Расширение для заголовочных файлов
        source_extension = 'cpp',  -- Расширение для исходников
      })

      -- Дополнительные стили для C++
      vim.api.nvim_set_hl(0, '@cpp.template', { link = 'Type' })
      vim.api.nvim_set_hl(0, '@cpp.namespace', { fg = '#569CD6', italic = true })
      vim.api.nvim_set_hl(0, '@cpp.operator', { fg = '#D4D4D4', bold = true })
    end
  },

  -- Оставляем только один плагин для подсветки C++
  {
    'bfrg/vim-cpp-modern',
    ft = { 'cpp', 'c', 'h', 'hpp' },
    config = function()
      vim.g.cpp_attributes_highlight = 1
      vim.g.cpp_member_highlight = 1
      vim.g.cpp_simple_highlight = 1
    end
  },

  -- Добавляем LSP и автодополнение
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = { 'clangd' }
      })

      require('lspconfig').clangd.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--all-scopes-completion",
          "--cross-file-rename"
        },
      })
    end
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
    },
    config = function()
      require('cmp').setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
        },
        mapping = require('cmp').mapping.preset.insert({
          ['<C-Space>'] = require('cmp').mapping.complete(),
          ['<CR>'] = require('cmp').mapping.confirm({ select = true }),
        }),
      })
    end
  }
}
