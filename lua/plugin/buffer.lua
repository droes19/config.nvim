local pack = require("pack")
local utils = require("utils")

pack.add({ "nvim-tree/nvim-web-devicons" })
pack.add({ "stevearc/oil.nvim" })

CustomOilBar = function()
  local path = vim.fn.expand("%")
  path = path:gsub("oil://", "")

  return "  " .. vim.fn.fnamemodify(path, ":.")
end

require("oil").setup({
  columns = { "icon" },
  win_options = {
    winbar = "%{v:lua.CustomOilBar()}",
  },
  view_options = {
    show_hidden = true,
  },
})

utils.map("n", "<space>b", "<CMD>Oil<CR>", { desc = "Open parent directory" })

pack.add({ "lukas-reineke/indent-blankline.nvim" }, {
  load = pack.on_load({
    pkg_name = "indent-blankline.nvim",
    events = { "BufReadPre", "BufNewFile" },
    setup = function()
      require("ibl").setup({
        indent = { char = "│", tab_char = "│" },
        scope = { enabled = false },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
          },
        },
      })
    end,
  }),
})
pack.add({ "karb94/neoscroll.nvim" }, {
  load = pack.on_load({
    pkg_name = "neoscroll.nvim",
    setup = function()
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
      })
    end,
    keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
  }),
})
pack.add({ "akinsho/toggleterm.nvim" }, {
  load = pack.on_load({
    pkg_name = "toggleterm.nvim",
    setup = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
    end,
    keys = { { [[<c-\>]], desc = "Toggle Terminal" } },
  }),
})
pack.add({ "rcarriga/nvim-notify" })--, "nvzone/showkeys" })
local notify = require("notify")
vim.notify = notify
-- require("showkeys").setup({
--   maxkeys = 10,
--   position = "bottom-right",
-- })
-- require("showkeys").toggle()
