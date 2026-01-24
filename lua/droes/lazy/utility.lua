local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" 󰁂 %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

return {
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   dependencies = "kevinhwang91/promise-async",
  --   event = "VeryLazy",
  --   opts = {},
  --   init = function()
  --     vim.o.foldcolumn = "1" -- '0' is not bad
  --     vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  --     vim.o.foldlevelstart = 99
  --     vim.o.foldenable = true
  --   end,
  --   config = function()
  --     require("ufo").setup({
  --       fold_virt_text_handler = handler,
  --     })
  --
  --     vim.keymap.set("n", "zR", require("ufo").openAllFolds)
  --     vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
  --     vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
  --     vim.keymap.set("n", "<leader>K", function()
  --       local _ = require("ufo").peekFoldedLinesUnderCursor()
  --     end, {
  --       desc = "Preview folded maps",
  --     })
  --   end,
  -- },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")
      notify.setup({
        background_colour = "#000000",
        fps = 30,
        icons = {
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "✎",
          WARN = "",
        },
        level = 2,
        minimum_width = 50,
        render = "default",
        stages = "fade_in_slide_out",
        timeout = 5000,
      })
      vim.notify = notify
    end,
  },
  {
    "nvzone/showkeys",
    event = "VeryLazy",
    opts = {
      maxkeys = 10,
      position = "bottom_left",
    },
    config = function(_, opts)
      require("showkeys").setup(opts)
      require("showkeys").toggle()
    end,
  },
  {
    -- "folke/noice.nvim",
    -- event = { "CmdlineEnter", "VeryLazy" },
    -- dependencies = {
    --   "MunifTanjim/nui.nvim",
    --   "rcarriga/nvim-notify",
    -- },
    -- opts = {
    --   lsp = {
    --     override = {
    --       ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --       ["vim.lsp.util.stylize_markdown"] = true,
    --       ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    --     },
    --     progress = {
    --       enabled = false,
    --     },
    --     documentation = {
    --       view = "hover",
    --       opts = {
    --         lang = "markdown",
    --         replace = true,
    --         render = "plain",
    --         format = { "{message}" },
    --         win_options = { concealcursor = "n", conceallevel = 3 },
    --       },
    --     },
    --   },
    --
    --   presets = {
    --     bottom_search = true,
    --     command_palette = true,
    --     long_message_to_split = true,
    --     inc_rename = false,
    --     lsp_doc_border = false,
    --   },
    --
    --   health = {
    --     checker = false, -- Disable if it is annoying
    --   },
    --
    --   smart_move = {
    --     enabled = true, -- noice tries to move out of the way of existing floating windows
    --     excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
    --   },
    --   routes = {
    --     -- Route long messages to split
    --     {
    --       filter = {
    --         event = "msg_show",
    --         min_height = 10,
    --       },
    --       view = "split",
    --     },
    --     -- Route search messages to mini view
    --     {
    --       filter = {
    --         event = "msg_show",
    --         kind = "search_count",
    --       },
    --       opts = { skip = true },
    --     },
    --     -- Hide written messages
    --     {
    --       filter = {
    --         event = "msg_show",
    --         kind = "",
    --         find = "written",
    --       },
    --       opts = { skip = true },
    --     },
    --     -- Hide yank messages
    --     {
    --       filter = {
    --         event = "msg_show",
    --         kind = "",
    --         find = "yanked",
    --       },
    --       opts = { skip = true },
    --     },
    --     -- Hide search wrap messages
    --     {
    --       filter = {
    --         event = "msg_show",
    --         kind = "wmsg",
    --         find = "search hit",
    --       },
    --       opts = { skip = true },
    --     },
    --   },
    -- },
    -- keys = require("droes.keymaps").get_noice_keymaps(),
    -- config = function(_, opts)
    --   require("noice").setup(opts)
    --
    --   -- Show notification when starting macro recording
    --   vim.api.nvim_create_autocmd("RecordingEnter", {
    --     callback = function()
    --       local msg = string.format("Recording macro to register: %s", vim.fn.reg_recording())
    --
    --       _MACRO_RECORDING_STATUS = true
    --       vim.notify(msg, vim.log.levels.INFO, {
    --         title = "Macro Recording",
    --         keep = function()
    --           return _MACRO_RECORDING_STATUS
    --         end,
    --       })
    --     end,
    --     group = vim.api.nvim_create_augroup("NoiceMacroNotfication", { clear = true }),
    --   })
    --
    --   vim.api.nvim_create_autocmd("RecordingLeave", {
    --     callback = function()
    --       _MACRO_RECORDING_STATUS = false
    --       vim.notify("Macro recording completed!", vim.log.levels.INFO, {
    --         title = "Macro Recording End",
    --         icon = "✓",
    --         timeout = 2000,
    --       })
    --     end,
    --     group = vim.api.nvim_create_augroup("NoiceMacroNotficationDismiss", { clear = true }),
    --   })
    -- end,
  },
  {
    "laytan/cloak.nvim",
    ft = { "sh", "jproperties" },
    opts = {
      enabled = true,
      cloak_character = "*",
      patterns = {
        file_pattern = { ".env*", "application.properties", "application-*.properties" },
      },
    },
  },
}
