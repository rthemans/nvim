-- my remappings
-- vim.keymap.set("v", "<leader>r", '"hy:.,$s/<C-r>h//gc<left><left><left>')
-- doing this through lsp buf rename
vim.keymap.set("n", ";", "<S-a>;<Esc>")

vim.keymap.set({ 'i', 's' , 'n'}, '<Tab>', function()
    if vim.snippet.active({ direction = 1 }) then
        return '<cmd>lua vim.snippet.jump(1)<cr>'
    else
        print("no active snippet")
        return '<Tab>'
    end
end, { expr = true })

-- common jdtls mappings
local jdtls = require("jdtls")
vim.keymap.set("n", "<leader>oi", jdtls.organize_imports, bufopts, "Organize imports")
vim.keymap.set("n", "<leader>v", jdtls.extract_variable, bufopts, "extract variable")
vim.keymap.set("v", "<leader>v", "[[<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>]]", bufopts, "extract variable")
vim.keymap.set("n", "<leader>em", jdtls.extract_method, bufopts, "extract method")
vim.keymap.set("v", "<leader>em", "[[<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>]]", bufopts, "extract method")

-- builtin lsp mappings
vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, bufopts)
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, bufopts)
vim.keymap.set("n", "<leader>jd", vim.lsp.buf.hover, bufopts)

-- oil mappings
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- nvim tree
local nvimTree = require("nvim-tree.api")
vim.keymap.set("n", "<leader>t", function()nvimTree.tree.toggle({ find_file = true}) end, bufopts, "nvim tree: toggle tree")

-- spider
vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>")
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>")
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>")

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>m", builtin.marks, { desc = "Telescope marks" })
vim.keymap.set("n", "<leader>*", builtin.grep_string, { desc = "Telescope find files under cursor" })
vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Telescope Live grep" })
vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ")});
end)
vim.keymap.set("n", "<leader>of", builtin.treesitter, { desc = "Telescope full treesitter output"})
vim.keymap.set("n", "<leader>o", function()
    builtin.treesitter({
        ignore_symbols = {
            "import",
            "parameter",
            "var"
        }
    })
end, { desc = "Telescope Outline"})

vim.keymap.set("n", "<leader>om", function()
    builtin.treesitter({
        symbols = {
            "method",
        }
    })
end, { desc = "Telescope methods outline"})

vim.keymap.set("n", "<leader>qf", builtin.quickfix, { desc = "Telescope quick fix"})
vim.keymap.set("n", "<leader>gc", builtin.git_commits , { desc = "Telescope git commits"})
vim.keymap.set("n", "<leader>gf", builtin.git_files , { desc = "Telescope git files"})
vim.keymap.set("n", "<leader>gb", builtin.git_bcommits , { desc = "Telescope git blame commits"})
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers"})

vim.keymap.set("n", "<leader>re", builtin.lsp_references, { desc = "Telescope find references"})
vim.keymap.set("n", "<leader>i", builtin.lsp_implementations , { desc = "Telescope find implementations"})
vim.keymap.set("n", "<leader>ic", builtin.lsp_incoming_calls , { desc = "Telescope find incoming calls"})
vim.keymap.set("n", "<leader>oc", builtin.lsp_outgoing_calls , { desc = "Telescope find outgoing calls"})
vim.keymap.set("n", "<leader>d", builtin.lsp_definitions , { desc = "Telescope find definitions"})

vim.keymap.set("n", "<leader>rt", builtin.resume, { desc = "Telescope resume"})
