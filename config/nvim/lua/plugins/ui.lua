local specs = {}
local u = require('utils')

specs.dracula_cs = {
  'Mofiqul/dracula.nvim',
  priority = 1337,
  lazy = false,
  config = function()
    local dracula = require('dracula')
    local cs = dracula.colors()
    local opts = {
      italic_comment = true,
      lualine_bg_color = cs.bg,
      transparent_bg = true, -- default false
    }
    dracula.setup(opts)

    vim.cmd.colorscheme('dracula')

    u.style_codelens()
    vim.cmd('highlight! link FloatBorder Normal')
    vim.cmd('highlight! link NormalFloat Normal')
    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none' })
  end,
}

specs.indentline = {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VeryLazy',
  opts = {
    char = '│',
    filetype_exclude = {
      'TelescopePrompt',
      'Trouble',
      'checkhealth',
      'help',
      'lazy',
      'lspinfo',
      'man',
      'quickfix',
    },
    show_trailing_blankline_indent = false,
    show_current_context = false,
  },
}

specs.marks = {
  'chentoast/marks.nvim',
  event = 'VeryLazy',
  opts = {},
}

specs.cursorword = {
  'echasnovski/mini.cursorword',
  version = false,
  event = 'VeryLazy', -- TODO lazier?
  opts = { delay = 50 },
}

-- specs.which = {
--   'folke/which-key.nvim',
--   event = 'VeryLazy',
--   init = function()
--     vim.o.timeout = true
--     vim.o.timeoutlen = 1000
--   end,
--   config = function()
--     local wk = require('which-key')
--     -- local opts = { operators = { gc = 'Comments', ys = 'Surround', ga = 'Align' } } -- TODO fix
--     local mappings = {
--       ['<leader>b'] = { name = 'Buffer' },
--       ['<leader>h'] = { name = 'Harpoon' },
--       ['<leader>f'] = { name = 'Telescope' },
--       ['<leader>l'] = { name = 'LSP' },
--       ['<leader>lw'] = { name = 'LSP Workspace' }, -- fix ("+prefix" shows instead of "+LSP Workspace")
--       ['<leader>d'] = { name = 'DAP' },
--       ['<leader>t'] = { name = 'Trouble' },
--       ['<leader>g'] = { name = 'Git' },
--       ['<leader>q'] = { name = 'Quickfix' },
--     }
--     wk.register(mappings)
--     wk.setup(opts)
--   end,
-- }

specs.zen = {
  'folke/zen-mode.nvim',
  opts = {
    window = {
      backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
      -- height and width can be:
      -- * an absolute number of cells when > 1
      -- * a percentage of the width / height of the editor when <= 1
      -- * a function that returns the width or the height
      width = 120, -- width of the Zen window
      height = 1, -- height of the Zen window
      -- by default, no options are changed for the Zen window
      -- uncomment any of the options below, or add other vim.wo options you want to apply
      options = {
        -- signcolumn = "no", -- disable signcolumn
        -- number = false, -- disable number column
        -- relativenumber = false, -- disable relative numbers
        -- cursorline = false, -- disable cursorline
        -- cursorcolumn = false, -- disable cursor column
        -- foldcolumn = "0", -- disable fold column
        -- list = false, -- disable whitespace characters
      },
    },
    plugins = {
      -- disable some global vim options (vim.o...)
      -- comment the lines to not apply the options
      options = {
        enabled = true,
        ruler = false, -- disables the ruler text in the cmd line area
        showcmd = false, -- disables the command in the last line of the screen
      },
      twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
      gitsigns = { enabled = false }, -- disables git signs
      tmux = { enabled = false }, -- disables the tmux statusline
      -- this will change the font size on kitty when in zen mode
      -- to make this work, you need to set the following kitty options:
      -- - allow_remote_control socket-only
      -- - listen_on unix:/tmp/kitty
      kitty = {
        enabled = false,
        font = '+4', -- font size increment
      },
      -- this will change the font size on alacritty when in zen mode
      -- requires  Alacritty Version 0.10.0 or higher
      -- uses `alacritty msg` subcommand to change font size
      alacritty = {
        enabled = false,
        font = '14', -- font size
      },
      -- this will change the font size on wezterm when in zen mode
      -- See alse also the Plugins/Wezterm section in this projects README
      wezterm = {
        enabled = false,
        -- can be either an absolute font size or the number of incremental steps
        font = '+4', -- (10% increase per step)
      },
    },
    -- callback where you can add custom code when the Zen window opens
    on_open = function(win) end,
    -- callback where you can add custom code when the Zen window closes
    on_close = function() end,
  },
}

return u.values(specs)
