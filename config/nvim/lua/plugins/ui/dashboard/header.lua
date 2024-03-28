return {
  info = function()
    local version = vim.version()
    local nvim_version_info = ' ' .. version.major .. '.' .. version.minor .. '.' .. version.patch
    return nvim_version_info
  end,
}
