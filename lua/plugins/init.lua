-- ~/.config/nvim/lua/plugins/init.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Mason - менеджер LSP, DAP, линтеров и форматтеров
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"ojroques/nvim-osc52",
		config = function()
			require("osc52").setup({
				silent = false, -- Не показывать подтверждение копирования
				trim = true, -- Обрезать пробелы в начале/конце
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"pylsp",
					"gopls",
					"clangd",
					"sqls",
					"yamlls",
					"jsonls",
					"bashls",
					"dockerls",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "codelldb", "delve" },
				automatic_installation = true,
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"prettier",
					"stylua",
					"black",
					"pylint",
					"eslint_d",
					"sqlfluff",
					"clang-format",
					"cppcheck",
					"yamllint",
					"yamlfmt",
					"jsonlint",
					"jq",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "python", "json", "bash", "cpp", "c", "go", "java" },
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
	{
		"b0o/SchemaStore.nvim",
		lazy = true,
	},
	-- Search - ДОБАВЛЕН Telescope И ЕГО ЗАВИСИМОСТИ
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		}
	},
	-- LSP completion - ДОБАВЛЕН cmp_nvim_lsp
	{
		"hrsh7th/cmp-nvim-lsp",
		dependencies = "hrsh7th/nvim-cmp"
	},
	-- Статусная строка
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				sections = {
					lualine_c = {
						{ "filename", path = 1 }, -- 1 = относительный путь, 2 = абсолютный, 3 = только имя
					},
					lualine_x = { "encoding", "filetype" },
				},
				options = {
					theme = "auto",
					icons_enabled = true,
					component_separators = "|",
					section_separators = "",
				},
			})
		end,
	},
	-- interface & UX
	{
		"NMAC427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup({})
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},
	{ "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup()
			vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>")
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
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
	{ "windwp/nvim-autopairs",   event = "InsertEnter",                           config = true },
	--debug
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			require("dapui").setup()
		end,
	},
	{
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup()
		end,
	},
	--lsp
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.trailspace").setup()
			require("mini.misc").setup() -- включает автоформатирование EOF
			require("mini.comment").setup()
			require("mini.surround").setup({
				mappings = {
					add = "gsa", -- Добавить окружение (в визуальном режиме)
					delete = "gsd", -- Удалить окружение
					replace = "gsr", -- Заменить окружение
				},
			})
		end,
	},
	{
		"Aietes/esp32.nvim",
		lazy = false,
		config = function()
        require("esp32").setup({
            build_dir = "build.clang",
        })
    	end,
	},
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
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-emoji",
			"ray-x/cmp-treesitter",
			"hrsh7th/cmp-nvim-lsp", -- LSP-источник
			"hrsh7th/cmp-buffer", -- Дополнение из буфера
			"hrsh7th/cmp-path", -- Дополнение путей
			"hrsh7th/cmp-cmdline", -- Дополнение команд
			"L3MON4D3/LuaSnip", -- Snippets-движок
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
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "nvim_lua" }, -- Для Lua API Neovim
					{ name = "calc" },   -- Математические вычисления
					{ name = "emoji" },  -- Подсказки emoji
					{ name = "treesitter" }, -- Использование treesitter
					{ name = "vim-dadbod-completion" }, -- Для SQL
				}),
				experimental = {
					ghost_text = true, -- Показывать подсказку прямо в тексте
				},
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
		end,
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
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "warmer",
			})
			-- Enable theme
			require("onedark").load()
		end,
	},
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = false,
		width = 30,
		preserve_window_proportions = false,
	},
	renderer = {
		group_empty = true,
	},
	git = {
		enable = true, -- подсветка изменений Git
		ignore = false,
	},
	hijack_cursor = false,
	respect_buf_cwd = true,
})

vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<C-r", ":NvimTreeRefresh<CR>", { desc = "Refresh file tree" })
vim.keymap.set("n", "<C-f>", ":NvimTreeFindFile<CR>", { desc = "Find current file in tree" })

--Автоматическое закрытие Neovim, если осталось только дерево:
vim.api.nvim_create_autocmd("BufEnter", {
	nested = true,
	callback = function()
		if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
			vim.cmd("quit")
		end
	end,
})

require("plugins.lsp")
require("plugins.dap")
require("bufferline").setup({
	options = {
		mode = "buffers", -- или "tabs" (режим вкладок вместо буферов)
		numbers = "none", -- "none" | "ordinal" | "buffer_id" | "both"
		close_command = "bdelete! %d", -- команда для закрытия буфера
		right_mouse_command = "bdelete! %d", -- действие по ПКМ
		left_mouse_command = "buffer %d", -- действие по ЛКМ
		middle_mouse_command = nil, -- действие по СКМ
		indicator = {
			icon = "▎", -- индикатор текущего буфера
			style = "underline", -- или "icon" | "none"
		},
		modified_icon = "●", -- иконка изменённого буфера
		left_trunc_marker = "", -- маркер обрезанного списка слева
		right_trunc_marker = "", -- маркер обрезанного списка справа
		name_formatter = function(buf) -- форматирование имени буфера
			return buf.name
		end,
		max_name_length = 18,           -- макс. длина имени буфера
		max_prefix_length = 15,         -- макс. длина префикса (для уникальных имён)
		truncate_names = true,          -- обрезать длинные имена
		tab_size = 18,                  -- ширина вкладки
		diagnostics = "nvim_lsp",       -- источник диагностики ("nvim_lsp" | "coc")
		diagnostics_update_in_insert = false, -- обновлять диагностику в режиме вставки
		offsets = {                     -- смещения для других элементов (например, NvimTree)
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
			},
		},
		color_icons = true,       -- раскрашивать иконки
		show_buffer_icons = true, -- показывать иконки буферов
		show_buffer_close_icons = true, -- показывать иконки закрытия
		show_close_icon = true,   -- показывать иконку закрытия всей панели
		show_tab_indicators = true, -- показывать индикаторы вкладок
		persist_buffer_sort = true, -- сохранять сортировку буферов
		separator_style = "thick", -- "slant" | "slope" | "thick" | "thin" | { "any", "any" }
		enforce_regular_tabs = false, -- выравнивать вкладки по размеру
		always_show_bufferline = true, -- всегда показывать bufferline
	},
})
vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Следующий буфер" })
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Предыдущий буфер" })
vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLinePick<CR>", { desc = "Выбрать буфер" })
vim.keymap.set(
	"n",
	"<leader>bc",
	"<Cmd>BufferLinePickClose<CR>",
	{ desc = "Закрыть выбранный буфер" }
)
vim.keymap.set("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Закрыть буферы слева" })
vim.keymap.set(
	"n",
	"<leader>br",
	"<Cmd>BufferLineCloseRight<CR>",
	{ desc = "Закрыть буферы справа" }
)

-- Переключение цветовых схем
vim.keymap.set('n', '<leader>ct', function()
	local current_theme = vim.g.colors_name
	if current_theme == "onedark" then
		vim.cmd("colorscheme github_dark")
	else
		vim.cmd("colorscheme onedark")
	end
	vim.notify("Colorscheme: " .. vim.g.colors_name)
end, { desc = "Toggle color scheme" })

vim.keymap.set("n", "<leader>oy", require("osc52").copy_operator, { expr = true })
vim.keymap.set("n", "<leader>oyy", "<leader>y_", { remap = true })
vim.keymap.set("v", "<leader>oy", require("osc52").copy_visual)
