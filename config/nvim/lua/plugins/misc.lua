local specs = {}
local k = require('plug_keys')
local u = require('utils')

specs.surround = {
  'kylechui/nvim-surround',
  version = '*',
  opts = {},
  keys = {
    { '<C-g>s', mode = 'i' },
    { '<C-g>S', mode = 'i' },
    { 'ys' },
    { 'yS' },
    { 'S',      mode = 'x' },
    { 'gS',     mode = 'x' },
    { 'ds' },
    { 'cs' },
  }
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
  config       = function()
    require('Comment').setup({
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    })
  end,
  keys         = {
    { 'gc', mode = { 'n', 'x' } },
    { 'gb', mode = { 'n', 'x' } },
  },
}

specs.ai = {
  'echasnovski/mini.ai',
  keys = {
    { "a", mode = { "x", "o" } },
    { "i", mode = { "x", "o" } },
  },
  dependencies = { 'nvim-treesitter-textobjects' },
  opts = function()
    return {
      n_lines = 500,
      custom_textobjects = k.miniai(),
      silent = true,
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
      keyword = 'bg',
      -- TODO fix
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

specs.readline = {
  'linty-org/readline.nvim',
  keys = k.readline
}

specs.mdpreview = {
  'iamcco/markdown-preview.nvim',
  init = function()
    local function load_then_exec(cmd)
      return function()
        vim.cmd.delcommand(cmd)
        vim.cmd('Lazy load markdown-preview.nvim')
        vim.api.nvim_exec_autocmds('BufEnter', {}) -- commands appear only after BufEnter
        vim.cmd(cmd)
      end
    end
    for _, cmd in pairs({ 'MarkdownPreview', 'MarkdownPreviewStop', 'MarkdownPreviewToggle' }) do
      vim.api.nvim_create_user_command(cmd, load_then_exec(cmd), {})
    end
  end,
  build = function()
    vim.fn['mkdp#util#install']()
  end,
  config = function()
    vim.g.mkdp_auto_close = false
    vim.g.mkdp_echo_preview_url = true
    vim.g.mkdp_page_title = '${name}'
  end,
}

specs.align = {
  'echasnovski/mini.align',
  opts = {
  },
  keys = {
    { mode = { 'x', 'n' }, 'ga' },
    { mode = { 'x', 'n' }, 'gA' },
  }
}

specs.harpoon = {
  'ThePrimeagen/harpoon',
  keys = k.harpoon(),
  dependencies = {
    'nvim-lua/plenary.nvim', },
  opts = {
    tabline = true
  }
}

return u.values(specs)
