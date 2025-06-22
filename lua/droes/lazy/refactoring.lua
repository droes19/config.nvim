return {
  "ThePrimeagen/refactoring.nvim",
  lazy = false,
  opts = {
    prompt_func_return_type = {
      go = true,
      cpp = true,
      c = true,
      java = true,
    },
    -- prompt for function parameters
    prompt_func_param_type = {
      go = true,
      cpp = true,
      c = true,
      java = true,
    },
  },
  config = function()
    local refactoring = require("refactoring")
    vim.keymap.set({ "n", "x" }, "<leader>re", function()
      return refactoring.refactor("Extract Function")
    end, { expr = true })

    vim.keymap.set({ "n", "x" }, "<leader>rf", function()
      return refactoring.refactor("Extract Function To File")
    end, { expr = true })

    vim.keymap.set({ "n", "x" }, "<leader>rv", function()
      return refactoring.refactor("Extract Variable")
    end, { expr = true })

    vim.keymap.set({ "n", "x" }, "<leader>rI", function()
      return refactoring.refactor("Inline Function")
    end, { expr = true })

    vim.keymap.set({ "n", "x" }, "<leader>ri", function()
      return refactoring.refactor("Inline Variable")
    end, { expr = true })

    vim.keymap.set({ "n", "x" }, "<leader>rbb", function()
      return refactoring.refactor("Extract Block")
    end, { expr = true })

    vim.keymap.set({ "n", "x" }, "<leader>rbf", function()
      return refactoring.refactor("Extract Block To File")
    end, { expr = true })
  end,
}
