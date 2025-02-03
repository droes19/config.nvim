local server_linux = function()
    return {
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
        ts_ls = {
            root_dir = require("lspconfig").util.root_pattern "package.json",
            single_file = false,
            server_capabilities = {
                documentFormattingProvider = false,
            },
        },
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
    }
end

local server_windows = function()
    local home = vim.fn.expand("$HOME")
    local root_markers = { "gradlew", "mvnw", ".git", "pom.xml" }
    local root_dir = require("jdtls.setup").find_root(root_markers)
    print(root_dir)
    local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
    local javaPath = os.getenv("JAVA_HOME") and "C:/Projects/Program/java/jdk-21.0.1" or
        "/usr/lib/jvm/java-21-openjdk-amd64"
    local lombokJar = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"
    local launcherJar = vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
    local configPath = os.getenv("JAVA_HOME") and vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_win"
        or vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_linux"
    local java_runtimes = {
        { name = "JavaSE-21", path = javaPath },
    }
    if not vim.g.platform:match("Linux") then
        vim.list_extend(java_runtimes, {
            {
                name = "JavaSE-1.8",
                path = os.getenv("JAVA_HOME"),
            },
        })
    end
    local server = {
        lua_ls = {
            cmd = { "C:/Users/idrus^kaafi/Projects/lsp/lua_ls/bin/lua-language-server" },
            server_capabilities = {
                semanticTokensProvider = vim.NIL,
            },
        },
        vtsls = {
            cmd = { "vtsls", "--stdio" }
        },
        angularls = {
            cmd = {
                'node',
                'C:/Projects/Program/node/node_modules/@angular/language-server/index.js',
                '--stdio',
                '--tsProbeLocations',
                'C:/Projects/Program/node/node_modules/@angular/language-server/node_modules',
                '--ngProbeLocations',
                'C:/Projects/Program/node/node_modules/@angular/language-server/node_modules',
            },
            on_new_config = function(new_config, new_root_dir)
                new_config.cmd = {
                    'node',
                    'C:/Projects/Program/node/node_modules/@angular/language-server/index.js',
                    '--stdio',
                    '--tsProbeLocations',
                    new_root_dir .. '/node_modules',
                    '--ngProbeLocations',
                    new_root_dir .. '/node_modules',
                }
            end,
        },
        tailwindcss = {
            cmd = {
                'tailwindcss-language-server', '--stdio'
            },
        },
        html = {
            cmd = { "vscode-html-language-server", '--stdio' }
        },
    }
    return server;
end
local setup_mason = function()
    require "mason".setup()
    -- require("lspconfig").jdtls.setup({
    --     log_level = vim.log.levels.DEBUG
    -- })
    local servers = {}

    if vim.g.platform:match("Linux") then
        servers = server_linux()
    else
        servers = server_windows()
    end
    local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == "table" then
            return not t.manual_install
        else
            return t
        end
    end, vim.tbl_keys(servers))


    local ensure_installed = {
        "stylua",
        -- "lua_ls",
        "prettier",
    }
    vim.list_extend(ensure_installed, servers_to_install)

    if vim.g.platform:match("Linux") then
        require("mason-tool-installer").setup { ensure_installed = ensure_installed }
    end

    local capabilities = nil
    if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").default_capabilities()
    end
    local lspconfig = require "lspconfig"
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
end

local setup_conform = function()
    local conform = require "conform"
    local formatters = {}
    if not vim.g.platform:match("Linux") then
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
            ["sql-formatter"] = {
                command = "sql-formatter"
            }
        }
    end
    conform.setup({
        formatters = formatters,
        formatters_by_ft = {
            lua = { "stylua" },
            -- javascript = { 'prettier' },
            -- typescript = { 'prettier' },
            css = { 'prettier' },
            scss = { 'prettier' },
            html = { 'prettier' },
            json = { 'prettier' },
            sql = { "sql-formatter" },
        }
    })

    -- vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
    --     conform.format({
    --         require("conform").format {
    --             lsp_fallback = true,
    --             async = false,
    --             timeout_ms = 500,
    --         }
    --     })
    -- end)

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
end

return {
    setup_mason = setup_mason,
    setup_conform = setup_conform
}
