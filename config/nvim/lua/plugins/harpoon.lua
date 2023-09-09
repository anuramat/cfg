local specs = {}
local u = require('utils')

local function get_num_mappings()
  local res = {}
  for i = 1, 9 do
    res[i] = {
      tostring(i),
      function()
        require('harpoon.ui').nav_file(i)
      end,
      desc = 'Harpoon #' .. tostring(i),
    }
  end
  return res
end

specs.harpoon = {
  'ThePrimeagen/harpoon',
  event = 'VeryLazy', -- load early cause tabline
  -- TODO add terminal keys
  keys = u.prefix('<leader>h', {
    {
      'a',
      function()
        require('harpoon.mark').add_file()
      end,
      desc = 'Harpoon this file',
    },
    {
      'l',
      function()
        require('harpoon.ui').toggle_quick_menu()
      end,
      desc = 'List Harpoons',
    },
    {
      'p',
      function()
        require('harpoon.ui').nav_prev()
      end,
      desc = 'Prev Harpoon',
    },
    {
      'n',
      function()
        require('harpoon.ui').nav_next()
      end,
      desc = 'Next Harpoon',
    },
    unpack(get_num_mappings()),
  }),
  dependencies = {
    'nvim-lua/plenary.nvim',
    'Mofiqul/dracula.nvim',
  },
  opts = function()
    local cs = require('dracula').colors()
    local on = { fg = cs.black, bg = cs.purple, bold = true }
    local off = { fg = cs.fg, bg = cs.visual, bold = true }

    vim.api.nvim_set_hl(0, 'HarpoonNumberActive', on)
    vim.api.nvim_set_hl(0, 'HarpoonActive', on)

    vim.api.nvim_set_hl(0, 'HarpoonNumberInactive', off)
    vim.api.nvim_set_hl(0, 'HarpoonInactive', off)
    -- vim.api.nvim_set_hl(0, 'TabLineFill', off)

    return {
      tabline_prefix = ' ',
      tabline_suffix = ' ',
      menu = {
        width = 80,
      },
    }
  end,
}

return u.values(specs)
