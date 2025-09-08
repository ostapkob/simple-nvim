local M = {}

function M.setup()
	-- local lspconfig = require('lspconfig')
	local ok, lspconfig = pcall(require, "lspconfig")
	if not ok then
		vim.notify("lspconfig not found!", vim.log.levels.ERROR, { title = "Plugin Error" })
		return
	end

	lspconfig.pyright.setup({
		on_attach = function(client, bufnr)
			local opts = { noremap = true, silent = true }
			vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
			vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		end,
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
				},
			},
		},
	})
	require("lsp.postgres").setup()
end

return M
