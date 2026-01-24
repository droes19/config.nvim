return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {},
  -- stylua: ignore
  keys = {
    { "<space>qs", function() require("persistence").load() end, desc = "Load session" },
    { "<space>qS", function() require("persistence").select() end, desc = "Select session" },
    { "<space>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
    { "<space>qq", function() require("persistence").stop() end, desc = "Quit without saving session" },
  },
}
