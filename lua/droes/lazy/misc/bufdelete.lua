return {
  "famiu/bufdelete.nvim",
  cmd = { "Bdelete", "Bwipeout" },
  config = function()
    require("droes.keymaps").setup_buffer()
  end,
}
