return {
  "stevearc/aerial.nvim",
  event = { "CmdlineEnter", "VeryLazy" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = require("droes.keymaps").get_aerial_keymaps(),
  config = function()
    require("aerial").setup({
      on_attach = function(bufnr)
        require("droes.keymaps").setup_aerial_buffer(bufnr)
      end,
    })
  end,
}
