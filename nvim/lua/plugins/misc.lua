local specs = {}
local k = require('plug_keys')
local u = require('utils')

specs.surround = {
  'kylechui/nvim-surround',
  version = '*',      -- use last release instead of main
  event = 'VeryLazy', -- TODO lazier
  opts = {
    keymaps = k.surround
  },
}

specs.treesj = {
  'Wansmer/treesj',
  version = false,
  opts = {
    use_default_keymaps = false,
    max_join_length = 500,
  },
  keys = k.treesj,
}

specs.comment = {
  'numToStr/Comment.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'JoosepAlviste/nvim-ts-context-commentstring' },
  event        = 'VeryLazy',
  config       = function()
    local opts = k.comment
    opts.pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    require('Comment').setup(opts)
  end,
}

specs.ai = {
  'echasnovski/mini.ai',
  event = 'VeryLazy', -- TODO lazier
  dependencies = { 'nvim-treesitter-textobjects' },
  opts = function()
    return {
      n_lines = 500,
      custom_textobjects = k.miniai(),
    }
  end,
}

specs.flash = {
  'folke/flash.nvim',
  opts = {
    modes = {
      search = { enabled = false },
      char = { enabled = false }
    },
  },
  keys = k.flash(),
}

specs.todo = {
  'folke/todo-comments.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    highlight = {
      keyword = "bg",
      pattern = [[<(KEYWORDS)]], -- pattern or table of patterns, used for highlighting (vim regex)
    },
    search = {
      pattern = [[(KEYWORDS)]], -- ripgrep regex
    },
  },
}

specs.trouble = {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = k.trouble(),
}

specs.undotree = {
  'mbbill/undotree',
  cmd = {
    'UndotreeHide',
    'UndotreeShow',
    'UndotreeFocus',
    'UndotreeToggle',
  },
  keys = k.undotree(),
}

specs.sleuth = {
  'tpope/vim-sleuth',
  event = { 'BufReadPre', 'BufNewFile' },
}

-- specs.readline = {
--   'linty-org/readline.nvim',
--   event = 'VeryLazy',
--   config = function()
--     k.readline()
--   end,
-- }

return u.values(specs)
