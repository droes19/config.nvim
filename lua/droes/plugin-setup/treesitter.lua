vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	callback = function()
		require'nvim-treesitter.configs'.setup {
			modules = {},
			-- stylua: ignore
			ensure_installed = { "java", "bash", "fish" },
			sync_install = false,
			auto_install = true,
			ignore_install = {"lua", "vim", "nu", "vimdoc"},
			highlight = {
				enable = true,
				disable = {},
				additional_vim_regex_highlighting = { "markdown" },
			},

		}
		-- Run the build command (equivalent to build = ":TSUpdate")
		vim.schedule(function()
			vim.cmd("TSUpdate")
		end)
	end,
	once = true,
	desc = "Load treesitter on first buffer"
})
