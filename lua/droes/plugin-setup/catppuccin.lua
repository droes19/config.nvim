require("catppuccin").setup( {
	integrations = {
		aerial = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		notify = true,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
		harpoon = true,
		telescope = {
			enabled = true,
		},
	},
})
vim.cmd.colorscheme("catppuccin")
