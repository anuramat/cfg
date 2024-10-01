-- vim: fdl=1
return {
  -- fugitive - main interface
  {
    -- -- neogit is unstable as of 03-2024
    -- return { 'NeogitOrg/neogit', lazy = false, opts = {} }
    'tpope/vim-fugitive',
    lazy = false, -- so that merge tool works
  },
  -- gitsigns - gutter, binds
  {
    -- tanvirtin/vgit.nvim
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
      sign_priority = 0,
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
      set({ 'o', 'x' }, 'ih', ':<c-u>Gitsigns select_hunk<cr>', 'Select hunk')
      -- misc
      prefixed('n', 'b', function() gs.blame_line({ full = true }) end, 'Blame current line')
      prefixed('n', 'd', gs.diffthis, 'Diff')
      prefixed('n', 'D', function() gs.diffthis('~') end, 'Diff @')
    end,
    },
  },
  -- diffview
  {
    'sindrets/diffview.nvim',
    event = 'VeryLazy',
  },
  -- conflict markers
  {
    'rhysd/conflict-marker.vim',
    init = function()
      vim.g.conflict_marker_enable_highlight = 1
      vim.g.conflict_marker_highlight_group = 'Error'
      vim.g.conflict_marker_enable_matchit = 1
      vim.g.conflict_marker_enable_mappings = 0
      -- ct - theirs
      -- co - ours
      -- cn - none
      -- cb - both
      -- cB - reversed both
      -- :ConflictMarker*
    end,
  },
}
