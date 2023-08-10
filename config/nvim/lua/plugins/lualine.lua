local specs = {}
local u = require('utils')
specs.lualine = {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'arkav/lualine-lsp-progress' },
  opts = function()
    return {
      options = {
        theme = 'dracula-nvim',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        globalstatus = true,
        refresh = { statusline = 100 },
      },
      extensions = { 'fugitive', 'lazy', 'quickfix', 'trouble', 'man', 'nvim-dap-ui' },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'branch', icon = '󰊢' } },
        lualine_c = { { 'filename', path = 3, symbols = { modified = '  ', readonly = '', unnamed = '' } }, },
        lualine_x = {
          {
            'lsp_progress',
            -- With spinner
            display_components = { 'lsp_client_name', 'spinner' },
            timer = { spinner = 100 }, -- limited by statusline refresh rate
            spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
          }

        },
        lualine_y = {
          { 'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
          {
            function() return '  ' .. require('dap').status() end,
            cond = function() return package.loaded['dap'] and require('dap').status() ~= '' end,
          },
          {
            'tabs',
            mode = 2,
            tabs_color = { active = {}, inactive = { fg = 'grey' } },
          },
        },
        lualine_z = {
          { 'location', padding = { left = 1, right = 1 }, fmt = u.trim },
          { 'progress', padding = { left = 1, right = 1 }, fmt = u.trim },
        },
      },
    }
  end,
}

return u.values(specs)
