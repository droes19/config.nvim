return {
  "laytan/cloak.nvim",
  ft = "sh",
  config = function()
    require("cloak").setup({
      enabled = true,
      cloak_character = "*",
    })
  end,
}
