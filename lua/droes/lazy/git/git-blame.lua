return {
  "f-person/git-blame.nvim",
  config = function()
    vim.g.gitblame_enabled = 0 -- Disable by default
    vim.g.gitblame_message_template = "<summary> • <date> • <author>"
    vim.g.gitblame_highlight_group = "LineNr"
    require("droes.keymaps").setup_git_blame()
  end,
}
