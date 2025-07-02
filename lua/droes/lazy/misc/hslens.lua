return {
  "kevinhwang91/nvim-hlslens",
  event = { "CmdlineEnter", "VeryLazy" },
  config = function()
    require("hlslens").setup()
    require("droes.keymaps").setup_search()
  end,
}
