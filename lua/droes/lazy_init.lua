local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", --latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- Core functionality
    { import = "droes.lazy.core" },

    -- User interface
    { import = "droes.lazy.ui" },

    -- Git integration
    { import = "droes.lazy.git" },

    -- Text editing
    { import = "droes.lazy.editing" },

    -- Development tools
    { import = "droes.lazy.tools" },

    -- Miscellaneous
    { import = "droes.lazy.misc" },

    -- Individual files that don't fit categories
    { import = "droes.lazy" },
  },
  change_detection = { notify = false },
})
