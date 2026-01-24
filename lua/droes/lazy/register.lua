return {
  "AckslD/nvim-neoclip.lua",
  dependencies = {
    { "kkharji/sqlite.lua", module = "sqlite" },
  },
  keys = {
    { "<space>r", "<cmd>Telescope neoclip<cr>", desc = "Neoclip" },
  },
  opts = {},
}
