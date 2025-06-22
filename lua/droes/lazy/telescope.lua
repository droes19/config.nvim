local data = assert(vim.fn.stdpath("data")) --[[@as string]]
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-smart-history.nvim",
    "kkharji/sqlite.lua",
  },
  config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = { "dune.lock" },
      },
      extensions = {
        wrap_results = true,
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
        history = {
          path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
          limit = 100,
        },
      },
    })

    pcall(require("telescope").load_extension, "ui-select")
    pcall(require("telescope").load_extension, "smart_history")

    local builtin = require("telescope.builtin")
    local set = vim.keymap.set

    set("n", "<space>ff", builtin.find_files)
    set("n", "<space>fgf", builtin.git_files)
    set("n", "<space>fh", builtin.help_tags)
    set("n", "<space>fl", builtin.live_grep)

    set("n", "<space>@", builtin.registers)
    set("n", "<space>lk", builtin.keymaps)
    set("n", "<space>lc", builtin.colorscheme)
    set("n", "<space>lcm", builtin.commands)
    set("n", "<space>lac", builtin.autocommands)
  end,
}
