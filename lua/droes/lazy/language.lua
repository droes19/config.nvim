return {
  "potamides/pantran.nvim",
  -- event = "VeryLazy"
  cmd = "Pantran",
  keys = { {
    "<space>t",
    "<cmd>Pantran<CR>",
    desc = "Translate",
  } },
  opts = {
    default_engine = "google",
    controls = {
      mappings = {
        edit = {
          i = {
            ["<C-c>"] = false, -- disable pantran's "close" on Ctrl-C
            -- (keep other defaults as-is)
          },
        },
      },
    },
  },
}
