local u = require('utils')

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    {
      'letieu/harpoon-lualine',
      dependencies = 'ThePrimeagen/harpoon',
    },
  },
  init = function()
    vim.cmd('se noshowmode')
  end,
  opts = function()
    return {
      options = {
        -- theme = 'tokyonight',
        theme = vim.g.lualine_colorscheme,
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
        lualine_z = { { 'harpoon2' } },
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
            mode = 0,
            use_mode_colors = true,
            show_modified_status = false,
          },
        },
      },
    }
  end,
}
