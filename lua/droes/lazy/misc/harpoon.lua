return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = { "CmdlineEnter", "VeryLazy" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    require("droes.keymaps").setup_harpoon()
  end,
}
