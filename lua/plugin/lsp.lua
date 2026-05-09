local pack = require("pack")
local utils = require("utils")

-- pack.add({ "mason-org/mason.nvim" }, {
--   load = pack.on_load({
--     pkg_name = "mason.nvim",
--     setup = function()
--       require("mason").setup({ registries = { "github:mason-org/mason-registry", "github:nvim-java/mason-registry" } })
--     end,
--     cmd = "Mason",
--     keys = { { "<space>m", "<cmd>Mason<cr>" } },
--   }),
-- })
pack.add({ "mason-org/mason.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim" })
require("mason").setup({ registries = { "github:mason-org/mason-registry", "github:nvim-java/mason-registry" } })
-- require("mason-tool-installer").setup({
--   ensure_installed = {{"angular-language-server", version = "17.3.2"}},
-- })
pack.add({ "j-hui/fidget.nvim" }, {
  load = pack.on_load({
    pkg_name = "fidget.nvim",
    events = "LspAttach",
    setup = function()
      require("fidget").setup({ notification = { window = { align = "top" } } })
    end,
  }),
})
pack.add({ "neovim/nvim-lspconfig" })

pack.add({
  "MunifTanjim/nui.nvim",
  "mfussenegger/nvim-dap",
})
pack.add({ "nvim-java/nvim-java" }, {
  load = pack.on_load({
    pkg_name = "nvim-java",
    events = "UIEnter",
    setup = function()
      require("java").setup({
        jdk = { auto_install = false },
        spring_boot_tools = { enable = false },
        -- log = { level = "debug" },
      })
      require("lsp.jdtls")
      -- vim.lsp.enable("jdtls")
    end,
  }),
})
pack.add({ "SmiteshP/nvim-navic" }, {
  load = pack.on_load({
    pkg_name = "nvim-navic",
    setup = function()
      require("nvim-navic").setup({})
    end,
    events = "UIEnter",
  }),
})
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
    -- _ = client
    -- augment capabilities from blink.cmp
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    client.server_capabilities = vim.tbl_deep_extend("force", client.server_capabilities or {}, capabilities)

    -- attach navic if supported
    local navic = require("nvim-navic")
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end
    if
      client and vim.bo[bufnr].filetype == "java"
      or vim.bo[bufnr].filetype == "typescript"
      or vim.bo[bufnr].filetype == "javascript"
    then
      client.server_capabilities.semanticTokensProvider = nil
      -- vim.lsp.semantic_tokens.enable(false)
    end
    utils.map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" }, bufnr)
    utils.map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" }, bufnr)
    utils.map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" }, bufnr)
    utils.map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" }, bufnr)
    utils.map("n", "gT", vim.lsp.buf.type_definition, { desc = "Go to type definition" }, bufnr)
    utils.map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" }, bufnr)
    utils.map("n", "ga", "<cmd>FzfLua lsp_code_actions<cr>", { desc = "FzfLua Code actions" }, bufnr)

    vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
    utils.map("", "<leader>l", function()
      local config = vim.diagnostic.config() or {}
      if config.virtual_text then
        vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
      else
        vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
      end
    end, { desc = "Toggle lsp_lines" })
  end,
})
require("lsp")
