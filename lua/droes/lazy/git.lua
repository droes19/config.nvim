return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = true,
      current_line_blame_formatter = "<author>, (<author_time:%d-%m-%Y %H:%M:%S>) <author_time:%R> - <summary>",
      -- stylua: ignore
      on_attach = function(bufnr)
        local map = require("droes.keymaps").map
        local gitsigns = require("gitsigns")

        -- Hunk Navigation
        map("n", "]c", function() if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gitsigns.nav_hunk("next") end end, { desc = "Next git hunk" }, bufnr)

        map("n", "[c", function() if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gitsigns.nav_hunk("prev") end end, { desc = "Previous git hunk" }, bufnr)

        -- Stage/Reset Operations
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" }, bufnr)
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" }, bufnr)
        map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage hunk (visual)" }, bufnr)
        map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset hunk (visual)" }, bufnr)

        -- Buffer Operations
        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" }, bufnr)
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" }, bufnr)

        -- Preview & Information
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" }, bufnr)
        map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" }, bufnr)
        map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "Blame line" }, bufnr)

        -- Diff Operations
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" }, bufnr)
        map("n", "<leader>hD", function() gitsigns.diffthis("~") end, { desc = "Diff this (cached)" }, bufnr)

        -- Quickfix Integration
        map("n", "<leader>hQ", function() gitsigns.setqflist("all") end, { desc = "Send all hunks to quickfix" }, bufnr)
        map("n", "<leader>hq", gitsigns.setqflist, { desc = "Send hunks to quickfix" }, bufnr)

        -- Toggles
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" }, bufnr)
        map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" }, bufnr)

        -- Text Objects
        map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select hunk" }, bufnr)
      end,
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      {
        "sindrets/diffview.nvim",
        opts = { diff_binaries = false, enhanced_diff_hl = false, git_cmd = { "git" }, use_icons = true },
      },
    },
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>g", function() require("neogit").open({ kind = "split" }) end, desc = "Open Neogit" },
    },
  },
  {
    "akinsho/git-conflict.nvim",
    dependencies = { "yorickpeterse/nvim-pqf" },
    version = "*",
    opts = {},
    cmd = "GitConflictListQf",
  },
}
