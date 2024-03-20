return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  -- event = 'VeryLazy',
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
}
