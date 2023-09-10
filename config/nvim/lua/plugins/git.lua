local specs = {}
local u = require('utils')

specs.fugitive = {
  'tpope/vim-fugitive',
  lazy = false, -- so that merge tool works
}

specs.signs = {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  opts = {
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
      untracked = { text = '▎' },
    },
    -- stylua: ignore
    on_attach = function()
      local buffer = 0
      local gs = package.loaded.gitsigns
      local prefix = '<leader>g'
      local function prefixed(mode, l, r, desc) vim.keymap.set(mode, prefix..l, r, { buffer = buffer, desc = desc }) end
      local function set(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc }) end
      local function stage_selection() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end
      local function reset_selection() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end
      -- stage
      prefixed('n', 'S', gs.stage_buffer,   'Stage buffer')
      prefixed('n', 's', gs.stage_hunk,     'Stage hunk')
      prefixed('v', 's', stage_selection, 'Stage selection')
      -- reset
      prefixed('n', 'R', gs.reset_buffer,   'Reset buffer')
      prefixed('n', 'r', gs.reset_hunk,     'Reset hunk')
      prefixed('v', 'r', reset_selection, 'Reset selection')
      -- misc hunk fns
      prefixed('n', 'u', gs.undo_stage_hunk, 'Undo stage (hunk/selection)')
      set('n',      ']h', gs.next_hunk,    'Next hunk')
      set('n',      '[h', gs.prev_hunk,    'Previous hunk')
      prefixed('n', 'p',  gs.preview_hunk, 'Preview hunk')
      prefixed({ 'o', 'x' }, 'ih', ':<c-u>Gitsigns select_hunk<cr>', 'Select hunk')
      -- misc
      prefixed('n', 'b', function() gs.blame_line({ full = true }) end, 'Blame current line')
      prefixed('n', 'd', gs.diffthis, 'Diff')
      prefixed('n', 'D', function() gs.diffthis('~') end, 'Diff @')
    end,
  },
}

return u.values(specs)
