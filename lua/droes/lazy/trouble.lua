return {
    --[[
    "folke/trouble.nvim",
    config = function()
        require("trouble").setup({
            icons = false,
        })
        local trouble = require "trouble"
        local view
        vim.keymap.set("n", "<leader>tt", function()
            trouble.toggle("diagnostics")
            -- view = trouble.open("diagnostics").new({win = {}})
        end)
        --
        vim.keymap.set("n", "[t", function()
            print(view)
            trouble.next(view, {skip_groups = true, jump = true})
        end)
        --
        x
        vim.keymap.set("n", "]t", function()
            trouble.prev(view, {skip_groups = true, jump = true})
        end)
    end,
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>cs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>cl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
    ]]--
}
