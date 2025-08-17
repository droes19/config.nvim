CustomOilBar = function()
	local path = vim.fn.expand("%")
	path = path:gsub("oil://", "")

	return "  " .. vim.fn.fnamemodify(path, ":.")
end


require("oil").setup({
	columns = { "icon" },
	keymaps = {
		["<M-h>"] = "actions.select_split",
		["<M-v>"] = "actions.select_vsplit",
		["<M-t>"] = "actions.select_tab",
		["<M-p>"] = "actions.preview",
		["<C-c>"] = "actions.close",
		["<C-r>"] = "actions.refresh",
		["g?"] = "actions.show_help",
	} ,
	win_options = {
		winbar = "%{v:lua.CustomOilBar()}",
	},
	view_options = {
		show_hidden = true,
		is_always_hidden = function(name, _)
			local folder_skip = { "dev-tools.locks", "dune.lock", "_build" }
			return vim.tbl_contains(folder_skip, name)
		end,
	},
})

vim.keymap.set("n", "<space>b", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
