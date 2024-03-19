vim.diagnostic.config({
  severity_sort = true, -- sort diagnostics by severity
  update_in_insert = true, -- update diagnostics in insert/replace mode
  float = { border = vim.g.border }, -- settings for `vim.diagnostic.open_float`
})
