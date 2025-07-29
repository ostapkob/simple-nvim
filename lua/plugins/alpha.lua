local M = {}

function M.setup()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  -- Заголовок
  dashboard.section.header.val = {
    "                                                                       ",
    "                                                                       ",
    "                                                                       ",
    "                      ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
    "                      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
    "                      ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
    "                      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
    "                      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
    "                      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
    "                                                                                                               "
  }




  -- Кнопки
  dashboard.section.buttons.val = {
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
    dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
    dashboard.button("s", "  Settings", ":e $MYVIMRC <CR>"),
    dashboard.button("q", "  Quit", ":qa<CR>"),
  }

  -- Подсветка
  dashboard.section.footer.opts.hl = "Constant"
  dashboard.section.header.opts.hl = "Function"
  dashboard.section.buttons.opts.hl = "Keyword"

  -- Настройка alpha
  alpha.setup(dashboard.opts)

  -- Авто: скрыть статусбар на alpha
  vim.api.nvim_create_autocmd("User", {
    pattern = "AlphaReady",
    callback = function()
      vim.cmd([[
        set showtabline=0 | set laststatus=0 | set cmdheight=0
        autocmd BufUnload <buffer> set showtabline=2 | set laststatus=3 | set cmdheight=1
      ]])
    end,
  })
end

return M
