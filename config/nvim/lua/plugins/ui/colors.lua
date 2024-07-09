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
        hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
        -- Add an underline border to the context lines and set the background to normal
        hl.TreesitterContext = { bg = c.bg }
        hl.TreesitterContextBottom = { underline = true, sp = c.fg, bg = c.bg }
        hl.TreesitterContextLineNumberBottom = { underline = true, sp = c.fg, bg = c.bg }
      end,
    })
    set_colors('tokyonight-night', 'tokyonight')
  end,
}

local dracula = {
  'Mofiqul/dracula.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    local dracula = require('dracula')
    local c = dracula.colors()
    dracula.setup({
      lualine_bg_color = c.bg,
      overrides = {
        -- Hide borders and titles
        TelescopeBorder = { bg = c.bg, fg = c.bg },
        -- Add an underline border to the context lines and set the background to normal
        TreesitterContext = { bg = c.bg },
        TreesitterContextBottom = { underline = true, sp = c.fg, bg = c.bg },
        TreesitterContextLineNumberBottom = { underline = true, sp = c.fg, bg = c.bg },
        ['@markup.strong'] = { fg = c.cyan, bold = true },
        ['@markup.italic'] = { fg = c.orange, italic = true },
      },
    })
    set_colors('dracula', 'dracula-nvim')
  end,
}

local cat = {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  lazy = false,
  config = function()
    local flavour = 'mocha'

    require('catppuccin').setup({
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = 'dark',
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      flavour = flavour,
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
    local c = require('catppuccin.palettes').get_palette(flavour)
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = c.base, bg = c.base })
  end,
}

return dracula
