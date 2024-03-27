local u = require('utils')

local dap_status = {
  function()
    return '  ' .. require('dap').status()
  end,
  cond = function()
    return package.loaded['dap'] and require('dap').status() ~= ''
  end,
}
local diagnostics = { 'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } }
local git_branch = {
  'branch',
  icon = '󰊢',
  align = 'right',
  padding = { left = 1, right = 1 },
}
local function cwd_fn()
  local fullpath = vim.fn.getcwd()
  local home = vim.fn.getenv('HOME')
  return string.gsub(fullpath, '^' .. home, '~')
end

local cwd = {
  cwd_fn,
  padding = 1,
  separator = '',
}

local function layout_fn()
  local keymap = vim.o.keymap
  if keymap == '' then
    return ''
  end
  if vim.o.iminsert == 1 then
    return string.upper(keymap:sub(1, 2))
  else
    return 'EN'
  end
end

local layout = {
  layout_fn,
  padding = { left = 1, right = 1 },
}

local progress = {
  'progress',
  padding = { left = 1, right = 1 },
  separator = '',
}

local filename = {
  'filename',
  path = 1,
  symbols = { modified = '  ', readonly = '  ', unnamed = '' },
  separator = '',
  padding = { left = 1, right = 1 },
}

local tabs = {
  'tabs',
  mode = 0,
  use_mode_colors = true,
  show_modified_status = false,
}

local location = {
  'location',
  padding = { left = 1, right = 1 },
  fmt = u.trim,
  separator = '',
}

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    {
      'letieu/harpoon-lualine',
      dependencies = 'ThePrimeagen/harpoon',
    },
  },
  opts = function()
    vim.o.showmode = false
    return {
      options = {
        theme = vim.g.lualine_colorscheme,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        refresh = { statusline = 100, tabline = 100 },
      },
      extensions = { 'aerial', 'fugitive', 'lazy', 'man', 'neo-tree', 'nvim-dap-ui', 'oil', 'quickfix' },
      tabline = {
        lualine_a = { tabs },
        lualine_b = { 'harpoon2' },
        lualine_c = { filename, 'filetype', 'fileformat', 'encoding' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { layout },
      },
      sections = {
        lualine_a = {},
        lualine_b = { cwd, git_branch },
        lualine_c = { diagnostics },
        lualine_x = { dap_status },
        lualine_y = { location },
        lualine_z = { progress },
      },
    }
  end,
}
