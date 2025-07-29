local vim = vim or {}
local opt = vim.opt

-- 1. Базовые настройки Neovim -------------------------------------------------
opt.number = true          -- Показывать номера строк
opt.relativenumber = true  -- Относительная нумерация строк
opt.signcolumn = "yes"     -- Всегда показывать колонку знаков (для диагностики)
opt.termguicolors = true   -- Использовать true-color
opt.wrap = false           -- Не переносить длинные строки
opt.tabstop = 4            -- Ширина табуляции = 4 пробела
opt.swapfile = false       -- Отключить создание swap-файлов
opt.winblend = 0           -- Прозрачность окон (0-100)
opt.pumblend = 0           -- Прозрачность автодополнения
--opt.clipboard = "unnamedplus" -- Использовать системный буфер обмена
opt.completeopt = "menuone,noselect" -- Улучшенное поведение дополнения
opt.mouse = "a" --Включит мышь
opt.encoding = "utf-8" --Кодировка
opt.swapfile = true --создаем свап файлы
opt.showcmd = true --Отображение команд
opt.showmode = false --не показывать режим

-- redundancy1
opt.undofile = true --  keep undo history between sessions
opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo/" -- keep undo files out of file dir
opt.directory = os.getenv("HOME") .. "/.local/share/nvim/swp/" -- keep unsaved changes away from file dir
opt.backupdir = os.getenv("HOME") .. "/.local/share/nvim/backup/" -- backups also should not go to git
opt.keywordprg = ":help" -- key 'K'

vim.g.have_nerd_font = false
-- "vim.cmd([[ filetype indent plugin on syntax enable ]])
vim.opt.filetype = 'on'       -- Включает определение типа файла
vim.opt.syntax = 'enable'     -- Включает подсветку
vim.g.do_filetype_lua = 1     -- Включает Lua-обработчик типов файлов (Neovim 0.7+)


opt.laststatus = 3
opt.splitkeep = "screen"


opt.expandtab = true 
opt.smartindent = true
--opt.shiftwidth = 4 --Смещаем на 4 пробела
opt.iskeyword:append("-") -- consider string-string as whole word
opt.breakindent = true -- Включает автоматический перенос строк с отступом
opt.scrolloff = 3 -- Устанавливает минимальное количество строк, которые должны оставаться видимыми над и под курсором

-- Включает отображение специальных символов для пробелов и табуляций.
-- Настраивает символы для отображения табуляций, пробелов в конце строки и неразрывных пробелов.
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

opt.splitright = true -- Открывает новые вертикальные сплиты справа от текущего окна.
opt.splitbelow = true -- Открывает новые горизонтальные сплиты ниже текущего окна.
opt.so = 5 --Отступ курсора от края экрана
opt.foldcolumn = "1" --Ширина колонки для фолдов
-- opt.colorcolumn =  '120'     --Расположение цветной колонки

opt.cursorline = true -- Подсветка строки с курсором
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.ignorecase = true -- Игнорирует регистр при поиске, что упрощает поиск.
opt.smartcase = true -- Учитывает регистр, если в поисковом запросе есть заглавные буквы.
opt.updatetime = 250 -- миллисекуны для обновления событий, таких как автосохранение и отображение изменений.
--opt.timeoutlen = 250 -- миллисекуны для ожидания последовательности клавиш (например, для сочетаний клавиш).


-- Включает режим интерактивной команды, который показывает результаты команды замены в новом сплите.
opt.inccommand = "split"

-- don't auto commenting new lines
vim.cmd([[ au BufEnter * set fo-=c fo-=r fo-=o ]])

-- remove line lenght marker for selected filetypes
vim.cmd([[ autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0 ]])

-- С этой строкой отлично форматирует html файл, который содержит jinja2
vim.cmd([[ autocmd BufNewFile,BufRead *.html set filetype=htmldjango ]])

-- vim.opt.signcolumn = 'yes' -- Всегда отображает колонку для знаков
-- Компактный вид у тагбара и Отк. сортировка по имени у тагбара
vim.g.tagbar_compact = 1
vim.g.tagbar_sort = 0


-- Устанавливает 2 пробела для выбранных типов файлов
-- vim.cmd( [[ autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml,yml,html,jinja,conf setlocal shiftwidth=2 tabstop=2 ]])
local filetype_group = vim.api.nvim_create_augroup("SetSpacesForFiletypes", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = filetype_group,
    pattern = { "xml", "html", "xhtml", "css", "scss", "javascript", "lua", "yaml", "yml", "jinja", "conf" },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end,
})

-- Подсвечивает на доли секунды скопированную часть текста
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = highlight_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
    end,
})


--save sesion 11
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
		vim.cmd("mksession! ~/.local/share/nvim/session.vim")
	end,
})
