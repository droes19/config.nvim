local notify_loaded = false
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if not notify_loaded then
			local notify = require("notify")
			notify.setup({
				background_colour = "#000000",
				fps = 30,
				icons = {
					DEBUG = "",
					ERROR = "",
					INFO = "",
					TRACE = "✎",
					WARN = "",
				},
				level = 2,
				minimum_width = 50,
				render = "default",
				stages = "fade_in_slide_out",
				timeout = 5000,
			})
			vim.notify = notify
			notify_loaded = true
		end
	end,
	once = true
})
