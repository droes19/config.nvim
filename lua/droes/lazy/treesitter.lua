return {
  "nvim-treesitter/nvim-treesitter",
  -- tag = "v0.10.0",
  lazy = false,
  build = ":TSUpdate",
  opts = {
    modules = {},
    ensure_installed = { "lua", "java" },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "markdown" },
    },
  },
}
