local output_language = 'result'
local border_pattern = '^```%w*%s*$'
local placeholder_format = 'output placeholder, block %s: evaluating %s; id: %s'
local stderr_header = ':::: STDERR ::::'
local stdout_header = ':::: STDOUT ::::'
local footer = '::::::::::::::::'

---@class block
---@field start integer Line number with the opening triple backtick
---@field finish integer Line number with the closing triple backtick
---@field language string Input language
---@field input string[] Input inside the block

---@class border
---@field position integer Line number
---@field language string

--- Generates an random id with a timestamp
---@return string uid
local function make_uid()
  local ts = vim.fn.strftime('%Y.%m.%d-%H:%M:%S-')
  local rand = ''
  for _ = 1, 16 do
    rand = rand .. string.format('%x', math.random(0, 0xf))
  end
  return ts .. rand
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
---@param rhs string
local function fuck(buffer_id, lhs, rhs)
  -- WARNING this function should actually be atomic
  -- although it works for now
  -- TODO figure out how to :(
  local lines = vim.api.nvim_buf_get_lines(buffer_id, 0, vim.api.nvim_buf_line_count(buffer_id), false)
  -- build the output block
  local rhs_table = vim.split(rhs, '\n')
  table.insert(rhs_table, 1, '```' .. output_language)
  table.insert(rhs_table, '```')
  -- insert
  for i, line in ipairs(lines) do
    if line == lhs then
      vim.api.nvim_buf_set_lines(buffer_id, i - 1, i, false, rhs_table)
      break
    end
  end
end

--- Replaces placeholder with output of a command
---@param program string Interpreter for the input (full path or not)
---@return function
local function stdin_interpreter(program)
  ---@param buffer_id integer
  ---@param placeholder string Placeholder to be replaced (verbatim)
  ---@param input string[]
  return function(buffer_id, placeholder, input)
    vim.system({ program }, {
      text = true,
      timeout = 150,
      stdin = input,
    }, function(out)
      vim.schedule(function()
        local output = ''
        if out.stderr ~= '' then
          output = output .. stderr_header .. '\n'
          output = output .. out.stderr
        end
        if out.stderr == '' or out.stdout ~= '' then
          output = output .. stdout_header .. '\n'
          output = output .. out.stdout
        end
        output = output .. footer
        fuck(buffer_id, placeholder, output)
      end)
    end)
  end
end

local languages = {
  python = stdin_interpreter('python'),
  lua = stdin_interpreter('lua'),
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
    if string.match(line, '^%s*' .. string.format(placeholder_format, '.*', '.*', '.*') .. '%s*$') then
      vim.api.nvim_buf_set_lines(buffer_id, i - 1, i, false, {})
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
---@param label string Output block number/name
local function make_placeholder(buffer_id, block, label)
  if block.language == '' then
    return
  end
  local placeholder = string.format(placeholder_format, label, block.language, make_uid())
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

--- Finds the start of the input block (cursor should be between the start of
--- the input block and the end of the output block, both inclusive).
---@param lines string[]
---@param position integer
---@return border? border
local function seek_start(lines, position)
  local search_start = position
  local border
  local found
  local i = 0
  while i < 4 do
    i = i + 1
    border = seek_up(lines, search_start)
    if not border then
      return nil
    end
    found = border.language ~= '' and border.language ~= output_language
    if found then
      break
    end
    search_start = border.position - 1
  end
  if not found or ((i == 4) and not string.match(lines[position], border_pattern)) then
    return nil
  end
  return border
end

--- Executes a single block (cursor should be between the start of the input block
--- and the end of the output block, both inclusive).
---@param buffer_id integer
---@param position integer Row number of the cursor
local function exec_one(buffer_id, position)
  local lines = vim.api.nvim_buf_get_lines(buffer_id, 0, vim.api.nvim_buf_line_count(buffer_id), false)
  local start = seek_start(lines, position)
  if not start then
    return
  end
  local blocks = find_blocks(lines, start.position, 2)
  wipe_block(buffer_id, blocks[2])
  local placeholder = make_placeholder(buffer_id, blocks[1], 'solo')
  if placeholder then
    insert_output(buffer_id, placeholder, blocks[1].language, blocks[1].input)
  end
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Commands ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --

vim.api.nvim_create_user_command('GramotaWipeAll', function()
  local buffer_id = vim.api.nvim_get_current_buf()
  wipe_results(buffer_id)
  wipe_placeholders(buffer_id)
end, {})
vim.api.nvim_create_user_command('GramotaExecAll', exec_all, {})
vim.api.nvim_create_user_command('GramotaExecOne', function()
  local win_id = vim.api.nvim_get_current_win()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(win_id))
  local buffer_id = vim.api.nvim_get_current_buf()
  exec_one(buffer_id, row)
end, {})

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Mappings ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --

vim.cmd('map <leader>e <cmd>GramotaExecAll<cr>')
vim.cmd('map <leader>E <cmd>GramotaExecOne<cr>')
