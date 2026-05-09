local pack = require("pack")

pack.add({ "rafamadriz/friendly-snippets" })
pack.add({ { src = "saghen/blink.cmp", version = "v1" } }, {
  load = pack.on_load({
    pkg_name = "blink.cmp",
    setup = function()
      require("blink-cmp").setup({
        completion = { documentation = { auto_show = true } },
        fuzzy = { implementation = "lua" },
      })
    end,
    events = {"LspAttach", "InsertEnter"},
  }),
})
pack.add({ "roobert/tailwindcss-colorizer-cmp.nvim" }, {
  load = pack.on_load({
    pkg_name = "tailwindcss-colorizer-cmp.nvim",
    setup = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end,
    events = {"LspAttach", "InsertEnter"},
  }),
})
