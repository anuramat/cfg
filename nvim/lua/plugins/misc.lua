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
      keyword = 'bg',
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
    local wrap = function(cmd)
      return function()
        vim.cmd.delcommand(cmd)
        vim.cmd('Lazy load markdown-preview.nvim')
        vim.api.nvim_exec_autocmds('BufEnter', {}) -- commands appear only after BufEnter
        vim.cmd(cmd)
      end
    end
    _G.lazy_mkdp_toggle = wrap('MarkdownPreviewToggle')
    vim.cmd('command! MarkdownPreviewToggle lua lazy_mkdp_toggle()')
    _G.lazy_mkdp = wrap('MarkdownPreview')
    vim.cmd('command! MarkdownPreview lua lazy_mkdp()')
    _G.lazy_mkdp_stop = wrap('MarkdownPreviewStop')
    vim.cmd('command! MarkdownPreviewStop lua lazy_mkdp_stop()')
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

return u.values(specs)
