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
        lualine_c = {
          {
            'filename',
            path = 1,
            symbols = { modified = '  ', readonly = '  ', unnamed = '' },
            separator = '',
            padding = { left = 1, right = 1 },
          },
          'filetype',
          'fileformat',
          'encoding',
        },
        lualine_y = {
          {
            'location',
            padding = { left = 1, right = 1 },
            fmt = u.trim,
            separator = '',
          },
        },
        lualine_z = {
          {
            'progress',
            padding = { left = 1, right = 1 },
            separator = '',
          },
        },
      },
      sections = {
        lualine_a = {
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
            padding = { left = 1, right = 1 },
          },
        },
        lualine_b = {
          {
            function()
              local fullpath = vim.fn.getcwd()
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
          { 'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
        },
        lualine_x = {
          {
            function()
              return '  ' .. require('dap').status()
            end,
            cond = function()
              return package.loaded['dap'] and require('dap').status() ~= ''
            end,
          },
        },
        lualine_y = {
          { 'harpoon2' },
        },
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
