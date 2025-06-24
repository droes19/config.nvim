return {
  "LunarVim/bigfile.nvim",
  opts = {
    filesize = 2, -- size in MB
    pattern = { "*" },
    features = {
      "indent_blankline",
      "illuminate",
      "lsp",
      "treesitter",
      "syntax",
      "matchparen",
      "vimopts",
      "filetype",
    },
  },
}
