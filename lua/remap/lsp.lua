local map = vim.keymap.set
map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename" })
map("n", "<leader>=", vim.lsp.buf.format, { desc = "LSP: Format" })
map("n", "<leader>jd", vim.lsp.buf.hover, { desc = "LSP: hover" })
map("n", "<leader>nn", vim.lsp.buf.definition, { desc = "LSP: definition" })
