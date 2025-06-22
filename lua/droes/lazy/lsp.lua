return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
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
      { "Bilal2453/luvit-meta", lazy = true },
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      { "hrsh7th/nvim-cmp", lazy = false, priority = 100 },
      -- {
      --   "saghen/blink.cmp",
      --   build = "cargo build --release",
      --   opts = {
      --     sources = {
      --       -- add lazydev to your completion providers
      --       default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      --       providers = {
      --         lazydev = {
      --           name = "LazyDev",
      --           module = "lazydev.integrations.blink",
      --           -- make lazydev completions top priority (see `:h blink.cmp`)
      --           score_offset = 100,
      --         },
      --       },
      --     },
      --     fuzzy = { implementation = "prefer_rust_with_warning" },
      --   },
      -- },
      "rafamadriz/friendly-snippets",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
      "roobert/tailwindcss-colorizer-cmp.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      "b0o/SchemaStore.nvim",
      "stevearc/conform.nvim",
      "mason-org/mason-lspconfig.nvim",
      { "mason-org/mason.nvim", opts = {} },
    },
    config = function()
      local servers = {
        lua_ls = {
          server_capabilities = {
            semanticTokensProvider = vim.NIL,
          },
        },
        jdtls = true,
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      if pcall(require, "cmp_nvim_lsp") then
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      end

      -- if pcall(require, "blink.cmp") then
      --   capabilities =  require("blink.cmp").get_lsp_capabilities(capabilities)
      -- end

      local ensure_installed = {}
      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
        }, config)

        vim.lsp.config(name, config)
        table.insert(ensure_installed, name)
      end
      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        -- automatic
      })
      local disable_semantic_tokens = {
        lua = true,
      }
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
          print(client.name)
          local settings = servers[client.name]
          if type(settings) ~= "table" then
            settings = {}
          end

          local builtin = require("telescope.builtin")

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
          vim.keymap.set("n", "gi", builtin.lsp_implementations, { buffer = 0 })
          vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
          vim.keymap.set("n", "gT", builtin.lsp_type_definitions, { buffer = 0 })
          vim.keymap.set("n", "gs", builtin.lsp_document_symbols, { buffer = 0 })

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

      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
        },
      })
      vim.keymap.set({ "n", "v" }, "<space>f", function()
        conform.format({
          require("conform").format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 500,
          }),
        })
      end)

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("custom-conform", { clear = true }),
        callback = function(args)
          require("conform").format({
            bufnr = args.buf,
            lsp_fallback = true,
            quiet = true,
          })
        end,
      })

      vim.opt.completeopt = { "menu", "menuone", "noselect" }
      vim.opt.shortmess:append("c")

      local lspkind = require("lspkind")
      lspkind.init({
        symbol_map = {
          Copilot = "",
        },
      })

      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

      local kind_formatter = lspkind.cmp_format({
        mode = "symbol_text",
        menu = {
          buffer = "[buf]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[api]",
          path = "[path]",
          luasnip = "[snip]",
          gh_issues = "[issues]",
          tn = "[TabNine]",
          eruby = "[erb]",
        },
      })

      -- Add tailwindcss-colorizer-cmp as a formatting source
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })

      local cmp = require("cmp")

      cmp.setup({
        sources = {
          {
            name = "lazydev",
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-y>"] = cmp.mapping(
            cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            }),
            { "i", "c" }
          ),
          ["<C-space>"] = cmp.mapping.complete,
        },

        -- Enable luasnip to handle snippet expansion for nvim-cmp
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },

        formatting = {
          fields = { "abbr", "kind", "menu" },
          expandable_indicator = true,
          format = function(entry, vim_item)
            -- Lspkind setup for icons
            vim_item = kind_formatter(entry, vim_item)

            -- Tailwind colorizer setup
            vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)

            return vim_item
          end,
        },

        sorting = {
          priority_weight = 2,
          comparators = {
            -- require("copilot_cmp.comparators").prioritize,

            -- Below is the default comparitor list and order for nvim-cmp
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })
    end,
  },
}
