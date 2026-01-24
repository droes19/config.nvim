local M = {}

-- Use Neovim's data dir (e.g. ~/.local/share/nvim on Linux/macOS, %LOCALAPPDATA%/nvim-data on Windows)
local notes_dir = vim.fn.stdpath("data") .. "/notes"

local function sanitize(name)
  return name
    :gsub("%s+", "-")        -- spaces -> dashes
    :gsub("[^%w%-_%.]", "")  -- keep alnum, -, _, .
    :gsub("%-+", "-")        -- collapse repeated dashes
    :lower()
end

function M.new_note()
  vim.ui.input({ prompt = "New note name: " }, function(input)
    if not input or input == "" then return end
    local fname = sanitize(input) .. ".md"
    local path  = notes_dir .. "/" .. fname

    vim.fn.mkdir(notes_dir, "p")                             -- ensure dir exists
    vim.cmd.edit(vim.fn.fnameescape(path))                   -- open directly (no :cd needed)
  end)
end

-- Optional: timestamped note
function M.new_note_ts()
  vim.fn.mkdir(notes_dir, "p")
  local fname = os.date("%Y%m%d%H%M%S") .. ".md"
  local path  = notes_dir .. "/" .. fname
  vim.cmd.edit(vim.fn.fnameescape(path))
end

return M
