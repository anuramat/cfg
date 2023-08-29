local specs = {}
local u = require('utils')

specs.lualine = {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'arkav/lualine-lsp-progress',
    'Mofiqul/dracula.nvim',
    'ThePrimeagen/harpoon',
  },
  opts = function()
    local lualine_dracula = require('lualine.themes.dracula-nvim')
    local dracula_cs = require('dracula').colors()
    for k, _ in pairs(lualine_dracula) do
      lualine_dracula[k].b.bg = dracula_cs.visual
    end
    return {
      options = {
        theme = lualine_dracula,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        --      
        globalstatus = true,
        refresh = { statusline = 100, tabline = 100 },
      },
      extensions = { 'fugitive', 'lazy', 'quickfix', 'trouble', 'man', 'nvim-dap-ui' },
      tabline = {
        lualine_a = {
          {
            'buffers',
            mode = 4,
            hide_filename_extension = false,
            show_filename_only = false,
          },
        },
        lualine_z = { { tabline, padding = 0 } }, -- luacheck: ignore tabline
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
          { 'filename', path = 1, symbols = { modified = '  ', readonly = '  ', unnamed = '' } },
        },
        lualine_x = {
          {
            'lsp_progress',
            -- With spinner
            display_components = { 'lsp_client_name', 'spinner' },
            timer = { spinner = 100 }, -- limited by statusline refresh rate
            spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
          },
        },
        lualine_y = {
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
        lualine_z = {
          {
            'tabs',
            mode = 2,
          },
        },
      },
    }
  end,
}

return u.values(specs)
