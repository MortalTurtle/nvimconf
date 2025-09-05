-- ~/.config/nvim/lua/plugins/init.lua
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
   {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python", "json", "bash", "cpp", "c", "go", "java"},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
  -- Статусная строка
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          icons_enabled = true,
          component_separators = "|",
          section_separators = "",
        },
      })
    end,
  },
  -- Search
  { 'nvim-telescope/telescope.nvim' },
  -- interface & UX
  {
    'ojroques/nvim-osc52',
    config = function()
      require('osc52').setup({
        -- Опциональные настройки:
        silent = false,  -- Не показывать подтверждение копирования
        trim = true,     -- Обрезать пробелы в начале/конце
      })
    end
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    config = function()
      require('nvim-web-devicons').setup()
    end,
  },
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" },},
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup()
      vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>')
    end
  },
  {
    "folke/which-key.nvim", event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
  --debug
  {"mfussenegger/nvim-dap"},
  {"rcarriga/nvim-dap-ui"},
  {"theHamsta/nvim-dap-virtual-text"},
  --lsp
  { "neovim/nvim-lspconfig" },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP-источник
      "hrsh7th/cmp-buffer",       -- Дополнение из буфера
      "hrsh7th/cmp-path",         -- Дополнение путей
      "hrsh7th/cmp-cmdline",      -- Дополнение команд
      "L3MON4D3/LuaSnip",         -- Snippets-движок
      "saadparwaiz1/cmp_luasnip", -- Интеграция LuaSnip с cmp
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'nvim_lua' },  -- Для Lua API Neovim
          { name = 'calc' },      -- Математические вычисления
          { name = 'emoji' },     -- Подсказки emoji
          { name = 'treesitter' },-- Использование treesitter
          { name = 'vim-dadbod-completion' },  -- Для SQL
        }),
        experimental = {
          ghost_text = true,  -- Показывать подсказку прямо в тексте
        },
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    events= "VeryLazy",
  },
  --colorthemes
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({})
    end,
  },
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        style = 'warmer'
      }
      -- Enable theme
      require('onedark').load()
    end
  },
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  git = {
    enable = true, -- подсветка изменений Git
    ignore = false,
  },
})

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
vim.keymap.set('n', '<C-r', ':NvimTreeRefresh<CR>', { desc = 'Refresh file tree' })
vim.keymap.set('n', '<C-f>', ':NvimTreeFindFile<CR>', { desc = 'Find current file in tree' })

--Автоматическое закрытие Neovim, если осталось только дерево:
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd "quit"
    end
  end
})

require("plugins.lsp")
--require("bufferline").setup{}

vim.keymap.set('n', '<leader>y', require('osc52').copy_operator, { expr = true })
vim.keymap.set('n', '<leader>yy', '<leader>y_', { remap = true })
vim.keymap.set('v', '<leader>y', require('osc52').copy_visual)
