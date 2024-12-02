return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
                -- used for completion, annotations and signatures of Neovim apis
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "luvit-meta/library", words = { "vim%.uv" } },
                    },
                },
            },
            { "Bilal2453/luvit-meta",                        lazy = true },
            -- "williamboman/mason.nvim",
            -- "williamboman/mason-lspconfig.nvim",
            -- "WhoIsSethDaniel/mason-tool-installer.nvim",
            { "j-hui/fidget.nvim",                           opts = {} },
            { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
            -- { "elixir-tools/elixir-tools.nvim" },
            -- Autoformatting
            "stevearc/conform.nvim",
            -- Schema information
            "b0o/SchemaStore.nvim",

            { dir = "C:/Projects/Program/nvim-plugin/mason.nvim" },
        },
        config = function()
            local capabilities = nil
            if pcall(require, "cmp_nvim_lsp") then
                capabilities = require("cmp_nvim_lsp").default_capabilities()
            end
            local lspconfig = require "lspconfig"
            local servers = {
                --   bashls = true,
                lua_ls = {
                    cmd = { "C:/Users/idrus^kaafi/Projects/lsp/lua_ls/bin/lua-language-server" },
                    server_capabilities = {
                        semanticTokensProvider = vim.NIL,
                    },
                },
                -- jdtls = {
                -- cmd = { "C:/Projects/Program/lsp/jdt_ls/bin/jdtls" },
                -- },
                -- jdtls = true,
            }

            local servers_to_install = vim.tbl_filter(function(key)
                local t = servers[key]
                if type(t) == "table" then
                    return not t.manual_install
                else
                    return t
                end
            end, vim.tbl_keys(servers))

            require("mason").setup({
                log_level = vim.log.levels.DEBUG
            })
            local ensure_installed = {
                "stylua",
                "lua_ls",
            }

            vim.list_extend(ensure_installed, servers_to_install)

            for name, config in pairs(servers) do
                if config == true then
                    config = {}
                end
                config = vim.tbl_deep_extend("force", {}, {
                    capabilities = capabilities,
                }, config)

                lspconfig[name].setup(config)
            end

            local disable_semantic_tokens = {
                lua = true,
            }

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

                    local settings = servers[client.name]
                    if type(settings) ~= "table" then
                        settings = {}
                    end

                    local builtin = require "telescope.builtin"

                    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
                    vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
                    vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
                    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

                    vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
                    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
                    vim.keymap.set("n", "<space>wd", builtin.lsp_document_symbols, { buffer = 0 })

                    local filetype = vim.bo[bufnr].filetype
                    if disable_semantic_tokens[filetype] then
                        client.server_capabilities.semanticTokensProvider = nil
                    end

                    -- Override server capabilities
                    if settings.server_capabilities then
                        for k, v in pairs(settings.server_capabilities) do
                            if v == vim.NIL then
                                ---@diagnostic disable-next-line: cast-local-type
                                v = nil
                            end

                            client.server_capabilities[k] = v
                        end
                    end
                end,
            })

            -- require("custom.autoformat").setup()
            local conform = require "conform"
            conform.setup({
                formatters = {
                    ["stylua"] = {
                        command = "C:/Users/idrus^kaafi/Projects/lsp/stylua/stylua",
                        args = {
                            -- "--config-path", "C:/Users/idrus^kaafi/Projects/lsp/stylua/stylua.toml",
                            "--enable-outside-detected-project",
                            "--name", "$FILENAME",
                            "-",
                        },
                    },
                    ["google-java-format"] = {
                        command = "C:/Users/idrus^kaafi/Projects/lsp/google-java-format/google-java-format",
                        args = {
                            -- "--config-path", "C:/Users/idrus^kaafi/Projects/lsp/stylua/stylua.toml",
                            "--enable-outside-detected-project",
                            "--name", "$FILENAME",
                            "-",
                        },
                    }
                },
                formatters_by_ft = {
                    lua = { "stylua" },
                    java = { "google-java-format" },
                }
            })

            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("custom-conform", { clear = true }),
                callback = function(args)
                    require("conform").format {
                        bufnr = args.buf,
                        lsp_fallback = true,
                        quiet = true,
                    }
                end
            })

            require("lsp_lines").setup()
            vim.diagnostic.config { virtual_text = true, virtual_lines = false }

            vim.keymap.set("", "<leader>l", function()
                local config = vim.diagnostic.config() or {}
                if config.virtual_text then
                    vim.diagnostic.config { virtual_text = false, virtual_lines = true }
                else
                    vim.diagnostic.config { virtual_text = true, virtual_lines = false }
                end
            end, { desc = "Toggle lsp_lines" })

            -- require("custom.elixir").setup()
        end,
    },
}
