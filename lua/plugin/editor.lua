local pack = require("pack")

pack.add({ "kylechui/nvim-surround" }, {
  load = pack.on_load({
    pkg_name = "nvim-surround",
    setup = function()
      require("nvim-surround").setup()
    end,
    keys = { { "ys" }, { "ds" } },
  }),
})
pack.add({ "windwp/nvim-ts-autotag" }, {
  load = pack.on_load({
    pkg_name = "nvim-ts-autotag",
    setup = function()
      require("nvim-ts-autotag").setup()
    end,
    ft = { "html", "javascript", "javascriptreact", "typescriptreact", "tsx", "jsx", "xml", "markdown", "htmlangular" },
  }),
})
pack.add({ "windwp/nvim-autopairs" }, {
  load = pack.on_load({
    pkg_name = "nvim-autopairs",
    setup = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        enable_check_bracket_line = false,
        disable_filetype = { "TelescopePrompt", "vim" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0, -- Offset from pattern match
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "Search",
        },
      })
    end,
    events = "InsertEnter",
  }),
})
pack.add({ "godlygeek/tabular" }, {
  load = pack.on_load({
    pkg_name = "tabular",
    setup = function()
      require("tabular").setup()
    end,
    cmd = "Tabularize",
  }),
})
pack.add({ "folke/flash.nvim" }, {
  load = pack.on_load({
    pkg_name = "flash.nvim",
    setup = function()
      require("flash").setup({
        modes = {
          char = {
            keys = { "f", "F", "t", "T", ";", [","] = "'" },
          },
        },
      })
    end,
    keys = {
      "f",
      "F",
      "t",
      "T",
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
    },
  }),
})
pack.add({ "laytan/cloak.nvim" }, {
  load = pack.on_load({
    pkg_name = "cloak.nvim",
    setup = function()
      require("cloak").setup({
        enabled = true,
        cloak_character = "*",
        patterns = {
          file_pattern = { ".env*", "application.properties", "application-*.properties" },
        },
      })
    end,
    ft = { "sh", "jproperties" },
  }),
})
