local specs = {}
local u = require('utils')

local make_harpoon = function(harpoon)
  return function()
    local contents = {}
    local marks_length = harpoon:list():length()
    local current_file_path = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
    for index = 1, marks_length do
      local harpoon_file_path = harpoon:list():get(index).value
      local file_name = harpoon_file_path == '' and '(empty)' or vim.fn.fnamemodify(harpoon_file_path, ':t')

      if current_file_path == harpoon_file_path then
        contents[index] = string.format('%%#HarpoonNumberActive# %s. %%#HarpoonActive#%s ', index, file_name)
      else
        contents[index] = string.format('%%#HarpoonNumberInactive# %s. %%#HarpoonInactive#%s ', index, file_name)
      end
    end
    return table.concat(contents)
  end
end

specs.lualine = {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'Mofiqul/dracula.nvim',
    'ThePrimeagen/harpoon',
  },
  init = function()
    vim.cmd('se noshowmode')
  end,
  opts = function()
    return {
      options = {
        theme = require('lualine.themes.dracula-nvim'),
        -- theme = require('lualine.themes.gruvbox'),
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        refresh = { statusline = 100, tabline = 100 },
      },
      extensions = { 'fugitive', 'lazy', 'quickfix', 'trouble', 'man', 'nvim-dap-ui' },
      tabline = {
        lualine_a = {
          {
            'buffers',
            max_length = vim.o.columns,
            mode = 4,
            hide_filename_extension = false,
            show_filename_only = false,
            use_mode_colors = true,
          },
        },
        lualine_z = { { make_harpoon(require('harpoon')), padding = 0 } },
      },
      sections = {
        lualine_a = {
          {
            'progress',
            padding = { left = 1, right = 0 },
            separator = '',
          },
          {
            'location',
            padding = { left = 1, right = 0 },
            fmt = function(s)
              local result = string.format('%-6s', u.trim(s))
              if result[#result] ~= ' ' then
                result = result .. ' '
              end
              return result
            end,
            separator = '',
          },
          {
            function()
              local keymap = vim.o.keymap
              if keymap == '' then
                return ''
              end
              if vim.o.iminsert == 1 then
                return string.upper(keymap:sub(1, 2))
              else
                return 'EN'
              end
            end,
            padding = { left = 0, right = 1 },
          },
        },
        lualine_b = {
          {
            function()
              local fullpath = vim.fn.getcwd()
              if fullpath == nil then
                fullpath = 'error!'
              end
              local home = vim.fn.getenv('HOME')
              return string.gsub(fullpath, '^' .. home, '~')
            end,
            padding = 1,
            separator = '',
          },
          {
            'branch',
            icon = '󰊢',
            align = 'right',
            padding = { left = 1, right = 1 },
          },
        },
        lualine_c = {
          { 'filename', path = 1, symbols = { modified = '  ', readonly = '  ', unnamed = '' }, separator = '' },
          'filetype',
          'fileformat',
          'encoding',
        },
        lualine_x = {
          { 'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
          {
            function()
              return '  ' .. require('dap').status()
            end,
            cond = function()
              return package.loaded['dap'] and require('dap').status() ~= ''
            end,
          },
        },
        lualine_y = {},
        lualine_z = {
          {
            'tabs',
            mode = 2,
            use_mode_colors = true,
          },
        },
      },
    }
  end,
}

return u.values(specs)
