-- vim: fdl=1

return {
  -- vim-illuminate - highlights the word under cursor using LSP/TS/regex
  {
    'RRethy/vim-illuminate',
    event = 'VeryLazy',
    config = function()
      require('illuminate').configure({
        filetypes_denylist = { -- TODO make a vim.g.nonfiles
          'NeogitStatus',
          'NeogitPopup',
          'oil',
          'lazy',
          'lspinfo',
          'null-ls-info',
          'NvimTree',
          'neo-tree',
          'alpha',
          'help',
        },
      })
    end,
  },
  -- undotree
  {
    'mbbill/undotree',
    cmd = {
      'UndotreeHide',
      'UndotreeShow',
      'UndotreeFocus',
      'UndotreeToggle',
    },
    keys = {
      {
        '<leader>u',
        '<cmd>UndotreeToggle<cr>',
        desc = 'Undotree',
      },
    },
  },
  -- mini.trailspace - highlight and delete trailing whitespace
  {
    'echasnovski/mini.trailspace',
    event = 'VeryLazy',
    config = function()
      vim.api.nvim_create_user_command('Trim', require('mini.trailspace').trim, {})
      vim.cmd(
        [[autocmd FileType lazy lua vim.b.minitrailspace_disable = true; require('mini.trailspace').unhighlight()]]
      )
    end,
  },
  -- vim-table-mode -  tables for markdown etc
  {
    'dhruvasagar/vim-table-mode',
    init = function()
      vim.g.table_mode_disable_mappings = 1
      vim.g.table_mode_disable_tableize_mappings = 1
      vim.keymap.set('n', '<leader>T', '<cmd>TableModeToggle<cr>', { silent = true, desc = 'Table Mode: Toggle' })
      vim.keymap.set(
        'n',
        '<leader>t',
        '<cmd>TableModeRealign<cr>',
        { silent = true, desc = 'Table Mode: Realign once' }
      )
    end,
    ft = 'markdown',
  },
  -- nvim-surround - standard surround plugin
  {
    -- The most popular surround plugin (right after tpope/vim-surround)
    'kylechui/nvim-surround',
    opts = {
      keymaps = {
        insert = false,
        insert_line = false,
        -- normal = '<leader>s',
        -- normal_cur = '<leader>ss',
        -- normal_line = '<leader>S',
        -- normal_cur_line = '<leader>SS',
        -- visual = '<leader>s',
        -- visual_line = '<leader>S',
        delete = 'ds',
        change = 'cs',
        change_line = 'cS',
      },
    },
    event = 'BufEnter',
  },
  -- mini.align - align text interactively
  {
    'echasnovski/mini.align',
    -- See also:
    -- junegunn/vim-easy-align
    -- godlygeek/tabular
    -- tommcdo/vim-lion
    -- Vonr/align.nvim
    opts = {
      mappings = {
        start = '<leader>a',
        start_with_preview = '<leader>A',
      },
    },
    keys = {
      { mode = { 'x', 'n' }, '<leader>a', desc = 'Align' },
      { mode = { 'x', 'n' }, '<leader>A', desc = 'Interactive align' },
    },
  },
  -- vim-dadbod - never used, might be broken
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod' },
      {
        'kristijanhusak/vim-dadbod-completion',
        ft = { 'sql', 'mysql', 'plsql' },
        dependencies = { 'hrsh7th/nvim-cmp' },
        init = function()
          -- untested
          vim.cmd(
            [[autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })]]
          )
        end,
      },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  -- vim-fetch - allows for ':e file.txt:1337'
  {
    lazy = false,
    'wsdjeg/vim-fetch',
  },
  -- harpoon - project-local file marks
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = function()
      local harpoon = require('harpoon')
      local set = function(lhs, rhs, desc)
        vim.keymap.set('n', '<leader>h' .. lhs, rhs, { silent = true, desc = 'Harpoon: ' .. desc })
      end
   -- stylua: ignore start
    set('a', function() harpoon:list():add() end, 'Add')
    set('l', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, 'List')
    set('n', function() harpoon:list():next() end, 'Next')
    set('p', function() harpoon:list():prev() end, 'Previous')
      -- stylua: ignore end
      for i = 1, 9 do
        local si = tostring(i)
        set(si, function()
          harpoon:list():select(i)
        end, 'Go to #' .. si)
      end
    end,
  },
  -- vim-sleuth - autodetects indentation settings
  {
    'tpope/vim-sleuth',
    lazy = false,
  },
  -- nvim-colorizer.lua - highlights eg #012345
  {
    'NvChad/nvim-colorizer.lua',
    event = 'VeryLazy',
    opts = {},
  },
  -- mini.bracketed - new ]/[ targets
  {
    'echasnovski/mini.bracketed',
    lazy = false,
    opts = {},
  },
  -- sniprun - run selected code
  {
    event = 'VeryLazy',
    'michaelb/sniprun',
    branch = 'master',
    build = 'sh install.sh',
    opts = {},
  },
  -- info.vim - gnu info browser
  {
    'HiPhish/info.vim',
    event = 'VeryLazy',
  },
  -- flash.nvim - jump around
  {
    'folke/flash.nvim',
    opts = {
      modes = {
        search = { enabled = false },
        char = { enabled = false },
      },
    },
    keys = {
      {
        's',
        mode = 'n',
        function()
          require('flash').jump()
        end,
        desc = 'Jump',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').treesitter()
        end,
        desc = 'TS node',
      },
    },
  },
}
