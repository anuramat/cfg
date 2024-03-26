local Job = require('plenary.job')

local result_block_type_name = 'result'
local border_pattern = '^```%w*%s*$'
local placeholder_format = 'generating %s output [%s], do not edit: %s' -- one line only

---@class block
---@field start integer Line number with the opening triple backtick
---@field finish integer Line number with the closing triple backtick
---@field language string Language of the code block
---@field code string[] Code inside the block

---@class border
---@field position integer Line number
---@field contents string Text in the line

---@class program
---@field full_path? string Full path to a binary
---@field name? string Name of the binary in $PATH

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
---@param rhs string[]
local function fuck(buffer_id, lhs, rhs)
  -- WARNING this function should actually be atomic
  -- although it works for now
  -- TODO figure out how to :(
  local lines = vim.api.nvim_buf_get_lines(buffer_id, 0, vim.api.nvim_buf_line_count(buffer_id), false)
  -- build the result block
  table.insert(rhs, '```')
  table.insert(rhs, 1, ':::OUTPUT:::')
  table.insert(rhs, 1, '```' .. result_block_type_name)
  -- insert
  for i, line in ipairs(lines) do
    if line == lhs then
      vim.api.nvim_buf_set_lines(buffer_id, i - 1, i, false, rhs)
      break
    end
  end
end

--- Replaces placeholder with output of a command
---@param program program Interpreter for the code
---@return function
local function stdin_interpreter(program)
  ---@param buffer_id integer
  ---@param placeholder string Placeholder to be replaced (verbatim)
  ---@param code string[]
  return function(buffer_id, placeholder, code)
    local env = {}
    local command
    if not program.full_path then
      env = { path = vim.fn.expand('$PATH') }
      command = program.name
    else
      command = program.full_path
    end
    assert(command ~= nil, 'empty command')

    Job:new({
      command = command,
      args = {},
      env = env,
      on_exit = function(j, return_val)
        vim.schedule(function()
          -- vim.print('return val', return_val) -- XXX return code?
          fuck(buffer_id, placeholder, j:result())
        end)
      end,
      writer = code,
    }):start()
  end
end

local languages = {
  python = stdin_interpreter({ name = 'python' }),
  lua = stdin_interpreter({ name = 'lua' }),
}

--- Replaces a placeholder with the results of running code through an interpreter
---@param buffer_id integer
---@param placeholder string
---@param language string
---@param code string[]
local function insert_code(buffer_id, placeholder, language, code)
  languages[language](buffer_id, placeholder, code)
end

--- Finds all markdown code blocks
--- @param lines string[]
---@return block[]
local function find_blocks(lines)
  local borders = {} ---@type border[]
  for i = 1, #lines do
    local line = lines[i]
    if string.match(line, border_pattern) then
      table.insert(borders, {
        position = i,
        contents = line,
      })
    end
  end
  assert(#borders % 2 == 0, 'invalid code blocks!')
  local blocks = {} ---@type block[]
  for i = 1, #borders / 2 do
    local start = borders[i * 2 - 1]
    local finish = borders[i * 2]
    local language = string.gsub(start.contents, '%W*', '')
    if language then
      table.insert(blocks, {
        start = start.position,
        finish = finish.position,
        code = vim.list_slice(lines, start.position + 1, finish.position - 1),
        language = language,
      })
    end
  end
  return blocks
end

--- Wipes placeholders from the buffer
---@param buffer_id integer Buffer id
local function wipe_placeholders(buffer_id)
  local lines = vim.api.nvim_buf_get_lines(buffer_id, 0, vim.api.nvim_buf_line_count(buffer_id), false)
  for i = #lines, 1, -1 do
    local line = lines[i]
    if string.match(line, string.format(placeholder_format, '%w+', '%d+', '[%x-]*')) then
      vim.api.nvim_buf_set_lines(buffer_id, i - 1, i - 1, false, {})
    end
  end
end

--- Wipes result blocks from the buffer
---@param buffer_id integer Buffer id
local function wipe_results(buffer_id)
  local lines = vim.api.nvim_buf_get_lines(buffer_id, 0, vim.api.nvim_buf_line_count(buffer_id), false)
  local blocks = find_blocks(lines)
  for i = #blocks, 1, -1 do
    local block = blocks[i]
    if block.language == result_block_type_name then
      vim.api.nvim_buf_set_lines(buffer_id, block.start - 1, block.finish, false, {})
    end
  end
end

--- Executes all blocks in the buffer
local function exec_all()
  local buffer_id = vim.api.nvim_get_current_buf()
  wipe_placeholders(buffer_id)
  wipe_results(buffer_id)
  local job_list = {}
  local lines = vim.api.nvim_buf_get_lines(buffer_id, 0, vim.api.nvim_buf_line_count(buffer_id), false)
  -- iterate over codeblocks starting from the end
  local blocks = find_blocks(lines)
  for i = #blocks, 1, -1 do
    local block = blocks[i]
    -- add placeholder after block
    local placeholder = string.format(placeholder_format, block.language, tostring(i), make_uuid())
    vim.api.nvim_buf_set_lines(buffer_id, block.finish, block.finish, false, { placeholder })
    -- defer the code runner
    table.insert(job_list, function()
      insert_code(buffer_id, placeholder, block.language, block.code)
    end)
  end
  for _, f in ipairs(job_list) do
    f()
  end
end

--- Executes a block that contains the specified line
---@param line integer The line in the block
local function exec_one(buffer_id, position)
  local lines = vim.api.nvim_buf_get_lines(buffer_id, 0, vim.api.nvim_buf_line_count(buffer_id), false)
  local language
  local start
  local finish
  for i = position, 1, -1 do
    local line = lines[i]
    if string.match(line, border_pattern) then
      language = string.gsub(line, '%W*', '')
      start = i
      break
    end
  end
  assert(language ~= '', 'no language specified for the block')
  for i = position, #lines do
    local line = lines[i]
    if string.match(line, border_pattern) then
      finish = i
    end
  end
  vim.print(start, finish) -- XXX
  -- TODO find the next block and delete it if it's a result block
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Mappings ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --

vim.api.nvim_create_user_command('GramotaWipe', function()
  wipe_results(0)
  wipe_placeholders(0)
end, {})
vim.api.nvim_create_user_command('GramotaExecAll', exec_all, {})
vim.api.nvim_create_user_command('GramotaExecOne', function()
  local win_id = vim.api.nvim_get_current_win()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(win_id))
  local buffer_id = vim.api.nvim_get_current_buf()
  exec_one(buffer_id, row)
end, {})

vim.cmd('map <leader>Y <cmd>GramotaExecAll<cr>')
vim.cmd('map <leader>y <cmd>GramotaExecOne<cr>')
