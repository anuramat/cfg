local Job = require('plenary.job')

local result_block_type_name = 'result'
local start_pattern = '^```%w+'
local end_pattern = '^```%s*$'
local placeholder_format = 'generating %s output [%s], do not edit: %s' -- one line only

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

--- Replaces a placeholder, wrapping into a result block
---@param buffer_id integer
---@param lhs string
---@param rhs string
local function fuck(buffer_id, lhs, rhs)
  local lines = vim.api.nvim_buf_get_lines(buffer_id, 0, vim.api.nvim_buf_line_count(buffer_id), false)
  -- build the result block
  local rhs_table = vim.split(rhs, '\n', { trimempty = true })
  table.insert(rhs_table, '```----------') -- TODO remove dashes
  table.insert(rhs_table, 1, '```---------' .. result_block_type_name) -- TODO remove dashes
  -- insert
  for i, line in ipairs(lines) do
    if line == lhs then
      vim.print(rhs_table)
      vim.api.nvim_buf_set_lines(buffer, i - 1, i, false, rhs_table)
      break
    end
  end
end

--- Replaces placeholder with output of a command
---@param buffer_id integer
---@param placeholder string Placeholder to be replaced (verbatim)
---@param code string[]
---@param program table Interpreter for the code
--- TODO generalize for non filterable programs or make it a wrapper idk (use utils.merge?)
local function _insert_code(buffer_id, placeholder, code, program)
  local env = {}
  local command
  if not program.full_path then
    env = { path = vim.fn.expand('$PATH') }
    command = program.name
  else
    command = program.full_path
  end
  Job:new({
    command = command,
    args = {},
    env = env,
    -- WARNING this function should actually be atomic
    -- TODO figure out how to :(
    on_stdout = function(_, data)
      vim.schedule(function()
        fuck(buffer_id, placeholder, data)
      end)
    end,
    writer = code,
  }):start()
end

local function insert_code(buffer_id, placeholder, lang, code)
  if lang == 'python' then
    _insert_code(buffer_id, placeholder, code, { name = 'python' })
  end
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
---@param buffer_lines string[]
---@param offset integer
---@return string, integer, integer, boolean
local function find_block(buffer_lines, offset)
  local start ---@type integer
  local lang ---@type string
  local finish ---@type integer
  local block_found ---@type boolean
  for i = offset + 1, #buffer_lines do
    local line = buffer_lines[i]
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
  local buffer_lines = vim.api.nvim_buf_get_lines(buffer, 0, vim.api.nvim_buf_line_count(buffer), false)
  local j = -1
  while true do
    j = j + 1
    vim.print(j)

    -- find code block
    local lang, start, finish, found = find_block(buffer_lines, offset)
    offset = finish
    if not found then
      break
    end
    vim.print(lang, start, finish)

    -- extract the code block
    local code_lines = vim.list_slice(buffer_lines, start + 1, finish - 1)
    local code = vim.iter(code_lines):join('\n')
    vim.print(code)

    -- -- insert a placeholder that will be replaced with the code output
    local placeholder = string.format(placeholder_format, lang, tostring(j), make_uuid())
    vim.api.nvim_buf_set_lines(buffer, finish + j, finish + j, false, { placeholder })

    if j > 1000 then
      return
    end
    -- insert_code(buffer, placeholder, lang, code)
  end
end, {})

---@diagnostic disable-next-line: unused-local
local test = [[
```python
print('test1')
```
```python
print('test2')
```
```python
print('test3')
```
important line
]]
