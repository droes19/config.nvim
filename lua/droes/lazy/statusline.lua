return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    option = "tokyonight",
    sections = {
      lualine_c = { { "filename", path = 1 } },
    },
  },
}
