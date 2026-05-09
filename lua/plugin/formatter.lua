local pack = require("pack")
local utils = require("utils")

pack.add({ "stevearc/conform.nvim" }, {
  load = pack.on_load({
    pkg_name = "conform.nvim",
    events = "LspAttach",
    setup = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          html = { "biome" },
          htmlangular = { "prettierd" },
          json = { "biome" },
          java = { "google-java-format" },
          typescript = { "biome" },
          nu = { "topiary_nu" },
        },
        formatters = {
          topiary_nu = {
            command = "topiary",
            args = { "format", "--language", "nu" },
          },
        },
      })
      utils.map({ "n", "v" }, "<space>f", function()
        conform.format({ lsp_callback = true, async = true, quiet = true })
      end, { desc = "Format Code" })

      -- local conform_on_save_group = vim.api.nvim_create_augroup("conform_on_save", { clear = true })
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   group = conform_on_save_group,
      --   callback = function(args)
      --     conform.format({
      --       bufnr = args.buf,
      --       lsp_fallback = true,
      --       async = true,
      --       quiet = true,
      --     })
      --   end,
      -- })
    end,
  }),
})
