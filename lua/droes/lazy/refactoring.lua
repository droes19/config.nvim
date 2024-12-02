return {
    --[[
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
        local factoring = require("refactoring").setup({
            require("refactoring").setup({
                -- prompt for return type
                prompt_func_return_type = {
                    go = true,
                    cpp = true,
                    c = true,
                    java = true,
                },
                -- prompt for function parameters
                prompt_func_param_type = {
                    go = true,
                    cpp = true,
                    c = true,
                    java = true,
                },
            }),
        })

        vim.keymap.set("x", "<leader>re", function()
            factoring.refactor("Extract Function")
        end)
        vim.keymap.set("x", "<leader>rf", function()
            factoring.refactor("Extract Function To File")
        end)
        -- Extract function supports only visual mode
        vim.keymap.set("x", "<leader>rv", function()
            factoring.refactor("Extract Variable")
        end)
        -- Extract variable supports only visual mode
        vim.keymap.set("n", "<leader>rI", function()
            factoring.refactor("Inline Function")
        end)
        -- Inline func supports only normal
        vim.keymap.set({ "n", "x" }, "<leader>ri", function()
            factoring.refactor("Inline Variable")
        end)
        -- Inline var supports both normal and visual mode

        vim.keymap.set("n", "<leader>rb", function()
            factoring.refactor("Extract Block")
        end)
        vim.keymap.set("n", "<leader>rbf", function()
            factoring.refactor("Extract Block To File")
        end)
        -- Extract block supports only normal mode
    end,
    ]]--
}
