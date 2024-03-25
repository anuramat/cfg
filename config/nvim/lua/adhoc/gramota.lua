local result_block_type_name = 'gramotaresult'
local start_pattern = '^```%w+'
local end_pattern = '^```%s*$'
local placeholder_format = 'generating %s output [%s], do not edit: %s'

--- Generates an v4 UUID (stolen from internets)
---@return string uuid
local function make_uuid()
  local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
  local uuid, _ = string.gsub(template, '[xy]', function(c)
    local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
    return string.format('%x', v)
  end)
  return uuid
end

local function insert_code(buffer, placeholder, lang, code)
  -- TODO input actual job, change opts
  vim.system({ 'echo', 'test' }, { text = true }, function()
    -- local lines_mid = vim.api.nvim_buf_get_lines(buffer, 0, vim.api.nvim_buf_line_count(buffer), false)
    -- for i, v in ipairs(lines_mid) do
    --   if v == placeholder then
    --     vim.api.nvim_buf_set_lines(0, i, i + 1, false, { 'this should be code' })
    --     break
    --   end
    -- end
  end)
end

--- Wipes placeholders from the buffer
---@param buffer integer Buffer id
local function wipe_placeholders(buffer)
  -- HACK TODO reimplement in lua?
  local regex = string.format(placeholder_format, [[\w\+]], [[\d\+]], [[\w\+-\w\+-\w\+-\w\+-\w\+]])
  vim.cmd([[silent %g/\M]] .. regex .. '/d')
  vim.cmd('noh')
  -- vim.cmd('normal ``zz')
end

--- Wipes result blocks from the buffer
---@param buffer integer Buffer id
local function wipe_results(buffer)
  -- TODO implement
end

--- Finds the first markdown code block starting from given offset
---@param buffer_lines table<string>
---@param offset integer
---@return string, integer, integer, boolean
local function find_block(buffer_lines, offset)
  local start ---@type integer
  local lang ---@type string
  local finish ---@type integer
  local block_found ---@type boolean
  for i, line in ipairs(buffer_lines) do
    i = i + offset
    if not lang then
      local start_match = string.match(line, start_pattern)
      if start_match then
        start = i
        lang = string.sub(start_match, 4)
      end
    end
    if lang and string.find(line, end_pattern) then
      finish = i
      block_found = true
      break
    end
  end
  return lang, start, finish, block_found
end

vim.api.nvim_create_user_command('Exec', function()
  local buffer = vim.api.nvim_get_current_buf()
  wipe_placeholders(buffer)
  wipe_results(buffer)

  local offset = 0 -- last code block position on j-th iteration
  local j = 0
  while true do
    j = j + 1 -- for numbering purposes

    -- read file
    local buffer_lines = vim.api.nvim_buf_get_lines(buffer, offset, vim.api.nvim_buf_line_count(0), false)

    -- find code block
    local lang, start, finish, found = find_block(buffer_lines, offset)
    offset = finish
    if not found then
      break
    end

    -- extract the code block
    local code_lines = vim.list_slice(buffer_lines, start + 1, finish - 1)
    local code = vim.iter(code_lines):join('\n')

    -- insert a placeholder that will be replaced with the code output
    local placeholder = string.format(placeholder_format, lang, tostring(j), make_uuid())
    vim.api.nvim_buf_set_lines(buffer, finish, finish, false, { placeholder })

    insert_code(buffer, placeholder, lang, code)
  end
end, {})

local test = [[
```python
a = 3

print(a+3, 'hahahahah')
```
generating python output [1], do not edit: f680f095-df8e-44ea-8f3d-e1a42ee7797d
```haskell
a = 3

print(a+3, 'hahahahah')
```
generating haskell output [2], do not edit: bd0f3865-2f49-41d2-bec5-706fddfa1f2c
this is important








]]
