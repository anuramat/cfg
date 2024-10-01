return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = function()
    local harpoon = require('harpoon')
    local set = function(lhs, rhs, desc)
      vim.keymap.set('n', '<leader>h' .. lhs, rhs, { silent = true, desc = 'Harpoon: ' .. desc })
    end
   -- stylua: ignore start
    set('a', function() harpoon:list():add() end, 'Add')
    set('l', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, 'List')
    set('n', function() harpoon:list():next() end, 'Next')
    set('p', function() harpoon:list():prev() end, 'Previous')
    -- stylua: ignore end
    for i = 1, 9 do
      local si = tostring(i)
      set(si, function()
        harpoon:list():select(i)
      end, 'Go to #' .. si)
    end
  end,
}
