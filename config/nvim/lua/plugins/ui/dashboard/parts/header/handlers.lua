return {
  new_file = function()
    vim.cmd('enew')
  end,
  obsidian_today = function()
    vim.cmd('ObsidianToday')
  end,
  obsidian_new = function()
    vim.cmd('ObsidianNew')
  end,
  neovim_config_find = function()
    require('telescope.builtin').find_files({ cwd = '~/cfg/config/nvim' })
  end,
  find = function()
    vim.cmd('Telescope find_files')
  end,
  grep = function()
    vim.cmd('Telescope live_grep')
  end,
  jump = function()
    vim.cmd('Telescope zoxide list')
  end,
  quit = function()
    vim.cmd('q')
  end,
}
