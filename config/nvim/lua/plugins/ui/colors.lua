-- return {
--   'Mofiqul/dracula.nvim',
--   priority = 1337,
--   lazy = false,
--   config = function()
--     local dracula = require('dracula')
--     local cs = dracula.colors()
--     local opts = {
--       italic_comment = true,
--       lualine_bg_color = cs.bg,
--       transparent_bg = false,
--     }
--     dracula.setup(opts)
--     vim.cmd.colorscheme('dracula')
--     -- Override shitty default CodeLens style
--     local clhl = vim.api.nvim_get_hl(0, { name = 'LspCodeLens' })
--     clhl.underline = true
--     clhl.bold = true
--     vim.api.nvim_set_hl(0, 'LspCodeLens', clhl)
--     -- Make window borders properly visible
--     vim.cmd('hi WinSeparator guibg=bg guifg=fg')
--   end,
-- }

return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('tokyonight').setup({
      on_highlights = function(hl, c)
        local prompt = '#2d3149'
        hl.TelescopeNormal = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
          bg = prompt,
        }
        hl.TelescopePromptBorder = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePromptTitle = {
          bg = prompt,
          fg = prompt,
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
    vim.g.border = 'solid'
    vim.cmd.colorscheme('tokyonight')
  end,
}
