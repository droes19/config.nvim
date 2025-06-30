-- ============================================================================
-- UNIFIED KEYMAP HELPER FUNCTION
-- ============================================================================
local function map(mode, lhs, rhs, opts, bufnr)
  opts = opts or {}
  if bufnr ~= nil then
    opts.buffer = bufnr
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- ============================================================================
-- LEADER KEYS
-- ============================================================================
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- ============================================================================
-- CORE KEYMAPS (Always Active)
-- ============================================================================

-- System & Configuration
map("n", "<space><space>", "<cmd>so<CR>", { desc = "Reload configuration" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Navigation Training Wheels
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>', { desc = "Remind to use h" })
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>', { desc = "Remind to use l" })
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>', { desc = "Remind to use k" })
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>', { desc = "Remind to use j" })

-- Quick Actions
map("i", ":w", "<Esc>", { desc = "Exit insert mode (when trying to save)" })
map("t", "<C-H>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- ============================================================================
-- WINDOW MANAGEMENT
-- ============================================================================
map("n", "<M-h>", "<C-w><C-h>", { desc = "Move focus to left window" })
map("n", "<M-l>", "<C-w><C-l>", { desc = "Move focus to right window" })
map("n", "<M-j>", "<C-w><C-j>", { desc = "Move focus to lower window" })
map("n", "<M-k>", "<C-w><C-k>", { desc = "Move focus to upper window" })

-- ============================================================================
-- FILE & NAVIGATION
-- ============================================================================
map("n", "<space>b", "<CMD>Oil<CR>", { desc = "Open parent directory" })
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- ============================================================================
-- TEXT EDITING & MANIPULATION
-- ============================================================================

-- Move Lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better Navigation
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Search & Replace
map(
  "n",
  "<space>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Search and replace word under cursor" }
)

-- ============================================================================
-- LANGUAGE-SPECIFIC SNIPPETS
-- ============================================================================

-- Java Snippets
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    map("i", "sout", "System.out.println();<Esc>hi", { buffer = true, desc = "System.out.println snippet" })
  end,
})

-- TypeScript/JavaScript Snippets
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  callback = function()
    map("i", "clog", "console.log();<Esc>hi", { buffer = true, desc = "console.log snippet" })
  end,
})

-- ============================================================================
-- PLUGIN SETUP FUNCTIONS
-- ============================================================================

-- Telescope Navigation
local function setup_telescope_keymaps()
  local builtin = require("telescope.builtin")

  -- File Operations
  map("n", "<space>ff", builtin.find_files, { desc = "Find files" })
  map("n", "<space>fgf", builtin.git_files, { desc = "Find git files" })
  map("n", "<space>fh", builtin.help_tags, { desc = "Find help tags" })
  map("n", "<space>fl", builtin.live_grep, { desc = "Live grep" })

  -- System Utilities
  map("n", "<space>@", builtin.registers, { desc = "Show registers" })
  map("n", "<space>lk", builtin.keymaps, { desc = "Show keymaps" })
  map("n", "<space>lc", builtin.colorscheme, { desc = "Change colorscheme" })
  map("n", "<space>lcm", builtin.commands, { desc = "Show commands" })
  map("n", "<space>lac", builtin.autocommands, { desc = "Show autocommands" })
end

-- Harpoon File Navigation
local function setup_harpoon_keymaps()
  local harpoon = require("harpoon")

  map("n", "<space>a", function()
    harpoon:list():add()
  end, { desc = "Add file to harpoon" })
  map("n", "<space>e", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, { desc = "Toggle harpoon menu" })

  -- Quick File Access
  for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
    map("n", string.format("<space>%d", idx), function()
      harpoon:list():select(idx)
    end, { desc = string.format("Go to harpoon file %d", idx) })
  end

  map("n", "<M-p>", function()
    harpoon:list():prev()
  end, { desc = "Previous harpoon file" })
  map("n", "<M-n>", function()
    harpoon:list():next()
  end, { desc = "Next harpoon file" })
end

