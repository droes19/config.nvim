local root_markers = { 'gradlew', 'mvnw', '.git', 'pom.xml' }
local root_dir = require('jdtls.setup').find_root(root_markers)
-- local root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml" })

-- local workspace_folder = "~/.local/share/eclipse/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace = vim.fn.fnamemodify(root_dir, ":p:h:t")

vim.keymap.set("n", "<leader>jc", ":w<CR>:!javac %<CR>", { desc = "compile current java file" })
vim.keymap.set("n", "<leader>jr", ":w<CR>:!java %:t:r<CR>", { desc = "compile current java file" })

vim.keymap.set("n", "<leader>mc", ":w<CR>:!mvn clean install<CR>")
vim.keymap.set("n", "<leader>mj",
    function()
        vim.cmd("w")
        local jar_file = vim.fn.glob("target/" .. workspace .. "*.jar")
        vim.cmd("!java -jar " .. jar_file)
        -- ":w<CR>:!java -jar target/" .. workspace .. "*.jar<CR>"
    end
)

vim.keymap.set('n', '<localleader>i', require 'jdtls'.organize_imports)
vim.keymap.set('i', 'sout', 'System.out.println();<Esc>hi')