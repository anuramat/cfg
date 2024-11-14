return {
  {
    'stevearc/dressing.nvim',
    opts = {
      input = {
        insert_only = true,
        border = vim.g.border,
      },
      select = {
        backend = { 'builtin', 'nui' },
        nui = { border = { style = vim.g.border } },
        builtin = { border = vim.g.border },
      },
    },
    event = 'VeryLazy',
  },
  {
    -- floating messages
    'rcarriga/nvim-notify',
    opts = function()
      require('notify').setup({
        render = 'wrapped-compact',
        on_open = function(win)
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_set_config(win, { border = vim.g.border })
          end
        end,
      })
    end,
  },
  {
    -- custom
    --  * messages (using notify) - nonblocking messages; sends big messages to a buffer, keeps history
    --  * cmdline - we're forced to use it because of messages
    --  * markdown renders (eg docs in hovers)
    --  and other stuff
    -- messages: passes to nvim-notify, renders natively as a fallback
    -- lsp progress: native rendering
    'folke/noice.nvim',
    -- enabled = false,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
      'hrsh7th/nvim-cmp',
    },
    event = 'VeryLazy',
    opts = {
      popupenu = { enabled = false },
      cmdline = {
        enabled = true,
        view = 'cmdline',
        format = {
          filter = false,
          lua = false,
          help = false,
        },
      },
      messages = { enabled = true }, -- requires cmdline module, otherwise cmdline is invisible
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        long_message_to_split = true, -- long messages will be sent to a split
      },
      lsp = {
        progress = { enabled = false }, -- somehow broken, no idea what it does anyway
        signature = { enabled = false }, -- off because we use ray-x/lsp_signature.nvim
        hover = { silent = true }, -- don't notify on empty hover
        documentation = { opts = { border = vim.g.border } },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp and other two options
        },
      },
    },
    keys = { { '<leader>n', '<cmd>NoiceDismiss<cr>', desc = 'Dismiss Message' } },
  },
}
