return {
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
}