-- Git Operations (Gitsigns)
local function setup_git_keymaps(bufnr)
  local gitsigns = require("gitsigns")

  -- Hunk Navigation
  map("n", "]c", function()
    if vim.wo.diff then
      vim.cmd.normal({ "]c", bang = true })
    else
      gitsigns.nav_hunk("next")
    end
  end, { desc = "Next git hunk" }, bufnr)

  map("n", "[c", function()
    if vim.wo.diff then
      vim.cmd.normal({ "[c", bang = true })
    else
      gitsigns.nav_hunk("prev")
    end
  end, { desc = "Previous git hunk" }, bufnr)

  -- Stage/Reset Operations
  map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" }, bufnr)
  map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" }, bufnr)
  map("v", "<leader>hs", function()
    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "Stage hunk (visual)" }, bufnr)
  map("v", "<leader>hr", function()
    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "Reset hunk (visual)" }, bufnr)

  -- Buffer Operations
  map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" }, bufnr)
  map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" }, bufnr)

  -- Preview & Information
  map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" }, bufnr)
  map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" }, bufnr)
  map("n", "<leader>hb", function()
    gitsigns.blame_line({ full = true })
  end, { desc = "Blame line" }, bufnr)

  -- Diff Operations
  map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" }, bufnr)
  map("n", "<leader>hD", function()
    gitsigns.diffthis("~")
  end, { desc = "Diff this (cached)" }, bufnr)

  -- Quickfix Integration
  map("n", "<leader>hQ", function()
    gitsigns.setqflist("all")
  end, { desc = "Send all hunks to quickfix" }, bufnr)
  map("n", "<leader>hq", gitsigns.setqflist, { desc = "Send hunks to quickfix" }, bufnr)

  -- Toggles
  map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" }, bufnr)
  map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" }, bufnr)

  -- Text Objects
  map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select hunk" }, bufnr)
end

-- Neogit Interface
local function setup_neogit_keymaps()
  local neogit = require("neogit")
  map("n", "<leader>g", function()
    neogit.open({ kind = "split" })
  end, { desc = "Open Neogit" })
end

-- LSP Operations
local function setup_lsp_keymaps(bufnr)
  local builtin = require("telescope.builtin")

  vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Navigation
  map("n", "gd", builtin.lsp_definitions, { desc = "Go to definition" }, bufnr)
  map("n", "gi", builtin.lsp_implementations, { desc = "Go to implementation" }, bufnr)
  map("n", "gr", builtin.lsp_references, { desc = "Go to references" }, bufnr)
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" }, bufnr)
  map("n", "gT", builtin.lsp_type_definitions, { desc = "Go to type definition" }, bufnr)

  -- Information
  map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" }, bufnr)
  map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" }, bufnr)
  map("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" }, bufnr)

  -- Actions
  map("n", "ga", vim.lsp.buf.code_action, { desc = "Code actions" }, bufnr)
  map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" }, bufnr)

  -- Symbols
  map("n", "gs", builtin.lsp_document_symbols, { desc = "Document symbols" }, bufnr)
end

-- Code Formatting
local function setup_formatting_keymaps()
  map({ "n", "v" }, "<space>f", function()
    require("conform").format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    })
  end, { desc = "Format code" })
end

-- Diagnostic Management
local function setup_diagnostic_keymaps()
  vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
  map("", "<leader>l", function()
    local config = vim.diagnostic.config() or {}
    if config.virtual_text then
      vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
    else
      vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
    end
  end, { desc = "Toggle lsp_lines" })
end

-- Code Refactoring
local function setup_refactoring_keymaps()
  local refactoring = require("refactoring")

  -- Extract Operations
  map({ "n", "x" }, "<leader>re", function()
    return refactoring.refactor("Extract Function")
  end, { expr = true, desc = "Extract function" })
  map({ "n", "x" }, "<leader>rf", function()
    return refactoring.refactor("Extract Function To File")
  end, { expr = true, desc = "Extract function to file" })
  map({ "n", "x" }, "<leader>rv", function()
    return refactoring.refactor("Extract Variable")
  end, { expr = true, desc = "Extract variable" })

  -- Inline Operations
  map({ "n", "x" }, "<leader>rI", function()
    return refactoring.refactor("Inline Function")
  end, { expr = true, desc = "Inline function" })
  map({ "n", "x" }, "<leader>ri", function()
    return refactoring.refactor("Inline Variable")
  end, { expr = true, desc = "Inline variable" })

  -- Block Operations
  map({ "n", "x" }, "<leader>rbb", function()
    return refactoring.refactor("Extract Block")
  end, { expr = true, desc = "Extract block" })
  map({ "n", "x" }, "<leader>rbf", function()
    return refactoring.refactor("Extract Block To File")
  end, { expr = true, desc = "Extract block to file" })
end

-- Trouble Diagnostics
local function setup_trouble_keymaps()
  map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
  map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
  map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
  map(
    "n",
    "<leader>cl",
    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    { desc = "LSP Definitions / references / ... (Trouble)" }
  )
  map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
  map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
end

