local pack = require("pack")

pack.add({
  { src = "catppuccin/nvim", name = "catppuccin" },
  "folke/tokyonight.nvim",
})
vim.cmd.colorscheme("catppuccin")
-- vim.cmd.colorscheme("vim")
