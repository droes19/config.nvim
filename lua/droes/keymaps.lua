local set = vim.keymap.set

-- ============================================================================
-- LEADER KEYS
-- ============================================================================
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- ============================================================================
-- GENERAL KEYMAPS
-- ============================================================================

-- Reload configuration
set("n", "<space><space>", "<cmd>so<CR>", { desc = "Reload configuration" })

-- Clear search highlights
set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Disable arrow keys (training wheels)
set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>', { desc = "Remind to use h instead of left arrow" })
set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>', { desc = "Remind to use l instead of right arrow" })
set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>', { desc = "Remind to use k instead of up arrow" })
set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>', { desc = "Remind to use j instead of down arrow" })

-- Quick save from insert mode
set("i", ":w", "<Esc>", { desc = "Exit insert mode (when trying to save)" })

-- ============================================================================
-- WINDOW NAVIGATION
-- ============================================================================
set("n", "<M-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
set("n", "<M-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
set("n", "<M-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
set("n", "<M-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- ============================================================================
-- FILE NAVIGATION
-- ============================================================================
set("n", "<space>b", "<CMD>Oil<CR>", { desc = "Open parent directory" })
set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- ============================================================================
-- TEXT MANIPULATION
-- ============================================================================

-- Move selected lines up/down
set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better search navigation (keep cursor centered)
set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Better page navigation (keep cursor centered)
set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Search and replace word under cursor
set(
  "n",
  "<space>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Search and replace word under cursor" }
)

-- ============================================================================
-- TERMINAL
-- ============================================================================
set("t", "<C-H>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- ============================================================================
-- INSERT MODE SHORTCUTS
-- ============================================================================

-- Java
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    set("i", "sout", "System.out.println();<Esc>hi", { buffer = true, desc = "System.out.println snippet" })
  end,
})

-- TypeScript/JavaScript
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  callback = function()
    set("i", "clog", "console.log();<Esc>hi", { buffer = true, desc = "console.log snippet" })
  end,
})

-- ============================================================================
-- TELESCOPE KEYMAPS
-- ============================================================================
local function setup_telescope_keymaps()
  local builtin = require("telescope.builtin")

  -- File navigation
  set("n", "<space>ff", builtin.find_files, { desc = "Find files" })
  set("n", "<space>fgf", builtin.git_files, { desc = "Find git files" })
  set("n", "<space>fh", builtin.help_tags, { desc = "Find help tags" })
  set("n", "<space>fl", builtin.live_grep, { desc = "Live grep" })

  -- Utilities
  set("n", "<space>@", builtin.registers, { desc = "Show registers" })
  set("n", "<space>lk", builtin.keymaps, { desc = "Show keymaps" })
  set("n", "<space>lc", builtin.colorscheme, { desc = "Change colorscheme" })
  set("n", "<space>lcm", builtin.commands, { desc = "Show commands" })
  set("n", "<space>lac", builtin.autocommands, { desc = "Show autocommands" })
end

-- ============================================================================
-- HARPOON KEYMAPS
-- ============================================================================
local function setup_harpoon_keymaps()
  local harpoon = require("harpoon")

  set("n", "<space>a", function()
    harpoon:list():add()
  end, { desc = "Add file to harpoon" })

  set("n", "<space>e", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, { desc = "Toggle harpoon menu" })

  -- Quick navigation to harpooned files
  for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
    set("n", string.format("<space>%d", idx), function()
      harpoon:list():select(idx)
    end, { desc = string.format("Go to harpoon file %d", idx) })
  end

  set("n", "<M-p>", function()
    harpoon:list():prev()
  end, { desc = "Previous harpoon file" })

  set("n", "<M-n>", function()
    harpoon:list():next()
  end, { desc = "Next harpoon file" })
end

-- ============================================================================
-- GIT KEYMAPS (GITSIGNS)
-- ============================================================================
local function setup_git_keymaps(bufnr)
  local gitsigns = require("gitsigns")

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    set(mode, l, r, opts)
  end

  -- Navigation
  map("n", "]c", function()
    if vim.wo.diff then
      vim.cmd.normal({ "]c", bang = true })
    else
      gitsigns.nav_hunk("next")
    end
  end, { desc = "Next git hunk" })

  map("n", "[c", function()
    if vim.wo.diff then
      vim.cmd.normal({ "[c", bang = true })
    else
      gitsigns.nav_hunk("prev")
    end
  end, { desc = "Previous git hunk" })

  -- Actions
  map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
  map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })

  map("v", "<leader>hs", function()
    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "Stage hunk (visual)" })

  map("v", "<leader>hr", function()
    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "Reset hunk (visual)" })

  map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
  map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
  map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
  map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

  map("n", "<leader>hb", function()
    gitsigns.blame_line({ full = true })
  end, { desc = "Blame line" })

  map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" })
  map("n", "<leader>hD", function()
    gitsigns.diffthis("~")
  end, { desc = "Diff this (cached)" })

  map("n", "<leader>hQ", function()
    gitsigns.setqflist("all")
  end, { desc = "Send all hunks to quickfix" })
  map("n", "<leader>hq", gitsigns.setqflist, { desc = "Send hunks to quickfix" })

  -- Toggles
  map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
  map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" })

  -- Text object
  map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select hunk" })
