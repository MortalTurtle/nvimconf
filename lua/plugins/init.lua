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
				PATH = "append",
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
				silent = false,
				trim = true,
			})
		end,
	},
	-- Mason интеграция с LSP (все еще нужна для установки серверов)
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
					"lua_ls",
				},
				automatic_installation = true,
				handlers = {},
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
	-- SchemaStore для JSON схем
	{
		"b0o/SchemaStore.nvim",
		lazy = true,
	},
	-- Search
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
		}
	},
	-- LSP completion
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
						{ "filename", path = 1 },
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
		opts = {},
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
	--lsp utils
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.trailspace").setup()
			require("mini.misc").setup()
			require("mini.comment").setup()
			require("mini.surround").setup({
				mappings = {
					add = "gsa",
					delete = "gsd",
					replace = "gsr",
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
	-- Git signs в стиле VSCode
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = function()
			require("gitsigns").setup({
				signs                   = {
					add          = { text = "▎" },
					change       = { text = "▎" },
					delete       = { text = "▎" },
					topdelete    = { text = "▎" },
					changedelete = { text = "▎" },
				},
				signcolumn              = true,
				numhl                   = true,
				linehl                  = false,
				current_line_blame      = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 500,
				},
			})
		end,
	},
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
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
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
					{ name = "nvim_lua" },
					{ name = "calc" },
					{ name = "emoji" },
				}),
				experimental = {
					ghost_text = true,
				},
			})
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
		enable = true,
		ignore = false,
	},
	hijack_cursor = false,
	respect_buf_cwd = true,
})

vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<C-r", ":NvimTreeRefresh<CR>", { desc = "Refresh file tree" })
vim.keymap.set("n", "<C-f>", ":NvimTreeFindFile<CR>", { desc = "Find current file in tree" })

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
		mode = "buffers",
		numbers = "none",
		close_command = "bdelete! %d",
		right_mouse_command = "bdelete! %d",
		left_mouse_command = "buffer %d",
		middle_mouse_command = nil,
		indicator = {
			icon = "▎",
			style = "underline",
		},
		modified_icon = "●",
		left_trunc_marker = "",
		right_trunc_marker = "",
		name_formatter = function(buf)
			return buf.name
		end,
		max_name_length = 18,
		max_prefix_length = 15,
		truncate_names = true,
		tab_size = 18,
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
			},
		},
		color_icons = true,
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		persist_buffer_sort = true,
		separator_style = "thick",
		enforce_regular_tabs = false,
		always_show_bufferline = true,
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

vim.keymap.set('n', '<leader>ct', function()
	if _G.toggle_colorscheme then
		_G.toggle_colorscheme()
	else
		-- Fallback если функция не загружена
		local current_theme = vim.g.colors_name
		if current_theme == "onedark" then
			vim.cmd("colorscheme github_dark")
		else
			vim.cmd("colorscheme onedark")
		end
		vim.notify("Colorscheme: " .. vim.g.colors_name)
	end
end, { desc = "Toggle color scheme" })

vim.keymap.set("n", "<leader>oy", require("osc52").copy_operator, { expr = true })
vim.keymap.set("n", "<leader>oyy", "<leader>y_", { remap = true })
vim.keymap.set("v", "<leader>oy", require("osc52").copy_visual)
