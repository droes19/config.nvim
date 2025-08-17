local showkeys_loaded = false
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if not showkeys_loaded then
			require("showkeys").setup({    maxkeys = 10,})
			require("showkeys").toggle()
			showkeys_loaded = true
		end
	end,
	once = true
})
