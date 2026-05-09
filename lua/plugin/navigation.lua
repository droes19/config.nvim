local pack = require("pack")

local harpoon = function(is_note)
  local M = {}
  local harpoon = require("harpoon"):setup({
    settings = {
      key = function()
        if is_note then
          return "notes"
        end
        return vim.loop.cwd()
      end,
    },
    default = {
      get_root_dir = function()
        if is_note then
          return vim.fn.stdpath("data") .. "/notes"
        end
        return vim.loop.cwd()
      end,
    },
  })
  local list = harpoon:list()
  if is_note then
    list = harpoon:list("notes")
  end
  function M.toggle()
    harpoon.ui:toggle_quick_menu(list)
  end
  function M.add()
    list:add()
  end
  function M.select(index)
    list:select(index)
  end
  return M
end
pack.add({ { src = "ThePrimeagen/harpoon", version = "harpoon2" } }, {
  load = pack.on_load({
    pkg_name = "harpoon",
    -- stylua: ignore
    keys = {
      { "<space>a", function() harpoon().add() end, desc = "Add file to harpoon" },
      { "<space>e", function() harpoon().toggle() end, desc = "Toggle harpoon menu" },
      { "<space>na", function() harpoon(true).add() end, desc = "Add file to harpoon notes" },
      { "<space>n", function() harpoon(true).toggle() end, desc = "Toggle harpoon notes menu" },
      { "<space>1", function() harpoon().select(1) end, desc = "Go to harpoon file 1" },
      { "<space>2", function() harpoon().select(2) end, desc = "Go to harpoon file 2" },
      { "<space>3", function() harpoon().select(3) end, desc = "Go to harpoon file 3" },
      { "<space>4", function() harpoon().select(4) end, desc = "Go to harpoon file 4" },
      { "<space>5", function() harpoon().select(5) end, desc = "Go to harpoon file 5" },
      { "<space>6", function() harpoon().select(6) end, desc = "Go to harpoon file 6" },
      { "<space>7", function() harpoon().select(7) end, desc = "Go to harpoon file 7" },
      { "<space>8", function() harpoon().select(8) end, desc = "Go to harpoon file 8" },
      { "<space>9", function() harpoon().select(9) end, desc = "Go to harpoon file 9" },
    },
  }),
})
