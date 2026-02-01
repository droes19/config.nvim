-- only for use the utils
return {
  "nvim-java/nvim-java",
  event = "VeryLazy",
  config = function()
    require("java").setup({
      jdk = { auto_install = false },
      spring_boot_tools = { enable = false },
    })
    vim.lsp.enable("jdtls")
  end,
}
