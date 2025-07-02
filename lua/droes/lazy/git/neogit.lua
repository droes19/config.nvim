return {
  "NeogitOrg/neogit",
  dependencies = { "sindrets/diffview.nvim" },
  event = { "CmdlineEnter", "VeryLazy" },
  opts = {},
  config = function()
    require("droes.keymaps").setup_neogit()
  end,
}
