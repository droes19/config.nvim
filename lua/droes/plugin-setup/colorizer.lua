vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    callback = function()
        require("colorizer").setup()
    end,
    once = true
})
