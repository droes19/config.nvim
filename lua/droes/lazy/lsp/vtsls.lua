return {
  settings = {
    -- vtsls can pass through tsserver settings
    vtsls = {
      tsserver = {
        maxTsServerMemory = 2048, -- cap RAM (adjust 1024–2048 based on project size)
        experimental = {
          -- avoid extra projects by not auto probing npm/yarn/pnpm globally
          enableProjectDiagnostics = false, -- reduces global diag churn
        },
      },
    },
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = false, -- disable
        includeInlayPropertyDeclarationTypeHints = false, -- disable
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = false, -- disable
      },
      format = { enable = false }, -- rely on prettier or eslint to avoid server formatting cost
      preferences = {
        includeCompletionsForModuleExports = false, -- fewer completion expansions
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = false,
        includeInlayPropertyDeclarationTypeHints = false,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = false,
      },
      format = { enable = false },
      preferences = {
        includeCompletionsForModuleExports = false,
      },
    },
  },
  flags = { debounce_text_changes = 250 },
}
