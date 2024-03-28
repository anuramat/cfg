return {
  info = function()
    local datetime = os.date(' %d-%m-%Y   %H:%M:%S')
    local version = vim.version()
    local nvim_version_info = ' ' .. version.major .. '.' .. version.minor .. '.' .. version.patch
    return datetime .. '   ' .. nvim_version_info
  end,
}
