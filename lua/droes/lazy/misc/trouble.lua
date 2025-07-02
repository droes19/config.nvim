return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  event = { "CmdlineEnter", "VeryLazy" },
  config = function()
    require("droes.keymaps").setup_trouble()
  end,
}
