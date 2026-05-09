local function map(mode, lhs, rhs, opts, bufnr)
  opts = opts or {}
  if bufnr ~= nil then
    opts.buffer = bufnr
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map("i", ":w", "<Esc>", { desc = "Exit insert mode (when trying to save)" })
map("t", "<C-H>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- ============================================================================
-- WINDOW MANAGEMENT
-- ============================================================================
map("n", "<M-h>", "<C-w><C-h>", { desc = "Move focus to left window" })
map("n", "<M-l>", "<C-w><C-l>", { desc = "Move focus to right window" })
map("n", "<M-j>", "<C-w><C-j>", { desc = "Move focus to lower window" })
map("n", "<M-k>", "<C-w><C-k>", { desc = "Move focus to upper window" })

-- Move Lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

map(
  "n",
  "<space>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Search and replace word under cursor" }
)


map("n", "<leader>ta", ":Tab ")
-- ============================================================================
-- LANGUAGE-SPECIFIC SNIPPETS
-- ============================================================================

-- Java Snippets
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function(ev)
    vim.treesitter.start()
    map("i", "sout", "System.out.println();<Esc>hi", { buffer = true, desc = "System.out.println snippet" })
  end,
})

-- TypeScript/JavaScript Snippets
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  callback = function()
    vim.treesitter.start()
    map("i", "clog", "console.log();<Esc>hi", { buffer = true, desc = "console.log snippet" })
  end,
})
