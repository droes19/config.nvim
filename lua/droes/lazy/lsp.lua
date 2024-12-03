local dependencies = {
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
        { "Bilal2453/luvit-meta",                        lazy = true },
        { "j-hui/fidget.nvim",                           opts = {} },
        { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
        "stevearc/conform.nvim",
        "b0o/SchemaStore.nvim",
}
if vim.g.platform:match("Linux") then
    vim.list_extend(dependencies, {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim"
    })
else 
    vim.list_extend(dependencies, {
            { dir = "C:/Projects/Program/nvim-plugin/mason.nvim" }
})
end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = dependencies,
        config = function()
            local lsp_plugin = require("droes/plugin.lsp")
            print(lsp_plugin)
            lsp_plugin.setup_mason()
            lsp_plugin.setup_conform()
            require("lsp_lines").setup()
            vim.diagnostic.config { virtual_text = true, virtual_lines = false }

            vim.keymap.set("", "<leader>l", function()
                local config = vim.diagnostic.config() or {}
                if config.virtual_text then
                    vim.diagnostic.config { virtual_text = false, virtual_lines = true }
                else
                    vim.diagnostic.config { virtual_text = true, virtual_lines = false }
                end
            end, { desc = "Toggle lsp_lines" })

            -- require("custom.elixir").setup()
        end,
    },
}
