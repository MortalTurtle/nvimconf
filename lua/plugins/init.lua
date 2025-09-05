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
  { 'nvim-treesitter/nvim-treesitter' },
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
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
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
    "nvimtools/none-ls.nvim",
    events= "VeryLazy",
  },
  --colorthemes
  { 'projekt0n/github-nvim-theme', name = 'github-theme' },
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
