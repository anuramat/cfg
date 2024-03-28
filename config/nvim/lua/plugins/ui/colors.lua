---@diagnostic disable: unused-local

--- Set colorscheme
---@param nvim string Neovim colorscheme
---@param lualine? string Lualine colorscheme, if different
local function set_colors(nvim, lualine)
  if not lualine then
    lualine = nvim
  end
  vim.cmd.colorscheme(nvim)
  vim.g.lualine_colorscheme = lualine
end

local tokyo = {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('tokyonight').setup({
      on_highlights = function(hl, c)
        -- Hide borders and titles
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePreviewTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
      end,
    })
    set_colors('tokyonight-night', 'tokyonight')
  end,
}

local cat = {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  lazy = false,
  config = function()
    local sign = vim.fn.sign_define
    -- TODO move
    sign('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    sign('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
    sign('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })

    require('catppuccin').setup({
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = 'dark',
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      flavour = 'mocha',
      integrations = {
        aerial = true,
        harpoon = true,
        indent_blankline = {
          enabled = true,
          -- colored_indent_levels = true,
        },
        neotest = true,
        noice = true,
        notify = true,
        rainbow_delimiters = true,
        window_picker = true,
      },
    })
    set_colors('catppuccin')
  end,
}

return tokyo
