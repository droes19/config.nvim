local harpoon_loaded = false
local function load_harpoon()
	if not harpoon_loaded then
		require("harpoon").setup()
		harpoon_loaded = true
	end
end

-- stylua: ignore
vim.keymap.set( "n", "<space>a", function() load_harpoon() require("harpoon"):list():add() end, { desc = "Add file to harpoon" })
vim.keymap.set( "n", "<space>e", function() load_harpoon() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, { desc = "Toggle harpoon menu" })
vim.keymap.set( "n", "<space>1", function() load_harpoon() require("harpoon"):list():select(1) end, { desc = "Go to harpoon file 1" })
vim.keymap.set( "n", "<space>2", function() load_harpoon() require("harpoon"):list():select(2) end, { desc = "Go to harpoon file 2" })
vim.keymap.set( "n", "<space>3", function() load_harpoon() require("harpoon"):list():select(3) end, { desc = "Go to harpoon file 3" })
vim.keymap.set( "n", "<space>4", function() load_harpoon() require("harpoon"):list():select(4) end, { desc = "Go to harpoon file 4" })
vim.keymap.set( "n", "<space>5", function() load_harpoon() require("harpoon"):list():select(5) end, { desc = "Go to harpoon file 5" })
vim.keymap.set( "n", "<M-p>", function() load_harpoon() require("harpoon"):list():prev() end, { desc = "Previous harpoon file" })
vim.keymap.set( "n", "<M-n>", function() load_harpoon() require("harpoon"):list():next() end, { desc = "Next harpoon file" })
