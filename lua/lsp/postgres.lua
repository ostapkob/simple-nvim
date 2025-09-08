-- lsp/postgres.lua
local M = {}

function M.setup()
	local ok, lspconfig = pcall(require, "lspconfig")
	if not ok then
		vim.notify("lspconfig not found!", vim.log.levels.ERROR, { title = "Plugin Error" })
		return
	end

	-- Проверяем, доступен ли postgrestools
	if vim.fn.executable("postgrestools") == 0 then
		vim.notify("postgrestools not found in PATH!", vim.log.levels.WARN, { title = "PostgresTools" })
		return
	end

	-- Настройка postgres_lsp
	lspconfig.postgres_lsp.setup({
		cmd = { "postgrestools", "lsp-proxy" },
		filetypes = { "sql", "pgsql" },
		root_dir = function(fname)
			-- Ищем корневой директорий по маркерам
			local util = lspconfig.util
			return util.root_pattern("postgrestools.jsonc", ".git")(fname) or util.path.dirname(fname)
		end,
		on_attach = function(client, bufnr)
			-- Общие LSP привязки
			local opts = { noremap = true, silent = true }
			vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
			vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
			vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

			-- Специфичные для SQL привязки
			vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rr", "<cmd>lua vim.lsp.buf.execute()<CR>", opts)
		end,
		settings = {
			-- Дополнительные настройки для postgres_lsp
			postgres = {
				connections = vim.g.dbs, -- Используем ваши predefined соединения
			},
		},
	})
end

return M
