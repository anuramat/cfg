-- custom
--  * messages
--  * cmdline
--  * popupmenu TODO wtf is this
-- messages: passes to nvim-notify, renders natively as a fallback
-- lsp progress: native rendering
return {
  -- enabled = false,
  'folke/noice.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
    'hrsh7th/nvim-cmp',
  },
  event = 'VeryLazy',
  opts = function()
    require('notify').setup({
      render = 'wrapped-compact',
      on_open = function(win)
        -- set border
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_set_config(win, { border = vim.g.border })
        end
      end,
    })
    return {
      popupenu = { backend = 'cmp', enabled = false }, -- TODO what is this
      cmdline = {
        view = 'cmdline',
        format = {
          cmdline = false,
          search_down = false,
          search_up = false,
          filter = false,
          lua = false,
          help = false,
          input = false,
        },
      },
      messages = { enabled = true }, -- forces cmdline
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        long_message_to_split = true, -- long messages will be sent to a split
      },
      lsp = {
        signature = { enabled = false }, -- off because we use ray-x/lsp_signature.nvim
        hover = { silent = true }, -- don't notify on empty hover
        documentation = { opts = { border = vim.g.border } },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp and other two options
        },
      },
    }
  end,
  keys = { { '<leader>n', '<cmd>NoiceDismiss<cr>', desc = 'Dismiss Message' } },
}
