return {
  "stevearc/aerial.nvim",
  opts = {},
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("aerial").setup({
      on_attach = function(bufnr)
        require("droes.keymaps").setup_aerial_buffer(bufnr)
      end,
    })
    require("droes.keymaps").setup_aerial()
  end,
}
