-- Доступные источники можно посмотреть тут:
-- print(package.loaded["plugin_name"])
-- :NullLsInfo
-- :set filetype?
-- pip install pylint
-- pip install ansible-lint
-- pip install black
-- pip install pyrigh
-- cargo install stylua
--
-- oscd LuaLS/lua-language-server
-- find . -type f -exec sed -i 's/github.com/sberosc.ru/g' {} +\
-- ./make.sh

-- mkdir -p ~/.local/npm-packages
-- npm install --prefix ~/.local/npm-packages npm-groovy-lint
-- echo 'export PATH=~/.local/npm-packages/node_modules/.bin:$PATH' >> ~/.bashrc
-- install java 17

local M = {}

function M.setup()
	local ok, null_ls = pcall(require, "null-ls")
	if not ok then
		vim.notify("null-ls not found!", vim.log.levels.ERROR, { title = "Plugin Error" })
		return
	end

	null_ls.setup({
		timeout = 10000, -- Увеличьте общий таймаут
		sources = {
			-- Форматирование
			null_ls.builtins.formatting.black.with({
				extra_args = { "--fast" },
			}),
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.npm_groovy_lint.with({
				timeout = 15000, -- Специфичный таймаут для Groovy
				extra_args = { "--verbose" }, -- Для диагностики
			}),

			-- Линтинг
			null_ls.builtins.diagnostics.ansiblelint.with({
				filetypes = { "yaml", "yml" },
			}),
			null_ls.builtins.diagnostics.pylint.with({
				filetypes = { "python" },
			}),
			null_ls.builtins.diagnostics.npm_groovy_lint.with({
				timeout = 15000, -- Таймаут для линтинга Groovy
			}),
		},

		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ async = false })
					end,
				})
			end
		end,
	})
end

return M
