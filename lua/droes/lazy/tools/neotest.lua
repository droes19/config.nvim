return {
  "nvim-neotest/neotest",
  cmd = { "Neotest" },
  keys = {
    {
      "<leader>tt",
      function()
        require("neotest").run.run()
      end,
      desc = "Run test",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Test summary",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("neotest").setup({})
  end,
}
