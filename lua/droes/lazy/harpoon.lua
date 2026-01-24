local default_harpoon = function()
  local M = {}
  local harpoon = require("harpoon"):setup({
    settings = {
      key = function()
        return vim.loop.cwd()
      end,
    },
    default = {
      get_root_dir = function()
        return vim.loop.cwd()
      end,
    },
  })
  function M.toggle()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end
  function M.add()
    harpoon:list():add()
  end
  function M.select(index)
    harpoon:list():select(index)
  end
  return M
end
local notes_harpoon = function()
  local M = {}
  local harpoon = require("harpoon"):setup({
    settings = {
      key = function()
        return "notes"
      end,
    },
    default = {
      get_root_dir = function()
        return vim.fn.stdpath("data") .. "/notes"
      end,
    },
  })
  function M.toggle()
    harpoon.ui:toggle_quick_menu(harpoon:list("notes"))
  end
  function M.add()
    harpoon:list("notes"):add()
  end
  return M
end
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  -- stylua: ignore
  keys = {
    { "<space>a", function() default_harpoon().add() end, desc = "Add file to harpoon" },
    { "<space>e", function() default_harpoon().toggle() end, desc = "Toggle harpoon menu" },
    { "<space>1", function() default_harpoon().select(1) end, desc = "Go to harpoon file 1" },
    { "<space>2", function() default_harpoon().select(2) end, desc = "Go to harpoon file 2" },
    { "<space>3", function() default_harpoon().select(3) end, desc = "Go to harpoon file 3" },
    { "<space>4", function() default_harpoon().select(4) end, desc = "Go to harpoon file 4" },
    { "<space>5", function() default_harpoon().select(5) end, desc = "Go to harpoon file 5" },
    { "<space>6", function() default_harpoon().select(6) end, desc = "Go to harpoon file 6" },
    { "<space>7", function() default_harpoon().select(7) end, desc = "Go to harpoon file 7" },
    { "<space>8", function() default_harpoon().select(8) end, desc = "Go to harpoon file 8" },
    { "<space>9", function() default_harpoon().select(9) end, desc = "Go to harpoon file 9" },
    { "<M-p>", function() require("harpoon"):list():prev() end, desc = "Previous harpoon file" },
    { "<M-n>", function() require("harpoon"):list():next() end, desc = "Next harpoon file" },
    { "<space>n", function() notes_harpoon().toggle() end, desc = "Toggle notes menu" },
    { "<space>na", function() notes_harpoon().add() end, desc = "Add file note" },
  },
  opts = {},
}
