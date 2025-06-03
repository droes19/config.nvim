local lsp = {
    bashls = true,
    gopls = {
        settings = {
            gopls = {
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                },
            },
        },
    },
    lua_ls = {
        server_capabilities = {
            semanticTokensProvider = vim.NIL,
        },
    },
    rust_analyzer = true,
    jsonls = {
        server_capabilities = {
            documentFormattingProvider = false,
        },
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
            },
        },
    },
    yamlls = {
        settings = {
            yaml = {
                schemaStore = {
                    enable = false,
                    url = "",
                },
                -- schemas = require("schemastore").yaml.schemas(),
            },
        },
    },
    tailwindcss = {
        init_options = {
            userLanguages = {
                elixir = "phoenix-heex",
                eruby = "erb",
                heex = "phoenix-heex",
            },
        },
        -- filetypes = extend("tailwindcss", "filetypes", { "ocaml.mlx" }),
        settings = {
            tailwindCSS = {
                experimental = {
                    classRegex = {
                        [[class: "([^"]*)]],
                        [[className="([^"]*)]],
                    },
                },
                -- includeLanguages = extend("tailwindcss", "settings.tailwindCSS.includeLanguages", {
                --   ["ocaml.mlx"] = "html",
                -- }),
            },
        },
    },
    jdtls = true,
    vtsls = true,
    angularls = true,
    html = true,
    gradle_ls = true,
}

local ensure_installed = {
    "stylua",
    "prettier",
}

return {
    lsp = lsp,
    ensure_installed = ensure_installed
}
