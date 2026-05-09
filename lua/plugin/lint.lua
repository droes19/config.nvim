local pack = require("pack")
local utils = require("utils")

pack.add({ "mfussenegger/nvim-lint" }, {
  load = pack.on_load({
    pkg_name = "nvim-lint",
    events = "LspAttach",
    setup = function()
      require('lint').linters_by_ft = {
        -- typescript = {'biomejs'},
      }
      utils.map("n", "<space>l", function()
        require("lint").try_lint()
      end, { desc = "Format Code" })
    end,
  }),
})