-- Search Enhancement
local function setup_search_keymaps()
  local hlslens_ok, _ = pcall(require, "hlslens")
  if hlslens_ok then
    map(
      "n",
      "n",
      [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
      { desc = "Next search result (centered with hlslens)" }
    )
    map(
      "n",
      "N",
      [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
      { desc = "Previous search result (centered with hlslens)" }
    )
  else
    map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
    map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
  end
end

-- Code Outline (Aerial)
local function setup_aerial_keymaps()
  map("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial" })
end

local function setup_aerial_buffer_keymaps(bufnr)
  map("n", "{", "<cmd>AerialPrev<CR>", { desc = "Previous aerial symbol" }, bufnr)
  map("n", "}", "<cmd>AerialNext<CR>", { desc = "Next aerial symbol" }, bufnr)
end

-- Additional Git Tools
local function setup_git_blame_keymaps()
  map("n", "<leader>gb", "<cmd>GitBlameToggle<CR>", { desc = "Toggle git blame" })
end

local function setup_git_enhanced_keymaps()
  map("n", "<leader>gB", "<cmd>Gbrowse<cr>", { desc = "Git Browse" })
  map("n", "<leader>gd", "<cmd>Gdiffsplit<cr>", { desc = "Git Diff Split" })
  map("n", "<leader>gr", "<cmd>Gread<cr>", { desc = "Git Read (checkout)" })
  map("n", "<leader>gw", "<cmd>Gwrite<cr>", { desc = "Git Write (stage)" })
end

-- Buffer Management
local function setup_buffer_keymaps()
  map("n", "<leader>bd", "<cmd>Bdelete<cr>", { desc = "Delete Buffer" })
  map("n", "<leader>bD", "<cmd>Bwipeout<cr>", { desc = "Wipeout Buffer" })
  map("n", "<leader>ba", "<cmd>%bd|e#|bd#<cr>", { desc = "Delete All Buffers But Current" })
end

-- Enhanced UI (Noice)
local function setup_noice_keymaps()
  local noice_ok, noice = pcall(require, "noice")
  if not noice_ok then
    return
  end

  -- Command Line
  map("c", "<S-Enter>", function()
    noice.redirect(vim.fn.getcmdline())
  end, { desc = "Redirect Cmdline" })

  -- Message Management
  map("n", "<leader>nl", function()
    noice.cmd("last")
  end, { desc = "Noice Last Message" })
  map("n", "<leader>nh", function()
    noice.cmd("history")
  end, { desc = "Noice History" })
  map("n", "<leader>na", function()
    noice.cmd("all")
  end, { desc = "Noice All" })
  map("n", "<leader>nd", function()
    noice.cmd("dismiss")
  end, { desc = "Dismiss All" })
  map("n", "<leader>nt", function()
    noice.cmd("pick")
  end, { desc = "Noice Picker" })

  -- LSP Documentation Scrolling
  map({ "i", "n", "s" }, "<C-f>", function()
    if not require("noice.lsp").scroll(4) then
      return "<C-f>"
    end
  end, { silent = true, expr = true, desc = "Scroll Forward" })

  map({ "i", "n", "s" }, "<C-b>", function()
    if not require("noice.lsp").scroll(-4) then
      return "<C-b>"
    end
  end, { silent = true, expr = true, desc = "Scroll Backward" })
end

-- Oil File Manager Configuration
local function get_oil_keymaps()
  return {
    ["<M-h>"] = "actions.select_split",
    ["<M-v>"] = "actions.select_vsplit",
    ["<M-t>"] = "actions.select_tab",
    ["<M-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-r>"] = "actions.refresh",
    ["g?"] = "actions.show_help",
  }
end

-- ============================================================================
-- EXPORTED SETUP FUNCTIONS
-- ============================================================================

local M = {}

-- Core Plugin Setups
M.setup_telescope = setup_telescope_keymaps
M.setup_harpoon = setup_harpoon_keymaps
M.setup_git = setup_git_keymaps
M.setup_neogit = setup_neogit_keymaps
M.setup_lsp = setup_lsp_keymaps

-- Development Tools
M.setup_formatting = setup_formatting_keymaps
M.setup_diagnostic = setup_diagnostic_keymaps
M.setup_refactoring = setup_refactoring_keymaps
M.setup_search = setup_search_keymaps

-- UI Enhancements
M.setup_trouble = setup_trouble_keymaps
M.setup_aerial = setup_aerial_keymaps
M.setup_aerial_buffer = setup_aerial_buffer_keymaps
M.setup_noice = setup_noice_keymaps

-- Extended Git Tools
M.setup_git_blame = setup_git_blame_keymaps
M.setup_git_enhanced = setup_git_enhanced_keymaps

-- Utility Functions
M.setup_buffer = setup_buffer_keymaps
M.get_oil_keymaps = get_oil_keymaps

return M
