local map = vim.keymap.set

map({ 'i', 's', 'n' }, "gb", "<cmd>e #<cr>", { desc = "go back to alternate buffer" })
