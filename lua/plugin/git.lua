local pack = require("pack")
local utils = require("utils")

pack.add({ "lewis6991/gitsigns.nvim" }, {
  load = pack.on_load({
    pkg_name = "gitsigns.nvim",
    setup = function()
      require("gitsigns").setup({
        current_line_blame = true,
        current_line_blame_formatter = "<author>, (<author_time:%d-%m-%Y %H:%M:%S>) <author_time:%R> - <summary>",
        -- stylua: ignore
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")

          -- Hunk Navigation
          utils.map("n", "]c", function() if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gitsigns.nav_hunk("next") end end, { desc = "Next git hunk" }, bufnr)
          utils.map("n", "[c", function() if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gitsigns.nav_hunk("prev") end end, { desc = "Previous git hunk" }, bufnr)

          -- Stage/Reset Operations
          utils.map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" }, bufnr)
          utils.map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" }, bufnr)
          utils.map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage hunk (visual)" }, bufnr)
          utils.map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset hunk (visual)" }, bufnr)

          -- Buffer Operations
          utils.map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" }, bufnr)
          utils.map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" }, bufnr)

          -- Preview & Information
          utils.map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" }, bufnr)
          utils.map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" }, bufnr)
          utils.map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "Blame line" }, bufnr)

          -- Diff Operations
          utils.map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" }, bufnr)
          utils.map("n", "<leader>hD", function() gitsigns.diffthis("~") end, { desc = "Diff this (cached)" }, bufnr)

          -- Quickfix Integration
          utils.map("n", "<leader>hQ", function() gitsigns.setqflist("all") end, { desc = "Send all hunks to quickfix" }, bufnr)
          utils.map("n", "<leader>hq", gitsigns.setqflist, { desc = "Send hunks to quickfix" }, bufnr)

          -- Toggles
          utils.map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" }, bufnr)
          utils.map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" }, bufnr)

          -- Text Objects
          utils.map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select hunk" }, bufnr)
        end,
      })
    end,
    events = { "BufReadPre", "BufNewFile" },
  }),
})
