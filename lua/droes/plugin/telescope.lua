local data = assert(vim.fn.stdpath "data") --[[@as string]]

require("telescope").setup {
    defaults = {
        file_ignore_patterns = { "dune.lock" },
    },
    extensions = {
        wrap_results = true,

        fzf = {},
        history = {
          path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
          limit = 100,
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
        },
    },
}

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require "telescope.builtin"
local set = vim.keymap.set

set("n", "<space>ff", builtin.find_files)
set("n", "<space>fgf", builtin.git_files)
set("n", "<space>fh", builtin.help_tags)
set("n", "<space>fl", builtin.live_grep)
set("n", "<space>fm", require "droes.plugin.multi-ripgrep")
set("n", "<space>fb", builtin.buffers)
set("n", "<space>/", builtin.current_buffer_fuzzy_find)

set("n", "<space>fgs", builtin.grep_string)

set("n", "<space>nl", function()
    ---@diagnostic disable-next-line: param-type-mismatch
    builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy") }
end, { desc = "Go to dir [N]vim [L]azy" })

set("n", "<space>nc", function()
    builtin.find_files { cwd = vim.fn.stdpath "config" }
end, { desc = "Go to dir [N]vim [C]onfig" })

-- vim.keymap.set("n", "<space>eo", function()
--   builtin.find_files { cwd = "~/.config/nvim-backup/" }
-- end)
--
-- vim.keymap.set("n", "<space>fp", function()
--   builtin.find_files { cwd = "~/plugins/" }
-- end)
set("n", "<space>@", builtin.registers)
set("n", "<space>lk", builtin.keymaps)
set("n", "<space>lc", builtin.colorscheme)
set("n", "<space>lcm", builtin.commands)
set("n", "<space>lac", builtin.autocommands)
