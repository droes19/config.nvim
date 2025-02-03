local set = vim.keymap.set
local g = vim.g

g.mapleader = ","
g.maplocalleader = "\\"

g.have_nerd_font = true

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- TIP: Disable arrow keys in normal mode
set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
set('n', '<M-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<M-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<M-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<M-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
--[[-------------------------------------------------]] --
-- set("n", "<space>b", vim.cmd.Ex) -- change to oil
set("n", "<space>b", "<CMD>Oil<CR>", { desc = "Open parent directory" })
set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

set("n", "J", "mzJ`z")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")
set("n", "<leader>zig", "<cmd>LspRestart<cr>")
--
-- set("n", "<leader>vwm", function()
--     require("vim-with-me").StartVimWithMe()
-- end)
-- set("n", "<leader>svwm", function()
--     require("vim-with-me").StopVimWithMe()
-- end)

-- greatest remap ever
set("x", "<space>p", [["_dP]])

-- -- next greatest remap ever : asbjornHaland
-- set({ "n", "v" }, "<leader>y", [["+y]])
-- set("n", "<leader>Y", [["+Y]])
-- set({ "n", "v" }, "<leader>v", [["+p]])
-- set({ "n", "v" }, "<leader>d", '"_d')

set("i", "<C-c>", "<Esc>")
set("i", ":w", "<Esc>") --  sometimes i forgot to back to normal mode when i want to save

set("n", "Q", "<nop>")
-- set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
set("n", "<space>f", vim.lsp.buf.format)

set("n", "<C-k>", "<cmd>cnext<CR>zz")
set("n", "<C-j>", "<cmd>cprev<CR>zz")
set("n", "<space>k", "<cmd>lnext<CR>zz")
set("n", "<space>j", "<cmd>lprev<CR>zz")

set("n", "<space>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

set("n", "<space><space>", function()
    vim.cmd("so")
end)

set("n", "<localleader>r", "@")


vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end
})

vim.g.open_terminal = function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("L")
    vim.api.nvim_win_set_width(0,50)
    -- vim.api.nvim_win_set_height(0, 0)

    vim.g.job_id = vim.bo.channel
end

vim.g.run_term = function(c)
    print(vim.g.job_id)
    if vim.fn.winnr('$') == 1 then
        print("here")
        vim.g.open_terminal()
    end
    vim.fn.chansend(vim.g.job_id, c)
end

set("n", "<space>st", function()
    vim.g.open_terminal()
end)
set("n", "<leader>a", function()
    vim.g.run_term({ "dir\r\n" })
end)
set("t", "<C-H>", [[<C-\><C-n>]])
