vim.g.mapleader = " "
vim.g.maplocalleader = " "

local vim = vim or {}
local keymap = vim.keymap -- for conciseness

local default_opts = { noremap = true, silent = false }
-- noremap = true - исключить рекурсию
-- silent - не будет выводить сообщения в командную строку.

-- Функциональные клавиши --------------------------------------------------
keymap.set("n", "<F2>", vim.cmd.TagbarToggle) -- Показ дерева классов и функций, плагин majutsushi/tagbar
keymap.set('n', '<F3>', function()
    require("neo-tree.command").execute({ toggle = true, dir = vim.fn.getcwd() })
    end, { desc = "Toggle Neo-tree file explorer",  silent = true })
keymap.set("n", "<F6>", function() require("alpha").start() end, { desc = "Open dashboard", silent = true })
keymap.set("n", "<F7>", '<cmd>exec &nu==&rnu? "se nu!" : "se rnu!"<CR>')
keymap.set("n", "<F8>", vim.cmd.DBUIToggle)
keymap.set("n", "<F9>", vim.cmd.UndotreeToggle)

keymap.set("i", "jf", "<Esc>", default_opts)
keymap.set("i", "оа", "<Esc>", default_opts)

keymap.set('n', '<leader>o', ':update<CR>:source %<CR>', default_opts,  { desc = "Сохранить и перезагрузить конфиг" })

-- Работа с системным буфером обмена
keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y', { desc = "Копировать в системный буфер" })
keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d', { desc = "Вырезать в системный буфер" })
keymap.set({ 'n', 'v', 'x' }, '<leader>н', '"+y', { desc = "Копировать в системный буфер" })
keymap.set({ 'n', 'v', 'x' }, '<leader>в', '"+d', { desc = "Вырезать в системный буфер" })

-- Буферы
keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
keymap.set("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete Other Buffers" })
keymap.set("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- Перемещение к left, right, up, down через 'g'
keymap.set("n", "gh", "^", default_opts)
keymap.set("n", "gl", "$", default_opts)
keymap.set("v", "gh", "^", default_opts)
keymap.set("v", "gl", "$", default_opts)
keymap.set("n", "gj", "L", default_opts)
keymap.set("n", "gk", "H", default_opts)
keymap.set("v", "gj", "L", default_opts)
keymap.set("v", "gk", "H", default_opts)

-- tabs
keymap.set("n", "<leader>td", ":tabclose<CR>", default_opts) -- close current tab
keymap.set("n", "<leader>tp", ":tabp<CR>", default_opts) --  go to previous tab
keymap.set("n", "<leader>tn", ":tabn<CR>", default_opts) --  go to next tab

-- Изменение размера окна
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", default_opts, { desc = "Move Down" })
keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", default_opts, { desc = "Move Up" })
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", default_opts, { desc = "Move Down" })
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", default_opts, { desc = "Move Up" })
keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", default_opts, { desc = "Move Down" })
keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", default_opts, { desc = "Move Up" })

-- После отмены клавиша 'u' будет удалятся по разрывам ,.; 
keymap.set("i", ",", ",<c-g>u")
keymap.set("i", ".", ".<c-g>u")
keymap.set("i", ";", ";<c-g>u")

-- Ищет документацию для слова под курсором
keymap.set("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- Сохраняем выделение после сдвига
keymap.set("v", "<", "<gv", default_opts)
keymap.set("v", ">", ">gv", default_opts)

--Gi
keymap.set('n', '<leader>gb', '<cmd>Gitsigns blame<CR>', default_opts, { desc = "git blame" } )
keymap.set('n', '<leader>gd', '<cmd>Gitsigns diffthis<CR>', default_opts, { desc = "git diff" } )

-- SQL
keymap.set("n", ",s", "mzvip:DB<CR>'z", default_opts, { desc = "Run Query",  })
keymap.set("v", ",s", ":DB<CR>", default_opts,{ desc = "Run Query", })

-- Telescope
keymap.set('n', '<leader>s', '<Nop>', { desc = "[S]earch" })  -- Заглушка для группы
keymap.set('n', '<leader>ss', '<cmd>Telescope builtin<CR>', { desc = "[S]earch [S]elect Telescope" })
keymap.set('n', '<leader>sh', '<cmd>Telescope help_tags<CR>', { desc = "[S]earch [H]elp" })
keymap.set('n', '<leader>sk', '<cmd>Telescope keymaps<CR>', { desc = "[S]earch [K]eymaps" })
keymap.set('n', '<leader>sf', '<cmd>Telescope find_files<CR>', { desc = "[S]earch [F]iles" })
keymap.set('n', '<leader>sw', '<cmd>Telescope grep_string<CR>', { desc = "[S]earch current [W]ord" })
keymap.set('n', '<leader>sg', '<cmd>Telescope live_grep<CR>', { desc = "[S]earch by [G]rep" })
keymap.set('n', '<leader>sr', '<cmd>Telescope resume<CR>', { desc = "[S]earch [R]esume" })
keymap.set('n', '<leader>s.', '<cmd>Telescope oldfiles<CR>', { desc = '[S]earch Recent Files ("." for repeat)' })
keymap.set('n', '<leader>,', '<cmd>Telescope buffers<CR>', { desc = "[ ] Find existing buffers" })
-- keymap.set('n', '<leader>sd', '<cmd>Telescope diagnostics<CR>', { desc = "[S]earch [D]iagnostics" })


--Replace
keymap.set('v', '<C-r>', function()
    -- Сохраняем выделенный текст в регистр
    vim.cmd('noautocmd normal! "zy')
    
    -- Формируем команду замены
    local text = vim.fn.getreg('z')
    local escaped = vim.fn.escape(text, '/\\')
    
    -- Запускаем команду с перемещением курсора
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(
            '<Esc>:%s/' .. escaped .. '//gc<Left><Left><Left>',
            true,
            false,
            true
        ),
        'n',
        true
    )
end, default_opts, {desc = "Global replace selected text" })

-- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
    print('venn')
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.api.nvim_buf_del_keymap(0, "n", "J")
        vim.api.nvim_buf_del_keymap(0, "n", "K")
        vim.api.nvim_buf_del_keymap(0, "n", "L")
        vim.api.nvim_buf_del_keymap(0, "n", "H")
        vim.api.nvim_buf_del_keymap(0, "v", "f")
        vim.b.venn_enabled = nil
    end
end
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})


--with Tmux plugin no need
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

