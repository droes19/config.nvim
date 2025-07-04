local setup_mason = function()
    require "mason".setup({
        registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
        }
    })
    -- require("lspconfig").jdtls.setup({
    --     log_level = vim.log.levels.DEBUG
    -- })
    local ll = {}
    if vim.g.platform:match("Linux") then
        ll = require "droes.plugin.lsp_linux"
    else
        ll = require "droes.plugin.lsp_windows"
    end
    local servers = ll.lsp
    local ensure_installed = ll.ensure_installed

    local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == "table" then
            return not t.manual_install
        else
            return t
        end
    end, vim.tbl_keys(servers))


    vim.list_extend(ensure_installed, servers_to_install)

    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

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
        if name ~= "jdtls" then
            lspconfig[name].setup(config)
        else
            lspconfig[name].setup({})
        end
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
            -- vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
            -- vim.keymap.set("n", "gi", builtin.implementations, { buffer = 0 })
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
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
            -- html = { 'prettier' },
            json = { 'prettier' },
            -- sql = { "sql-formatter" },
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
