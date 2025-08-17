vim.pack.add{
	{src=	"https://github.com/stevearc/oil.nvim"},
	{src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2"},
	{src=	"https://github.com/nvim-lua/plenary.nvim"},
	{src=	"https://github.com/catppuccin/nvim", name = "catppuccin"},
	{src="https://github.com/norcalli/nvim-colorizer.lua"},
	{src="https://github.com/lukas-reineke/indent-blankline.nvim"},
	{src="https://github.com/karb94/neoscroll.nvim"},
	{src= "https://github.com/dstein64/vim-startuptime" },
	{src = "https://github.com/folke/noice.nvim" },
	{src = "https://github.com/MunifTanjim/nui.nvim" },
	{src = "https://github.com/rcarriga/nvim-notify" },
	{src = "https://github.com/nvzone/showkeys" },
	{src = "https://github.com/nvim-lualine/lualine.nvim" },
	{src = "https://github.com/folke/tokyonight.nvim" },
	{src = "https://github.com/nvim-telescope/telescope.nvim" },
	{src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{src = "https://github.com/nvim-telescope/telescope-smart-history.nvim" },
	{src = "https://github.com/kkharji/sqlite.lua" },
	{src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/folke/lazydev.nvim" },
	{ src = "https://github.com/Bilal2453/luvit-meta" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/hrsh7th/cmp-cmdline" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" },
	{ src = "https://github.com/onsails/lspkind.nvim" },
	{ src = "https://github.com/roobert/tailwindcss-colorizer-cmp.nvim" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/b0o/SchemaStore.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },

	-- https://github.com/
}

local plugin_setup_dir = vim.fn.stdpath("config") .. "/lua/droes/plugin-setup"
local lua_files = {}
local handle = vim.loop.fs_scandir(plugin_setup_dir)
if handle then
	while true do
		local name, type = vim.loop.fs_scandir_next(handle)
		if not name then break end

		if type == "file" and name:match("%.lua$") then
			table.insert(lua_files, name)
		end
	end
end

for _, filename in ipairs(lua_files) do
	local module_name = filename:gsub("%.lua$", "")
	local success, err = pcall(require, "droes.plugin-setup." .. module_name)
	if not success then
		print("Error loading", module_name .. ":", err)
	end
end
-- local all_files = vim.fs.find(function(name) 
	--     return true 
	-- end, { path = plugin_setup_dir, type = "file" })
	--
	-- print("All files found:")
	-- for i, file in ipairs(all_files) do
	--     print(i, file)
	-- end
	--
	-- local lua_files = vim.fs.find(function(name)
		-- 	return name:match("%.lua$")
		-- end, { path = plugin_setup_dir, type = "file" })
		-- print(vim.inspect(lua_files))
		--
		-- for _, file in ipairs(lua_files) do
		-- 	local module_name = vim.fn.fnamemodify(file, ":t:r") -- get filename without extension
		-- 	print(module_name)
		-- 	require("droes.plugin-setup." .. module_name)
		-- end
