local servers = {
  angularls = { config = require("droes/lazy/lsp/angularls") },
  bashls = { config = require("droes/lazy/lsp/bashls") },
  cssls = { config = require("droes/lazy/lsp/cssls") },
  -- eslint={},
  -- gradle_ls = {},
  html = { config = require("droes/lazy/lsp/html") },
  -- jdtls = {},
  jsonls = {},
  lemminx = { config = require("droes/lazy/lsp/lemminx") },
  lua_ls = { name = "lua-language-server", config = require("droes/lazy/lsp/lua_ls"), version = "3.14.0" },
  vtsls = { config = require("droes/lazy/lsp/vtsls") },
  tailwindcss = { name = "tailwindcss-language-server", config = require("droes/lazy/lsp/tailwindcss") },
  yamlls = {},
  -- zls={},
}
local additionals = {
  stylua = {},
  prettierd = {},
  ["google-java-format"] = {},
}
local ensure_installed = {}
local add_ensure_installed = function(t)
  for name, tab in pairs(t) do
    -- print(name)
    name = tab.name or name
    -- print(name)
    if tab.version then
      table.insert(ensure_installed, { name, version = tab.version })
    end
    table.insert(ensure_installed, name)
  end
end
add_ensure_installed(servers)
add_ensure_installed(additionals)

return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      { "saghen/blink.cmp" },
      { "neovim/nvim-lspconfig" },
      { "b0o/schemastore.nvim" },
      { "SmiteshP/nvim-navic" },
    },
    lazy = false,
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
      })
      -- servers.jdtls.config = require("droes/lazy/lsp/jdtls")
      servers.jsonls.config = require("droes/lazy/lsp/jsonls")
      servers.yamlls.config = require("droes/lazy/lsp/yamlls")

      local navic = require("nvim-navic")
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      for name, tab in pairs(servers) do
        if tab.config == true then
          tab.config = {}
        end
        tab.config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            if client.servers_capabilities ~= nil then
              if client.servers_capabilities.documentSymbolProvider then
                navic.attach(client, bufnr)
              end
            -- else
            --   navic.attach(client, bufnr)
            end
          end,
        }, tab.config)
        vim.lsp.config(name, tab.config)
      end
      require("mason-lspconfig").setup()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          local settings = servers[client.name]
          if type(settings) ~= "table" then
            settings = {}
          end

          local has_telescope = pcall(require, "telescope.builtin")

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

          local map = require("droes.keymaps").map
          if has_telescope then
            local builtin = require("telescope.builtin")
            map("n", "gd", builtin.lsp_definitions, { desc = "Go to definition" }, bufnr)
            map("n", "gi", builtin.lsp_implementations, { desc = "Go to implementation" }, bufnr)
            map("n", "gr", builtin.lsp_references, { desc = "Go to references" }, bufnr)
            map("n", "gT", builtin.lsp_type_definitions, { desc = "Go to type definition" }, bufnr)
            map("n", "gs", builtin.lsp_document_symbols, { desc = "Document symbols" }, bufnr)
          else
            -- Fallback to built-in LSP functions
            map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" }, bufnr)
            map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" }, bufnr)
            map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" }, bufnr)
            map("n", "gT", vim.lsp.buf.type_definition, { desc = "Go to type definition" }, bufnr)
          end

          map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" }, bufnr)
          map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" }, bufnr)
          map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" }, bufnr)
          map("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" }, bufnr)
          map("n", "ga", vim.lsp.buf.code_action, { desc = "Code actions" }, bufnr)
          map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" }, bufnr)
        end,
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      window = {
        align = "top",
      },
    },
  },
}
