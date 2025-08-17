local data = assert(vim.fn.stdpath("data")) --[[@as string]]
local telescope_loaded = false
local function load_telescope()
	if not telescope_loaded then
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = { "dune.lock", "node_modules", "%.git/", "target/" },
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden", -- Search hidden files
				},
			},
			-- extensions = {
			-- 	wrap_results = true,
			-- 	["ui-select"] = {
			-- 		require("telescope.themes").get_dropdown({}),
			-- 	},
			-- 	-- history = {
			-- 	-- 	path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
			-- 	-- 	limit = 100,
			-- 	-- },
			-- },
			-- pickers = {
			-- 	find_files = {
			-- 		hidden = true, -- Show hidden files
			-- 	},
			-- },
		})
		-- pcall(require("telescope").load_extension, "ui-select")
		-- pcall(require("telescope").load_extension, "smart_history")
		telescope_loaded = true
	end
end

-- stylua: ignore
vim.keymap.set( "n", "<space>ff", function() load_telescope() require("telescope.builtin").find_files() end, { desc = "Find files" })
vim.keymap.set( "n", "<space>fgf", function() load_telescope() require("telescope.builtin").git_files() end, { desc = "Find git files" })
vim.keymap.set( "n", "<space>fh", function() load_telescope() require("telescope.builtin").help_tags() end, { desc = "Find help tags" })
vim.keymap.set( "n", "<space>fl", function() load_telescope() require("telescope.builtin").live_grep() end, { desc = "Live grep" })
vim.keymap.set( "n", "<space>@", function() load_telescope() require("telescope.builtin").registers() end, { desc = "Show registers" })
vim.keymap.set( "n", "<space>lk", function() load_telescope() require("telescope.builtin").keymaps() end, { desc = "Show keymaps" })
vim.keymap.set( "n", "<space>lc", function() load_telescope() require("telescope.builtin").colorscheme() end, { desc = "Change colorscheme" })
vim.keymap.set( "n", "<space>lcm", function() load_telescope() require("telescope.builtin").commands() end, { desc = "Show commands" })
vim.keymap.set( "n", "<space>lac", function() load_telescope() require("telescope.builtin").autocommands() end, { desc = "Show autocommands" })

