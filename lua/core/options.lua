vim.opt.number = true
vim.opt.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.termguicolors = true
vim.o.mouse = "a"
vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.list = true
vim.o.confirm = true
vim.bo.fixendofline = true -- Исправляет отсутствие EOF при сохранении

vim.api.nvim_create_autocmd("FileType", {
	pattern = "make",
	callback = function()
		vim.bo.expandtab = false
		vim.bo.tabstop = 8     -- Стандарт для Makefile
		vim.bo.shiftwidth = 8
	end,
})
