local M = {}
local utils = require("utils")

---@alias KeyTuple [string, string|fun()?]
---@alias KeySpec string|KeyOpts|KeyTuple

---@class LoadOpts
---@field pkg_name string
---@field keys? KeySpec|KeySpec[]
---@field setup? fun()
---@field cmd? string
---@field events? string|string[]
---@field ft? string|string[]

---@class KeyOpts
---@field lhs? string
---@field rhs? string|fun()
---@field mode? string|string[]
---@field opts? any

---@param opts LoadOpts
---@return fun()
function M.on_load(opts)
  local loaded = false

  local function load()
    if not loaded then
      loaded = true
      vim.cmd.packadd(opts.pkg_name)
      if opts.setup then
        opts.setup()
      end
    end
  end

  local function set_keymap(lhs, rhs, mode, map_opts)
    mode = mode or "n"

    local function handler()
      pcall(vim.keymap.del, mode, lhs)
      load()

      if rhs then
        if type(rhs) == "function" then
          rhs()
        elseif type(rhs) == "string" then
          -- vim.api.nvim_feedkeys(vim.keycode(rhs), "m", false)
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(rhs, true, false, true), "m", false)
        end
        vim.schedule(function()
          vim.keymap.set(mode, lhs, rhs, map_opts or {})
        end)
      else
        vim.api.nvim_feedkeys(vim.keycode(lhs), "m", false)
      end
    end

    vim.keymap.set(mode, lhs, handler, map_opts or {})
  end

  return function()
    if opts.cmd then
      vim.api.nvim_create_user_command(opts.cmd, function(data)
        vim.api.nvim_del_user_command(opts.cmd)
        load()
        vim.cmd(("%s %s"):format(opts.cmd, data.args))
      end, { nargs = "?" })
    end

    if opts.keys then
      for _, key in ipairs(utils.normalize_keys(opts.keys)) do
        set_keymap(key.lhs, key.rhs, key.mode, key.opts)
      end
    end

    if opts.events then
      ---@diagnostic disable-next-line: assign-type-mismatch, param-type-mismatch
      vim.api.nvim_create_autocmd(opts.events, {
        once = true,
        callback = load,
      })
    end
    if opts.ft then
      local fts = type(opts.ft) == "string" and { opts.ft } or opts.ft
      ---@cast fts string[]
      for _, ft in ipairs(fts) do
        vim.api.nvim_create_autocmd("FileType", {
          pattern = ft,
          once = true,
          callback = load,
        })
      end
    end
  end
end

--- @param specs (string|vim.pack.Spec)[]
--- @param opts? vim.pack.keyset.add
function M.add(specs, opts)
  for i, spec in ipairs(specs) do
    if type(spec) == "string" then
      specs[i] = utils.gh(spec)
    else
      ---@cast spec vim.pack.Spec
      spec.src = utils.gh(spec.src)
    end
  end
  vim.pack.add(specs, opts)
end
return M
