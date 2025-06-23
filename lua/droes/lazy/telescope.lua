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

    require("droes.keymaps").setup_telescope()
  end,
}
