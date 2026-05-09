vim.lsp.config("vtsls", {
  settings = {
    --   -- vtsls can pass through tsserver settings
    --   vtsls = {
    --     tsserver = {
    --       maxTsServerMemory = 2048, -- cap RAM (adjust 1024–2048 based on project size)
    --       experimental = {
    --         -- avoid extra projects by not auto probing npm/yarn/pnpm globally
    --         enableProjectDiagnostics = false, -- reduces global diag churn
    --       },
    --     },
    --   },
    typescript = {
      format = { enable = false }, -- rely on prettier or eslint to avoid server formatting cost
      workspaceSymbols = {scope= "currentProject"},
      tsserver = {
        -- log = "verbose",
        enableTracing = true,
      }
    },
    vtsls = {
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
          entriesLimit = 15,
        }
      }
    },
    javascript = {
      --     inlayHints = {
      --       includeInlayParameterNameHints = "all",
      --       includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      --       includeInlayFunctionParameterTypeHints = true,
      --       includeInlayVariableTypeHints = false,
      --       includeInlayPropertyDeclarationTypeHints = false,
      --       includeInlayFunctionLikeReturnTypeHints = true,
      --       includeInlayEnumMemberValueHints = false,
      --     },
      format = { enable = false },
      --     preferences = {
      --       includeCompletionsForModuleExports = false,
      --     },
    },
  },
  -- flags = { debounce_text_changes = 250 },
  server_capabilities = {
    semanticTokensProvider = vim.NIL,
  },
})
vim.lsp.enable("vtsls")
