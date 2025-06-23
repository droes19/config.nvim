return {
  "NeogitOrg/neogit",
  dependencies = { "sindrets/diffview.nvim" },
  config = function()
    local neogit = require("neogit")
    neogit.setup({})
    require("droes.keymaps").setup_neogit()
  end,
}
