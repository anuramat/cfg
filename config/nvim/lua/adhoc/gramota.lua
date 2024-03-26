local Job = require('plenary.job')

local output_language = 'result'
local border_pattern = '^```%w*%s*$'
local placeholder_format = 'generating %s output [%s], do not edit: %s' -- one line only
local output_header = ':::OUTPUT:::'

---@class block
---@field start integer Line number with the opening triple backtick
---@field finish integer Line number with the closing triple backtick
---@field language string Input language
---@field input string[] Input inside the block

---@class border
---@field position integer Line number
---@field language string

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

--- Extracts language from a ``` line
---@param line string
---@return string language
local function get_language(line)
  local match, _ = string.gsub(line, '%W*', '')
  return match
end

--- Replaces a placeholder, wrapping into a output block
---@param buffer_id integer
---@param lhs string
---@param rhs string[]
local function fuck(buffer_id, lhs, rhs)
  -- WARNING this function should actually be atomic
  -- although it works for now
  -- TODO figure out how to :(
  local lines = vim.api.nvim_buf_get_lines(buffer_id, 0, vim.api.nvim_buf_line_count(buffer_id), false)
  -- build the output block
  table.insert(rhs, '```')
  if output_header then
    table.insert(rhs, 1, output_header)
  end
  table.insert(rhs, 1, '```' .. output_language)
  -- insert
  for i, line in ipairs(lines) do
    if line == lhs then
      vim.api.nvim_buf_set_lines(buffer_id, i - 1, i, false, rhs)
      break
    end
  end
end

--- Replaces placeholder with output of a command
---@param program program Interpreter for the input
---@return function
local function stdin_interpreter(program)
  ---@param buffer_id integer
  ---@param placeholder string Placeholder to be replaced (verbatim)
  ---@param input string[]
  return function(buffer_id, placeholder, input)
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
      ---@diagnostic disable-next-line: unused-local
      on_exit = function(j, return_val)
        vim.schedule(function()
          -- vim.print('return val', return_val) -- XXX return code?
          -- TODO display errors
          fuck(buffer_id, placeholder, j:result())
        end)
      end,
      writer = input,
    }):start()
  end
end

local languages = {
  python = stdin_interpreter({ name = 'python' }),
  lua = stdin_interpreter({ name = 'lua' }),
}

--- Replaces a placeholder with the interpreter output
---@param buffer_id integer
---@param placeholder string
---@param language string
---@param input string[]
local function insert_output(buffer_id, placeholder, language, input)
  languages[language](buffer_id, placeholder, input)
end

--- Finds all markdown input blocks in range
--- @param lines string[]
--- @param search_start? integer first line, 1 by default
--- @param max_blocks? integer
---@return block[]
local function find_blocks(lines, search_start, max_blocks)
  local borders = {} ---@type border[]
  if not search_start then
    search_start = 1
  end
  for i = search_start, #lines do
    local line = lines[i]
    if string.match(line, border_pattern) then
      table.insert(borders, {
        position = i,
        language = get_language(line),
      })
    end
    if max_blocks and #borders == 2 * max_blocks then
      break
    end
  end
  assert(#borders % 2 == 0, 'invalid blocks')
  local blocks = {} ---@type block[]
  for i = 1, #borders / 2 do
    local start = borders[i * 2 - 1]
    local finish = borders[i * 2]
    if start.language then
      table.insert(blocks, {
        start = start.position,
        finish = finish.position,
        input = vim.list_slice(lines, start.position + 1, finish.position - 1),
        language = start.language,
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
    if string.match(line, string.format(placeholder_format, '%w+', '%S+', '[%x-]*')) then
      vim.api.nvim_buf_set_lines(buffer_id, i - 1, i - 1, false, {})
    end
  end
end

--- Removes a block, if it's an output block
---@param buffer_id integer
---@param block block
local function wipe_block(buffer_id, block)
  if block.language == output_language then
    vim.api.nvim_buf_set_lines(buffer_id, block.start - 1, block.finish, false, {})
  end
end

--- Wipes result blocks from the buffer
---@param buffer_id integer Buffer id
local function wipe_results(buffer_id)
  local lines = vim.api.nvim_buf_get_lines(buffer_id, 0, vim.api.nvim_buf_line_count(buffer_id), false)
  local blocks = find_blocks(lines)
  for i = #blocks, 1, -1 do
    wipe_block(buffer_id, blocks[i])
  end
end

--- Inserts a placeholder after the block, returning the text of the placeholder
---@param buffer_id integer
---@param block block Input block, for which the placeholder is generated
---@param identifier string Output block number/name
local function make_placeholder(buffer_id, block, identifier)
  if block.language == '' then
    return
  end
  local placeholder = string.format(placeholder_format, block.language, identifier, make_uuid())
  vim.api.nvim_buf_set_lines(buffer_id, block.finish, block.finish, false, { placeholder })
  return placeholder
end

--- Executes all blocks in the buffer
local function exec_all()
  local buffer_id = vim.api.nvim_get_current_buf()
  wipe_placeholders(buffer_id)
  wipe_results(buffer_id)
  local job_list = {}
  local lines = vim.api.nvim_buf_get_lines(buffer_id, 0, vim.api.nvim_buf_line_count(buffer_id), false)
  -- iterate over blocks starting from the end
  local blocks = find_blocks(lines)
  for i = #blocks, 1, -1 do
    local block = blocks[i]
    local placeholder = make_placeholder(buffer_id, block, tostring(i))
    if placeholder then
      -- defer inserting interpreter output
      table.insert(job_list, function()
        insert_output(buffer_id, placeholder, block.language, block.input)
      end)
    end
  end
  for _, f in ipairs(job_list) do
    f()
  end
end

--- Seeks the first border going up
---@param lines string[]
---@param start integer Starting line (inclusive)
---@return border? border
local function seek_up(lines, start)
  for position = start, 1, -1 do
    local line = lines[position]
    if string.match(line, border_pattern) then
      return {
        position = position,
        language = get_language(line),
      }
    end
  end
  return nil
end

--- Executes a single block (cursor should be between the start of the input block
--- and the end of the output block, start included, end excluded).
--- Source block and output block are treated as one if there is no non-whitespace
--- characters between them.
---@param buffer_id integer
---@param position integer Row number of the cursor
local function exec_one(buffer_id, position)
  local lines = vim.api.nvim_buf_get_lines(buffer_id, 0, vim.api.nvim_buf_line_count(buffer_id), false)
  -- step 1 - upstroke
  -- find the ```language line
  local search_start = position
  local border
  for _ = 1, 3 do
    border = seek_up(lines, search_start)
    if not border then
      -- no borders above == no block to run
      return
    end
    if border.language ~= '' and border.language ~= output_language then
      -- we found the start, proceed to next step
      break
    end
    search_start = border.position - 1
  end
  -- step 2 - downstroke
  -- remove the output block
  local blocks = find_blocks(lines, border.position, 2)
  wipe_block(buffer_id, blocks[2])
  -- make placeholder
  local placeholder = make_placeholder(buffer_id, blocks[1], 'solo')
  -- run the interpreter
  if placeholder then
    insert_output(buffer_id, placeholder, blocks[1].language, blocks[1].input)
  end
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Commands ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --

vim.api.nvim_create_user_command('GramotaWipeAll', function()
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

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Mappings ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --

vim.cmd('map <leader>Y <cmd>GramotaExecAll<cr>')
vim.cmd('map <leader>y <cmd>GramotaExecOne<cr>')
