require("config.keys").main()
if not vim.g.vscode then
  require("config.lazy")
end
require("config.opts")
