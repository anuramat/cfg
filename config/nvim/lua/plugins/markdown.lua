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

-- TODO
specs.obsidian = {
  'epwalsh/obsidian.nvim',
  lazy = true,
  event = { 'BufReadPre path/to/my-vault/**.md' },
  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
  -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    dir = '~/my-vault', -- no need to call 'vim.fn.expand' here

    -- see below for full list of options 👇
  },
}

return u.values(specs)
