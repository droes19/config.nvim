local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable realese
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local rocks = true
if vim.g.platform:match("Linux") then
    rocks = true
else
    rocks = false
end

require("lazy").setup({
	spec = "droes.lazy",
	change_detection = { notify = false },
    rocks = { enabled = rocks }
})
