local plugins_path = os.getenv("NVIM_PLUGINS_PATH")
if plugins_path then
	--print('Simple-Nvim plugins path: '..plugins_path)
else
	print("Переменная окружения NVIM_PLUGINS_PATH не найдена.")
end

local function load_plugins(path)
	if vim.fn.isdirectory(path) ~= 1 then
		return
	end
	for _, plugin in ipairs(vim.fn.readdir(path)) do
		local p = path .. "/" .. plugin
		if vim.fn.isdirectory(p) == 1 then
			vim.opt.runtimepath:append(p)
		end
	end
end
load_plugins(plugins_path)

vim.cmd("colorscheme kanagawa-wave")
require("configs")

require("bufferline").setup()
require("ibl").setup()
require("lualine").setup()
require("noice").setup()
require("gitsigns").setup()
require("trouble").setup()
-- require('null-ls').setup()

--Здесь подключаем из папки plugins
require("plugins.alpha").setup()
require("plugins.neo-tree").setup()
require("plugins.lsp").setup()
require("plugins.blink-cmp").setup()
require("plugins.null-ls").setup()
require("plugins.lualine").setup()

-- Автоматическое определение SQL файлов и подключение LSP
vim.api.nvim_create_autocmd("FileType", {
	pattern = "sql",
	callback = function()
		-- Включаем LSP для SQL файлов
		vim.lsp.enable("postgres_lsp")

		-- Дополнительные настройки для SQL буферов
		vim.bo.expandtab = true
		vim.bo.shiftwidth = 2
		vim.bo.tabstop = 2
	end,
})
