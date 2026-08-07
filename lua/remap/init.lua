-- my remappings
-- vim.keymap.set("v", "<leader>r", '"hy:.,$s/<C-r>h//gc<left><left><left>')
-- doing this through lsp buf rename
require("remap.telescope")

local map = vim.keymap.set
map("n", ";", "<S-a>;<Esc>")

map({ 'i', 's', 'n' }, '<Tab>', function()
    if vim.snippet.active({ direction = 1 }) then
        return '<cmd>lua vim.snippet.jump(1)<cr>'
    else
        print("no active snippet")
        return '<Tab>'
    end
end, { expr = true })

map({ 'i', 's', 'n' }, "gb", "<cmd>e #<cr>", { desc = "go back to alternate buffer" })

-- common jdtls mappings
local jdtls = require("jdtls")
map("n", "<leader>oi", jdtls.organize_imports, { desc = "Organize imports" })
map("n", "<leader>v", jdtls.extract_variable, { desc = "extract variable" })
map("v", "<leader>v", "[[<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>]]", { desc = "extract variable" })
map("n", "<leader>em", jdtls.extract_method, { desc = "extract method" })
map("v", "<leader>em", "[[<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>]]", { desc = "extract method" })

-- builtin lsp mappings
map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename" })
map("n", "<leader>=", vim.lsp.buf.format, { desc = "LSP: Format" })
map("n", "<leader>jd", vim.lsp.buf.hover, { desc = "LSP: hover" })
map("n", "<leader>nn", vim.lsp.buf.definition, { desc = "LSP: definition" })

-- oil mappings
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- spider
map({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>")
map({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>")
map({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>")

-- Insert Mode Helpers
map("i", "<>", "<><left>", { desc = "Enter into angled brackets" })
map("i", "()", "()<left>", { desc = "Enter into round brackets" })
map("i", "{}", "{}<left>", { desc = "Enter into curly brackets" })
map("i", "[]", "[]<left>", { desc = "Enter into square brackets" })
map("i", '""', '""<left>', { desc = "Enter into double quotes" })
map("i", "''", "''<left>", { desc = "Enter into single quotes" })
map("i", "``", "``<left>", { desc = "Enter into backticks" })

-- exit terminal with Ctrl+q
map("t", "<C-q>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

map("n", "<leader>bc", function()
    vim.cmd [[
      highlight Normal guibg=none
      highlight NonText guibg=none
      highlight Normal ctermbg=none
      highlight NonText ctermbg=none
    ]]
end, { desc = "Make background transparent" })
