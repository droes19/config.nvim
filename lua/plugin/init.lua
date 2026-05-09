local pack = require("pack")

pack.add({ "nvim-lua/plenary.nvim" })

require("plugin.colorscheme")
require("plugin.buffer")
require("plugin.editor")
require("plugin.git")
require("plugin.picker")
require("plugin.navigation")
require("plugin.treesitter")

-- in order
require("plugin.completion")
require("plugin.lsp")
require("plugin.statusline")

require("plugin.diagnostic")
require("plugin.formatter")
require("plugin.startuptime")
require("plugin.lint")
require("plugin.game")
