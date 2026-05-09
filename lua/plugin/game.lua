local pack = require("pack")

pack.add({ "jim-fx/sudoku.nvim" }, {
  load = pack.on_load({
    cmd = "Sudoku",
    pkg_name = "sudoku.nvim",
    setup = function()
      require("sudoku").setup({})
    end,
  }),
})
