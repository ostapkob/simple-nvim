local M = {}

function M.setup()
  local ok, neotree = pcall(require, "blink.cmp")
  if not ok then
    vim.notify("blink.cmp not found!", vim.log.levels.ERROR, { title = "Plugin Error" })
    return
  end

  local cmp = require('blink.cmp')
  cmp.setup({
  fuzzy = {
        implementation = "lua"
  },
  enabled = function()
    return vim.api.nvim_get_mode().mode ~= "c" and vim.api.nvim_get_mode().mode ~= "t"
  end,
  cmdline = {
    enabled = false,
  },
  completion = {
    keyword = {
      range = 'full',
    },
    accept = {
      auto_brackets = {
        enabled = false,
      },
    },
    list = {
      selection = {
        preselect = false,
      },
    },
    menu = {
      auto_show = true,
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },
    ghost_text = {
      enabled = true,
    },
  },
  sources = {
    default = {
      'lsp',
      'path',
      'snippets',
      'buffer',
    },
  },
  snippets = {
    preset = 'default',
  },
  signature = {
    enabled = true,
  },
})
end

return M
