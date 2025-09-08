local M = {}

function M.setup()
	local ok, cmp = pcall(require, "blink.cmp")
	if not ok then
		vim.notify("blink.cmp not found!", vim.log.levels.ERROR, { title = "Plugin Error" })
		return
	end

	cmp.setup({
		fuzzy = {
			implementation = "lua", -- Использует Lua-реализацию для нечеткого поиска
		},
		enabled = function()
			-- Включает автодополнение только в нормальном и визуальном режимах
			return vim.api.nvim_get_mode().mode ~= "c" and vim.api.nvim_get_mode().mode ~= "t"
		end,
		cmdline = {
			enabled = false, -- Отключает автодополнение в командной строке
		},
		completion = {
			keyword = {
				range = "full", -- Полный диапазон для ключевых слов
			},
			accept = {
				auto_brackets = {
					enabled = false, -- Отключает автоматическое добавление скобок
				},
			},
			list = {
				selection = {
					preselect = false, -- Отключает предварительный выбор элементов
				},
			},
			menu = {
				auto_show = true, -- Автоматически показывает меню дополнений
			},
			documentation = {
				auto_show = true, -- Автоматически показывает документацию
				auto_show_delay_ms = 500, -- Задержка перед показом документации (500 мс)
			},
			ghost_text = {
				enabled = true, -- Включает "призрачный текст" предварительного просмотра
			},
		},
		sources = {
			default = {
				"lsp", -- Источник: Language Server Protocol
				"path", -- Источник: пути к файлам
				"snippets", -- Источник: сниппеты
				"buffer", -- Источник: содержимое буфера
			},
			-- Примечание: источники обрабатываются в порядке их указания
			-- postgres_lsp будет использоваться через LSP источник
		},
		snippets = {
			preset = "default", -- Использует настройки сниппетов по умолчанию
		},
		signature = {
			enabled = true, -- Включает подсказки по сигнатурам функций
		},
	})
end

return M
