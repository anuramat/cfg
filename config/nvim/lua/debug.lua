local M = {}

--- Prints triggered events for debug purposes
--- @param events table List of events to subscribe to
function M.debug_events(events)
  local g = vim.api.nvim_create_augroup('event_debugger', { clear = true })
  local counter = 0
  for _, e in pairs(events) do
    vim.api.nvim_create_autocmd(e, {
      group = g,
      callback = function(opts)
        vim.notify('Event ' .. tostring(counter) .. ' triggered: ' .. opts.event)
        counter = counter + 1
      end,
    })
  end
end

return M
