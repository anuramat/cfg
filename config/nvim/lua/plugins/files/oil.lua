-- main file manager
-- netrw replacement
-- directories are regular buffers
return {
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
      show_hidden = false,
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
    { '<leader>o', '<cmd>Oil<cr>', desc = 'File Manager (Oil)' },
  },
}
