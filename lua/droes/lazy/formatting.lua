return {
  "stevearc/conform.nvim",
  event = "LspAttach",
  config = function()
    local conform = require("conform")

    -- Main formatter configuration
    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        html = { "prettierd" },
        htmlangular = { "prettierd" },
        json = { "prettierd" },
        java = { "google-java-format" },
        typescript = { "prettierd" },
        nu = { "topiary_nu" },
      },

      formatters = {
        topiary_nu = {
          command = "topiary",
          args = { "format", "--language", "nu" },
        },
      },
    })

    -- Load your custom keymaps for formatting
    require("droes.keymaps").map({ "n", "v" }, "<space>f", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = "Format code" })

    -- Auto format on save
    local group = vim.api.nvim_create_augroup("custom-conform", { clear = true })

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      callback = function(args)
        conform.format({
          bufnr = args.buf,
          async = true,
          quiet = true,
          lsp_fallback = true,
        })
      end,
    })
  end,
}
