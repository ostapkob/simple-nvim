local M = {}

function M.setup()
	-- Проверка, что neo-tree доступен
	local ok, neotree = pcall(require, "neo-tree")
	if not ok then
		vim.notify("neo-tree not found!", vim.log.levels.ERROR, { title = "Plugin Error" })
		return
	end

	neotree.setup({
		-- Настройки окна
		window = {
			position = "left",
			width = 25,
			mappings = {
				["/"] = "noop", -- отключаем поиск по умолчанию
				[","] = "fuzzy_finder", -- ',' открывает fuzzy finder
				["u"] = "navigate_up", -- 'u' также будет подниматься на уровень вверх
			},
		},

		-- Дополнительные настройки (по желанию)
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = true,
				hide_by_name = { "node_modules", "__pycache__" },
			},
			follow_current_file = {
				enabled = true, -- Теперь это должно быть внутри таблицы с ключом enabled
			},
			use_libuv_file_watcher = true,
		},

		defaults = {
			indent = {
				width = 2,
				padding = 1,
			},
		},
	})
end

return M
