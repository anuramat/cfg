local u = require('utils')

-- "%d usages"
return {
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
}
