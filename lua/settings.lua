local g = vim.g
g.mapleader = ","
g.maplocalleader = "\\"
g.loaded_netrw = 1 -- Disable netrw
g.loaded_netrwPlugin = 1

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.showmode = false
opt.clipboard = "unnamedplus"
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true

