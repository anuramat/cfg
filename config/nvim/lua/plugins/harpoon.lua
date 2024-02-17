local specs = {}
local u = require('utils')

specs.harpoon = {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'Mofiqul/dracula.nvim',
  },
  opts = function()
    local harpoon = require('harpoon')
    local set = function(lhs, rhs, desc)
      vim.keymap.set('n', '<leader>h' .. lhs, rhs, { silent = true, desc = desc })
    end
   -- stylua: ignore start
    set('a', function() harpoon:list():append() end, 'Harpoon this file')
    set('l', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, 'List Harpoons')
    set('n', function() harpoon:list():next() end, 'Next Harpoon')
    set('p', function() harpoon:list():prev() end, 'Prev Harpoon')
    -- stylua: ignore end
    for i = 1, 9 do
      local si = tostring(i)
      set(si, function()
        harpoon:list():select(i)
      end, 'Go to Harpoon #' .. si)
    end
  end,
  -- opts = function()
  --   local cs = require('dracula').colors()
  --   local on = { fg = cs.black, bg = cs.purple, bold = true }
  --   local off = { fg = cs.fg, bg = cs.visual, bold = true }
  --
  --   vim.api.nvim_set_hl(0, 'HarpoonNumberActive', on)
  --   vim.api.nvim_set_hl(0, 'HarpoonActive', on)
  --
  --   vim.api.nvim_set_hl(0, 'HarpoonNumberInactive', off)
  --   vim.api.nvim_set_hl(0, 'HarpoonInactive', off)
  --   -- vim.api.nvim_set_hl(0, 'TabLineFill', off)
  --
  --   return {
  --     tabline_prefix = ' ',
  --     tabline_suffix = ' ',
  --     menu = {
  --       width = 80,
  --     },
  --   }
  -- end,
}

return u.values(specs)
