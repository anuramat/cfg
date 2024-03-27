-- in opts set: `indent = { highlight = rainbow_lines() }`
local function rainbow_lines()
  local highlight = {
    'RainbowRed',
    'RainbowYellow',
    'RainbowBlue',
    'RainbowOrange',
    'RainbowGreen',
    'RainbowViolet',
    'RainbowCyan',
  }

  local hooks = require('ibl.hooks')
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
    vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
    vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
    vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
    vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
    vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
    vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
  end)

  return highlight
end

return {
  'lukas-reineke/indent-blankline.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'VeryLazy',
  main = 'ibl',
  init = function()
    vim.cmd([[se lcs+=lead:\ ]])
  end,
  opts = function()
    return {
      exclude = {
        filetypes = {
          'lazy',
        },
      },
      indent = {
        -- highlight = rainbow_lines(),
        char = '│',
        -- char = '┃',
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
    }
  end,
}
