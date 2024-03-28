-- elements = {
--   { type = 'padding', val = 1 },
--   { type = 'padding', val = 1 },
--   { type = 'padding', val = 1 },
--   { type = 'text', opts = { position = 'center' }, val = '󰈔 File   󰷉 Note' },
--   { type = 'padding', val = 1 },
--   { type = 'text', opts = { position = 'center' }, val = '󰃶 Tday   󰅚 Quit' },
-- }

local elements = require('plugins.ui.dashboard.parts.header.left')
return {
  elements = elements,
  height = #elements,
}
