local map = vim.keymap.set

-- includes
map('n', '<leader>id', function()
    return vim.fn.strftime('%Y-%m-%d')
end, { desc = "include date in place", expr = true })

-- pairs
map("i", "<>", "<><left>", { desc = "Enter into angled brackets" })
map("i", "()", "()<left>", { desc = "Enter into round brackets" })
map("i", "{}", "{}<left>", { desc = "Enter into curly brackets" })
map("i", "[]", "[]<left>", { desc = "Enter into square brackets" })
map("i", '""', '""<left>', { desc = "Enter into double quotes" })
map("i", "''", "''<left>", { desc = "Enter into single quotes" })
map("i", "``", "``<left>", { desc = "Enter into backticks" })

-- terminal
map("t", "<C-q>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- background util
map("n", "<leader>bc", function()
    vim.cmd [[
      highlight Normal guibg=none
      highlight NonText guibg=none
      highlight Normal ctermbg=none
      highlight NonText ctermbg=none
    ]]
end, { desc = "Make background transparent" })
