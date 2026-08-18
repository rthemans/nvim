local map = vim.keymap.set
local jdtls = require("jdtls")
map("n", "<leader>oi", jdtls.organize_imports, { desc = "Organize imports" })
map("n", "<leader>v", jdtls.extract_variable, { desc = "extract variable" })
map("v", "<leader>v", "[[<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>]]", { desc = "extract variable" })
map("n", "<leader>em", jdtls.extract_method, { desc = "extract method" })
map("v", "<leader>em", "[[<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>]]", { desc = "extract method" })
