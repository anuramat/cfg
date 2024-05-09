local u = require('utils')

return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- optionals:
    'hrsh7th/nvim-cmp',
    'nvim-telescope/telescope.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {

    note_id_func = function()
      return u.random_string(16)
    end,

    note_path_func = function(spec)
      local title = ''
      if spec.title ~= nil then
        title = spec.title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      end
      if title == '' then
        title = tostring(spec.id)
      end
      local path = spec.dir / tostring(title)
      return path:with_suffix('.md')
    end,

    image_name_func = function()
      return string.format('%s-%s', u.random_string(16))
    end,

    note_frontmatter_func = function(note)
      -- metadata = fields not in [id, tags, aliases]
      local out = {
        id = note.id,
      }

      if not vim.tbl_isempty(note.tags) then
        out.tags = note.tags
      end

      local aliases = {}
      if note.path and note.path.filename then
        -- filename without the .md suffix
        local filename = note.path.filename:match('([^/]+)$')
        local name_no_ext, _ = string.gsub(filename, '.md$', '')
        u.insert_unique(aliases, name_no_ext)
      end
      if note.metadata and note.metadata.title then
        -- `title` prop in the frontmatter (for manual control)
        u.insert_unique(aliases, note.metadata.title)
      else
        if note.title then
          -- first "# Heading"
          u.insert_unique(aliases, note.title)
        end
      end
      out.aliases = aliases

      -- keep the other fields
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,

    attachments = {
      img_folder = './img',
    },
    workspaces = {
      {
        name = 'vault',
        path = '~/vault',
      },
    },
    completion = {
      nvim_cmp = true,
    },
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ['gf'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ['<localleader>c'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
    },
  },
}
