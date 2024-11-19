return function()
  local cmp = require('cmp')
  cmp.setup.cmdline(':', {
    completion = { autocomplete = false },
    mapping = cmp.mapping.preset.cmdline(),
    view = {
      entries = 'custom',
    },
    sources = cmp.config.sources(
      { { name = 'path', option = { trailing_slash = true } } },
      { { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } } }
    ),
  })
end
