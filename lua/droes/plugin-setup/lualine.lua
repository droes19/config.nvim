require("lualine").setup({
	option = "tokyonight",
	sections = {
		lualine_c = { { "filename", path = 1 } },
	},
})
