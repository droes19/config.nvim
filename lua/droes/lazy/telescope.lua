-- local data = vim.fn.stdpath("data") -- already returns a string
--
-- return {
--   "nvim-telescope/telescope.nvim",
--
--   dependencies = {
--     "nvim-telescope/telescope-ui-select.nvim",
--     "nvim-telescope/telescope-smart-history.nvim",
--     "kkharji/sqlite.lua",
--   },
--
--   keys = require("droes.keymaps").get_telescope_keymaps(),
--
--   config = function()
--     local telescope = require("telescope")
--     local themes = require("telescope.themes")
--
--     telescope.setup({
--       defaults = {
--         file_ignore_patterns = {
--           "dune.lock",
--           "node_modules",
--           "%.git/",
--           "target/",
--         },
--
--         vimgrep_arguments = {
--           "rg",
--           "--color=never",
--           "--no-heading",
--           "--with-filename",
--           "--line-number",
--           "--column",
--           "--smart-case",
--           "--hidden", -- include hidden files
--         },
--
--         -- optional: nicer UI defaults
--         wrap_results = true,
--       },
--
--       extensions = {
--         ["ui-select"] = themes.get_dropdown({}),
--         history = {
--           path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
--           limit = 100,
--         },
--       },
--
--       pickers = {
--         find_files = {
--           hidden = true,
--         },
--       },
--     })
--
--     -- Safely load extensions
--     for _, ext in ipairs({ "ui-select", "smart_history" }) do
--       pcall(telescope.load_extension, ext)
--     end
--   end,
-- }
return {
  "nvim-telescope/telescope.nvim",
  version = "*",
    -- stylua: ignore
    keys = {
    { "<space>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
    { "<space>fg", function() require("telescope.builtin").git_files() end, desc = "Find git files" },
    { "<space>fh", function() require("telescope.builtin").help_tags() end, desc = "Find help tags" },
    { "<space>fl", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
    { "<space>@", function() require("telescope.builtin").registers() end, desc = "Show registers" },
    { "<space>lk", function() require("telescope.builtin").keymaps() end, desc = "Show keymaps" },
    { "<space>lc", function() require("telescope.builtin").colorscheme() end, desc = "Change colorscheme" },
    { "<space>lcm", function() require("telescope.builtin").commands() end, desc = "Show commands" },
    { "<space>lac", function() require("telescope.builtin").autocommands() end, desc = "Show autocommands" },
  },
  cmd = "Telescope",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "cmake" },
  },
}
