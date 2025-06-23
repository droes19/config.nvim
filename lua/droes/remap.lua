local set = vim.keymap.set
local g = vim.g

g.mapleader = ","
g.maplocalleader = "\\"

g.have_nerd_font = true

set("n", "<space><space>", function()
  vim.cmd("so")
end)

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- TIP: Disable arrow keys in normal mode
set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
set("n", "<M-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
set("n", "<M-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
set("n", "<M-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
set("n", "<M-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- set("n", "<space>b", vim.cmd.Ex) -- change to oil
set("n", "<space>b", "<CMD>Oil<CR>", { desc = "Open parent directory" })
set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")

set("n", "<space>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

set("i", ":w", "<Esc>") --  sometimes i forgot to back to normal mode when i want to save

set("t", "<C-H>", [[<C-\><C-n>]])
