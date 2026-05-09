local M = {}

function M.gh(x)
  return "https://github.com/" .. x
end

function M.map(mode, lhs, rhs, opts, bufnr)
  opts = opts or {}
  if bufnr then
    opts.buffer = bufnr
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.normalize_keys(keys)
  local result = {}
  local function push(lhs, rhs, mode, opts)
    table.insert(result, { lhs = lhs, rhs = rhs, mode = mode, opts = opts })
  end

  if type(keys) == "string" then
    -- case: single string
    push(keys)
  elseif vim.islist(keys) then
    -- case: list of entries
    for _, entry in ipairs(keys) do
      if type(entry) == "string" then
        push(entry)
      elseif entry.lhs then
        push(entry.lhs, entry.rhs, entry.mode, entry.opts)
      elseif type(entry[1]) == "string" then
        push(entry[1], entry[2], entry.mode, { desc = entry.desc })
      end
    end
  elseif keys.lhs then
    -- case: { lhs = "...", rhs = ... }
    push(keys.lhs, keys.rhs, keys.mode, keys.opts)
  elseif type(keys[1]) == "string" then
    -- case: { "<lhs>", "<rhs>", desc = "..." }
    push(keys[1], keys[2], keys.mode, { desc = keys.desc })
  end

  return result
end

return M
