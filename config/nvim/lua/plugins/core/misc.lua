-- vim: fdl=1

-- -- splitjoin.vim - splits/joins code using special per-language rules
-- {
--   'AndrewRadev/splitjoin.vim',
--   lazy = false,
--   config = function()
--     vim.g.splitjoin_split_mapping = '<leader>J'
--     vim.g.splitjoin_join_mapping = '<leader>j'
--   end,
-- },

return {
  -- treesj - splits/joins code using TS
  {
    'Wansmer/treesj',
    opts = {
      use_default_keymaps = false,
      max_join_length = 500,
    },
    keys = {
      {
        '<leader>j',
        function()
          require('treesj').toggle()
        end,
        desc = 'Split/Join TS node',
      },
    },
  },
  -- neogen - annotation generation
  {
    'danymat/neogen',
    config = true,
    event = 'BufEnter',
  },
  -- neotest
  {
    'nvim-neotest/neotest',
    lazy = false,
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-neotest/neotest-go', -- go
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace('neotest')
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)
      require('neotest').setup({
        -- your neotest config here
        adapters = {
          require('neotest-go'),
        },
      })
    end,
  },
  -- oil.nvim - file manager
  {
    'stevearc/oil.nvim',
    lazy = false, -- so that it overrides `nvim <path>`
    opts = {
      default_file_explorer = true,
      columns = {
        'icon',
        'permissions',
        'size',
        'mtime',
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      constrain_cursor = 'editable', -- name false editable
      experimental_watch_for_changes = true,
      keymaps_help = {
        border = vim.g.border,
      },
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        natural_order = true,
        sort = {
          -- sort order can be "asc" or "desc"
          -- see :help oil-columns to see which columns are sortable
          { 'type', 'asc' },
          { 'name', 'asc' },
        },
      },
      float = { border = vim.g.border },
      preview = { border = vim.g.border },
      progress = { border = vim.g.border },
      ssh = {
        border = vim.g.border,
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>o', '<cmd>Oil<cr>', desc = 'File CWD' },
      { '<leader>O', '<cmd>Oil .<cr>', desc = 'Open Parent Directory' },
    },
  },
  -- eunuch - rm, mv, etc
  {
    -- basic file commads for the current file (remove, rename, etc.)
    -- see also:
    -- chrisgrieser/nvim-genghis - drop in lua replacement with some bloat/improvements
    'tpope/vim-eunuch',
    event = 'VeryLazy',
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
  -- sniprun - run selected code
  {
    event = 'VeryLazy',
    'michaelb/sniprun',
    build = 'sh install.sh',
    opts = {},
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
  {
    'Zeioth/compiler.nvim',
    cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
    dependencies = { 'stevearc/overseer.nvim', 'nvim-telescope/telescope.nvim' },
    opts = {},
    -- TODO steal more shit from https://github.com/Zeioth/compiler.nvim
  },
  -- overseer.nvim - task runner (tasks.json, dap integration, etc)
  {
    'stevearc/overseer.nvim',
    commit = '6271cab7ccc4ca840faa93f54440ffae3a3918bd',
    cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
    opts = {
      task_list = {
        direction = 'bottom',
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
  },
}
