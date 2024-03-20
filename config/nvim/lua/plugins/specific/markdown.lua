local specs = {}
local u = require('utils')

specs.mdpreview = {
  'iamcco/markdown-preview.nvim',
  init = function()
    local function load_then_exec(cmd)
      return function()
        vim.cmd.delcommand(cmd)
        require('lazy').load({ plugins = { 'markdown-preview.nvim' } })
        vim.api.nvim_exec_autocmds('BufEnter', {}) -- commands appear only after BufEnter
        vim.cmd(cmd)
      end
    end
    for _, cmd in pairs({ 'MarkdownPreview', 'MarkdownPreviewStop', 'MarkdownPreviewToggle' }) do
      vim.api.nvim_create_user_command(cmd, load_then_exec(cmd), {})
    end
  end,
  build = function()
    vim.fn['mkdp#util#install']()
  end,
  config = function()
    vim.g.mkdp_auto_close = false
    vim.g.mkdp_echo_preview_url = true
    vim.g.mkdp_page_title = '${name}'
  end,
}

return u.values(specs)
