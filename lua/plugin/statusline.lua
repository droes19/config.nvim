local pack = require("pack")

pack.add({ "nvim-lualine/lualine.nvim" }, {
  load = pack.on_load({
    pkg_name = "lualine.nvim",
    setup = function()
      ---@diagnostic disable-next-line: undefined-field
      require("lualine").setup({
        option = "vim",
        -- option = "tokyonight",
        sections = {
          lualine_c = {
            { "filename", path = 1 },
            {
              function()
                return require("nvim-navic").get_location()
              end,
              cond = function()
                return require("nvim-navic").is_available()
              end,
            },
          },
        },
        -- winbar = {
        --   lualine_c = {
        --     {
        --       function()
        --         return require("nvim-navic").get_location()
        --       end,
        --       cond = function()
        --         return require("nvim-navic").is_available()
        --       end,
        --     },
        --   },
        -- },
      })
    end,
    events = "UIEnter",
  }),
})
