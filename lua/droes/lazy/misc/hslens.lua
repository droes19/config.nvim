return {
  "kevinhwang91/nvim-hlslens",
  config = function()
    require("hlslens").setup()
    require("droes.keymaps").setup_search()
  end,
}
