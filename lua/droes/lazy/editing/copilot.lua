return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
      desc = "Accept Copilot suggestion",
    })
    vim.g.copilot_filetypes = {
      ["*"] = false,
      ["javascript"] = true,
      ["typescript"] = true,
      ["lua"] = true,
      ["java"] = true,
      ["python"] = true,
    }
  end,
}
