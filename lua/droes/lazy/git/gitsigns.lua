return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      current_line_blame = true,
      on_attach = function(bufnr)
        require("droes.keymaps").setup_git(bufnr)
      end,
    })
  end,
}
