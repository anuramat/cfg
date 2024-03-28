local u = require('utils')

local error_color = 'ErrorMsg'

local custom_plugins = { 'alpha' }

local function custom_cond()
  return not u.contains(custom_plugins, vim.o.filetype)
end

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
  cond = custom_cond,
}

local filename = {
  'filename',
  path = 1,
  newfile_status = true,
  symbols = { modified = '[modified]', readonly = '[read-only]', unnamed = '[no name]', newfile = '[new]' },
  separator = '',
  cond = custom_cond,
  padding = { left = 1, right = 1 },
}

local filetype = {
  'filetype',
  cond = custom_cond,
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
  cond = custom_cond,
}

local encoding = {
  function()
    if vim.o.fileencoding ~= 'utf-8' then
      return vim.o.fileencoding
    end
    return ''
  end,
  color = error_color,
}

local fileformat = {
  'fileformat',
  symbols = { unix = '' },
  color = error_color,
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
        lualine_a = { cwd, git_branch },
        lualine_b = { tabs },
        lualine_c = { 'harpoon2' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { layout },
      },
      sections = {
        lualine_a = { filename },
        lualine_b = { filetype },
        lualine_c = { encoding, fileformat, diagnostics },
        lualine_x = { dap_status },
        lualine_y = { location },
        lualine_z = { progress },
      },
    }
  end,
}
