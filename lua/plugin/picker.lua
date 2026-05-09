local pack = require("pack")

pack.add({ "ibhagwan/fzf-lua" }, {
  load = pack.on_load({
    cmd = "FzfLua",
    pkg_name = "fzf-lua",
    setup = function()
      require("fzf-lua").setup({
        lsp = { symbols = { symbol_style = 3 } },
        -- grep = {
        --   rg_opts = "--column --line-number --no-heading --color=always --smart-case --colors 'path:fg:blue'",
        -- },
        -- live_grep = {
        --   rg_opts = "--column --line-number --no-heading --color=always --smart-case --colors 'path:fg:blue'",
        -- },
        winopts = {
          preview = {
            default = true,
            builtin = {
              treesitter = { enabled = false },
            },
          },
        },
        files = { file_icons = false },
      })
      require("fzf-lua").register_ui_select()
    end,
    keys = {
      { "<space>ff", "<cmd>FzfLua files resume=true<cr>" },
      { "<space>fl", "<cmd>FzfLua live_grep resume=true<cr>" },
      { "<space>fb", "<cmd>FzfLua builtin<cr>" },
    },
  }),
})
