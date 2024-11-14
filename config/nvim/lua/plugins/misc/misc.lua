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

local u = require('utils')

return {
  -- mini.ai - new textobjects
  {
    'echasnovski/mini.ai',
    keys = {
      { 'a', mode = { 'x', 'o' } },
      { 'i', mode = { 'x', 'o' } },
    },
    dependencies = { 'nvim-treesitter-textobjects' },
    opts = function()
      local ts = require('mini.ai').gen_spec.treesitter
      return {
        n_lines = 500,
        custom_textobjects = {
          b = false, -- = ([{
          q = false, -- = `'"
          -- ~~~~~~~~~~~~~~~~~~~ functions ~~~~~~~~~~~~~~~~~~~ --
          F = ts({
            a = { '@function.outer' },
            i = { '@function.inner' },
          }, {}),
          f = ts({
            a = { '@call.outer' },
            i = { '@call.inner' },
          }),
          a = ts({
            a = { '@parameter.outer' },
            i = { '@parameter.inner' },
          }),
          -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
          e = ts({
            a = { '@assignment.outer' },
            i = { '@assignment.rhs' },
          }),
          r = ts({
            a = { '@return.outer' },
            i = { '@return.inner' },
          }),
          -- ~~~~~~~~~~~~~~~~~~~~~ misc ~~~~~~~~~~~~~~~~~~~~~~ --
          s = ts({ -- structs/classes; instance/definition
            a = { '@class.outer' },
            i = { '@class.inner' },
          }, {}),
          c = ts({ -- inner doesn't work with most languages, use outer
            a = { '@comment.outer' },
            i = { '@comment.inner' },
          }),
          o = ts({ -- any other blocks
            a = { '@block.outer', '@conditional.outer', '@loop.outer', '@frame.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner', '@frame.inner' },
          }, {}),
        },
        silent = true,
      }
    end,
  },
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
  -- rainbow-delimiters.nvim - TS rainbow parentheses
  {
    -- alterntaives:
    -- * https://github.com/luochen1990/rainbow -- 1.7k stars
    -- * https://github.com/junegunn/rainbow_parentheses.vim -- junegunn, seems "complete", 374 stars
    'HiPhish/rainbow-delimiters.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'BufEnter',
  },
  -- aerial.nvim - symbol outline
  {
    -- simrat39/symbols-outline.nvim
    'stevearc/aerial.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    event = 'BufEnter',
    opts = {
      filter_kind = {
        nix = false,
      },
    },
    keys = { { 'gO', '<cmd>AerialToggle!<cr>', desc = 'Show Aerial Outline' } },
  },
  -- neogen - annotation generation
  {
    'danymat/neogen',
    config = true,
    event = 'BufEnter',
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },
  -- indent-blankline.nvim
  {
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
      }
    end,
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
  -- todo-comments.nvim - highlights "todo", "hack", etc
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    opts = {
      sign_priority = -1000,
      highlight = {
        keyword = 'bg', -- only highlight the word
        pattern = [[<(KEYWORDS)>]], -- vim regex
        multiline = false, -- enable multine todo comments
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]], -- ripgrep regex
      },
    },
  },
  -- neopywal.nvim
  {
    'RedsXDD/neopywal.nvim',
    name = 'neopywal',
    lazy = false,
    priority = 1000,
    opts = {
      use_wallust = true,
      notify = true,
      transparent_background = true,
    },
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
  -- vim-illuminate - highlights the word under cursor using LSP/TS/regex
  {
    'RRethy/vim-illuminate',
    event = 'VeryLazy',
    config = function()
      require('illuminate').configure({ filetypes_denylist = vim.g.nonfiles })
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
  -- lsp-format.nvim
  {
    'lukas-reineke/lsp-format.nvim',
    opts = function()
      local config = {
        lua = {
          exclude = {
            'lua_ls',
          },
        },
        nix = {
          exclude = {
            'nixd',
            'nil_ls',
          },
        },
      }
      return config
    end,
  },
  -- symbol-usage.nvim
  {
    enabled = false,
    'Wansmer/symbol-usage.nvim',
    event = 'LspAttach',
    opts = {
      vt_position = 'end_of_line',
    },
    disable = {
      cond = {
        function(bufnr)
          -- go codegen
          local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]
          return first_line:match('^// Code generated .* DO NOT EDIT%.')
        end,
        function()
          -- disable for all files outside of the cwd
          return vim.fn.expand('%:p'):find(vim.fn.getcwd())
        end,
        function(bufnr)
          -- long files
          return u.buf_lines_len(bufnr) > 1000
        end,
      },
    },
  },
}
