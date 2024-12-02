return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

      "nvim-telescope/telescope-smart-history.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      -- "kkharji/sqlite.lua",
    },
    config = function()
      require "droes/plugin.telescope"
    end,
  },
    --[[
}
return {
    "nvim-telescope/telescope.nvim",
    name = "telescope.nvim",
    tag = "0.1.5",

    dependencies = {
        "nvim-telescope/telescope-ui-select.nvim",
    },

    config = function()
        require("telescope").setup({
            extension = {
                require("telescope.themes").get_dropdown({}),
                require("telescope.themes").get_cursor({}),
            },
        })
        require("telescope").load_extension("ui-select")

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files)
        vim.keymap.set("n", "<leader>fg", builtin.git_files)
        vim.keymap.set("n", "<leader>fgs", builtin.grep_string)
        vim.keymap.set("n", "<leader>fl", builtin.live_grep)
        vim.keymap.set("n", "<leader>fw", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>fW", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set("n", "<leader>@", builtin.registers)
        vim.keymap.set("n", "<leader>lk", builtin.keymaps)
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
        vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions)
        vim.keymap.set('n', '<leader>gr', builtin.lsp_references)
        -- (for testing all function builtin)
        -- vim.keymap.set('n', '<leader>fd', builtin.lsp_references)
    end,
    ]]--
}
