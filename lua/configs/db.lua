local vim = vim or {}

-- vim.g.db_ui_save_location = "~/Sync/SQL_script"
--
vim.g.db_ui_save_location="~/Code/SQL"
local pass = os.getenv("PASS")
local user = os.getenv("USER")

vim.g.dbs = {
	{ name = "postgres", url = "postgres://postgres:postgres@127.0.0.1:5432/postgres" },
	{ name = "demo", url = "postgres://postgres:postgres@localhost:5432/demo" },
}
vim.g.db_async = 1 -- C-c in DB-UI

  -- -- Автокоманда для SQL файлов
  -- vim.api.nvim_create_autocmd("FileType", {
  --   pattern = "sql",
  --   callback = function()
  --     vim.opt_local.commentstring = "-- %s"
  --   end,
  --   desc = "Set SQL comment format"
  -- })