end

-- ============================================================================
-- NEOGIT KEYMAPS
-- ============================================================================
local function setup_neogit_keymaps()
  local neogit = require("neogit")

  set("n", "<leader>g", function()
    neogit.open({ kind = "split" })
  end, { desc = "Open Neogit" })
end

-- ============================================================================
-- LSP KEYMAPS
-- ============================================================================
local function setup_lsp_keymaps(bufnr)
  local builtin = require("telescope.builtin")

  local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    set(mode, lhs, rhs, opts)
  end

  vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- LSP navigation
  map("n", "gd", builtin.lsp_definitions, { desc = "Go to definition" })
  map("n", "gi", builtin.lsp_implementations, { desc = "Go to implementation" })
  map("n", "gr", builtin.lsp_references, { desc = "Go to references" })
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
  map("n", "ga", vim.lsp.buf.code_action, { desc = "Code actions" })
  map("n", "gT", builtin.lsp_type_definitions, { desc = "Go to type definition" })
  map("n", "gs", builtin.lsp_document_symbols, { desc = "Document symbols" })
end

-- ============================================================================
-- FORMATTING KEYMAPS
-- ============================================================================
local function setup_formatting_keymaps()
  set({ "n", "v" }, "<space>f", function()
    require("conform").format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    })
  end, { desc = "Format code" })
end

-- ============================================================================
-- DIAGNOSTIC KEYMAPS
-- ============================================================================
local function setup_diagnostic_keymaps()
  vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
  set("", "<leader>l", function()
    local config = vim.diagnostic.config() or {}
    if config.virtual_text then
      vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
    else
      vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
    end
  end, { desc = "Toggle lsp_lines" })
end

-- ============================================================================
-- REFACTORING KEYMAPS
-- ============================================================================
local function setup_refactoring_keymaps()
  local refactoring = require("refactoring")

  set({ "n", "x" }, "<leader>re", function()
    return refactoring.refactor("Extract Function")
  end, { expr = true, desc = "Extract function" })

  set({ "n", "x" }, "<leader>rf", function()
    return refactoring.refactor("Extract Function To File")
  end, { expr = true, desc = "Extract function to file" })

  set({ "n", "x" }, "<leader>rv", function()
    return refactoring.refactor("Extract Variable")
  end, { expr = true, desc = "Extract variable" })

  set({ "n", "x" }, "<leader>rI", function()
    return refactoring.refactor("Inline Function")
  end, { expr = true, desc = "Inline function" })

  set({ "n", "x" }, "<leader>ri", function()
    return refactoring.refactor("Inline Variable")
  end, { expr = true, desc = "Inline variable" })

  set({ "n", "x" }, "<leader>rbb", function()
    return refactoring.refactor("Extract Block")
  end, { expr = true, desc = "Extract block" })

  set({ "n", "x" }, "<leader>rbf", function()
    return refactoring.refactor("Extract Block To File")
  end, { expr = true, desc = "Extract block to file" })
end

-- ============================================================================
-- TROUBLE KEYMAPS
-- ============================================================================
local function setup_trouble_keymaps()
  return {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  }
end

-- ============================================================================
-- OIL KEYMAPS
-- ============================================================================
local function get_oil_keymaps()
  return {
    ["<M-h>"] = "actions.select_split",
  }
end

-- ============================================================================
-- SETUP FUNCTIONS (to be called from plugin configs)
-- ============================================================================

-- Export setup functions for use in plugin configurations
local M = {}

M.setup_telescope = setup_telescope_keymaps
M.setup_harpoon = setup_harpoon_keymaps
M.setup_git = setup_git_keymaps
M.setup_neogit = setup_neogit_keymaps
M.setup_lsp = setup_lsp_keymaps
M.setup_formatting = setup_formatting_keymaps
M.setup_diagnostic = setup_diagnostic_keymaps
M.setup_refactoring = setup_refactoring_keymaps
M.get_trouble_keymaps = setup_trouble_keymaps
M.get_oil_keymaps = get_oil_keymaps

return M
