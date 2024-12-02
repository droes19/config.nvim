vim.keymap.set("n", "<leader>jc", ":w<CR>:!javac %<CR>", {desc= "compile current java file"})
vim.keymap.set("n", "<leader>jr", ":w<CR>:!java %:t:r<CR>", {desc= "compile current java file"})

vim.keymap.set({"n","i"}, "<localleader>pu", "<ESC>ipublic ")
vim.keymap.set({"n","i"}, "<localleader>pr", "<ESC>iprivate ")
vim.keymap.set({"n","i"}, "<localleader>s", "<ESC>iString ")
vim.keymap.set({"n","i"}, "<localleader>t", "<ESC>itrue ")
vim.keymap.set({"n","i"}, "<localleader>f", "<ESC>ifalse ")


vim.keymap.set('n', '<localleader>i', require 'jdtls'.organize_imports)
vim.keymap.set('i', 'sout', 'System.out.println();<Esc>hi')