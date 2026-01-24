return {
  -- LazyDev (Lua type annotations & library definitions)
  {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = { "Bilal2453/luvit-meta" },
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  -- TailwindCSS color squares in completion
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    event = "LspAttach",
    opts = {
      color_square_width = 2,
    },
  },

  -- LuaSnip + friendly-snippets
  {
    "L3MON4D3/LuaSnip",
    lazy = false,
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    config = function()
      vim.defer_fn(function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end, 100)
    end,
  },
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = { "rafamadriz/friendly-snippets" },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    opts = {
      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = true } },

      fuzzy = { implementation = "lua" },
    },
    opts_extend = { "sources.default" },
  },

  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     { "hrsh7th/cmp-nvim-lsp" },
  --     { "hrsh7th/cmp-buffer" },
  --     { "hrsh7th/cmp-path" },
  --     { "hrsh7th/cmp-cmdline" },
  --     { "saadparwaiz1/cmp_luasnip" },
  --   },
  --   event = "InsertEnter",
  --   config = function()
  --     local cmp = require("cmp")
  --     local lspkind = require("lspkind")
  --     local tailwind_fmt = require("tailwindcss-colorizer-cmp").formatter
  --     vim.defer_fn(function()
  --       require("luasnip.loaders.from_vscode").lazy_load()
  --     end, 100)
  --
  --     vim.opt.completeopt = { "menu", "menuone", "noselect" }
  --     vim.opt.shortmess:append("c")
  --
  --     -- Unified lspkind formatter
  --     local kind_formatter = lspkind.cmp_format({
  --       mode = "symbol_text",
  --       maxwidth = 50,
  --       ellipsis_char = "…",
  --       menu = {
  --         lazydev = "[lazydev]",
  --         copilot = "[copilot]",
  --         nvim_lsp = "[LSP]",
  --         luasnip = "[snip]",
  --         buffer = "[buf]",
  --         path = "[path]",
  --       },
  --     })
  --
  --     cmp.setup({
  --       snippet = {
  --         expand = function(args)
  --           vim.snippet.expand(args.body)
  --         end,
  --       },
  --
  --       mapping = {
  --         ["<C-n>"] = cmp.mapping.select_next_item(),
  --         ["<C-p>"] = cmp.mapping.select_prev_item(),
  --         ["<C-space>"] = cmp.mapping.complete(),
  --         ["<C-y>"] = cmp.mapping.confirm({
  --           select = true,
  --         }),
  --       },
  --
  --       sources = {
  --         { name = "lazydev", group_index = 0 },
  --         { name = "copilot" },
  --         { name = "nvim_lsp" },
  --         { name = "luasnip" },
  --         { name = "path" },
  --         { name = "buffer" },
  --       },
  --
  --       formatting = {
  --         fields = { "abbr", "kind", "menu" },
  --         expandable_indicator = true,
  --         format = function(entry, item)
  --           item = kind_formatter(entry, item)
  --           item = tailwind_fmt(entry, item)
  --           return item
  --         end,
  --       },
  --
  --       sorting = {
  --         priority_weight = 2,
  --         comparators = {
  --           cmp.config.compare.offset,
  --           cmp.config.compare.exact,
  --           cmp.config.compare.score,
  --           cmp.config.compare.recently_used,
  --           cmp.config.compare.locality,
  --           cmp.config.compare.kind,
  --           cmp.config.compare.sort_text,
  --           cmp.config.compare.length,
  --           cmp.config.compare.order,
  --         },
  --       },
  --     })
  --   end,
  -- },
}
