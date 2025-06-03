return {
    {
        "tjdevries/express_line.nvim",
        dependencies = { "AndreM222/copilot-lualine" },
        config = function()
            require("droes/plugin.statusline").setup()
        end,
    },
}
--[[
return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = { theme = "codedark" },
        })
    end,
}
]] --
