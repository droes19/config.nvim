return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      option = "tokyonight",
      sections = {
        lualine_c = { { "filename", path = 1 } },
      },
    })
  end,
}
