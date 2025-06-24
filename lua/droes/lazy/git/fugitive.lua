return {
  "tpope/vim-fugitive",
  cmd = { "Git", "Gbrowse", "Gread", "Gwrite", "Gdiffsplit" },
  config = function()
    require("droes.keymaps").setup_git_enhanced()
  end,
}
