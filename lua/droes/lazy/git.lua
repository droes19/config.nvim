return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
        on_attach = function(bufnr)
          require("droes.keymaps").setup_git(bufnr)
        end,
      })
    end,
  },
  {
    "NeogitOrg/neogit",
    config = function()
      local neogit = require("neogit")
      neogit.setup({})

      require("droes.keymaps").setup_neogit()
    end,
  },
  {
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_enabled = 0 -- Disable by default
      vim.g.gitblame_message_template = "<summary> • <date> • <author>"
      vim.g.gitblame_highlight_group = "LineNr"
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup({
        diff_binaries = false,
        enhanced_diff_hl = false,
        git_cmd = { "git" },
        use_icons = true,
      })
    end,
  },
}
