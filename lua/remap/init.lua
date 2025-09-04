-- my remappings
-- vim.keymap.set("v", "<leader>r", '"hy:.,$s/<C-r>h//gc<left><left><left>')
-- doing this through lsp buf rename
local map = vim.keymap.set
map("n", ";", "<S-a>;<Esc>")

map({ 'i', 's' , 'n'}, '<Tab>', function()
    if vim.snippet.active({ direction = 1 }) then
        return '<cmd>lua vim.snippet.jump(1)<cr>'
    else
        print("no active snippet")
        return '<Tab>'
    end
end, { expr = true })

-- common jdtls mappings
local jdtls = require("jdtls")
map("n", "<leader>oi", jdtls.organize_imports, bufopts, "Organize imports")
map("n", "<leader>v", jdtls.extract_variable, bufopts, "extract variable")
map("v", "<leader>v", "[[<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>]]", bufopts, "extract variable")
map("n", "<leader>em", jdtls.extract_method, bufopts, "extract method")
map("v", "<leader>em", "[[<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>]]", bufopts, "extract method")

-- builtin lsp mappings
map("n", "<leader>a", vim.lsp.buf.code_action, bufopts)
map("n", "<leader>r", vim.lsp.buf.rename, bufopts)
map("n", "<leader>=", vim.lsp.buf.format, bufopts)
map("n", "<leader>jd", vim.lsp.buf.hover, bufopts)

-- oil mappings
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- nvim tree
local nvimTree = require("nvim-tree.api")
map("n", "<leader>tt", function()nvimTree.tree.toggle({ find_file = true}) end, bufopts, "nvim tree: toggle tree")

-- spider
map({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>")
map({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>")
map({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>")

-- telescope
local builtin = require("telescope.builtin")
map("n", "<leader>tr", builtin.registers, { desc = "Telescope registers"})
map("n", "<leader>m", builtin.marks, { desc = "Telescope marks" })
map("n", "<leader>*", builtin.grep_string, { desc = "Telescope find files under cursor" })
map("v", "<leader>*", builtin.grep_string, { desc = "Telescope find files under cursor" })
map("n", "<leader>lg", builtin.live_grep, { desc = "Telescope Live grep" })
map("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ")});
end)
map("n", "<leader>of", builtin.treesitter, { desc = "Telescope full treesitter output"})
map("n", "<leader>o", function()
    builtin.treesitter({
        ignore_symbols = {
            "import",
            "parameter",
            "var"
        }
    })
end, { desc = "Telescope Outline"})

map("n", "<leader>om", function()
    builtin.treesitter({
        symbols = {
            "method",
        }
    })
end, { desc = "Telescope methods outline"})

map("n", "<leader>qf", builtin.quickfix, { desc = "Telescope quick fix"})
map("n", "<leader>gc", builtin.git_commits , { desc = "Telescope git commits"})
map("n", "<leader>gf", builtin.git_files , { desc = "Telescope git files"})
map("n", "<leader>gb", builtin.git_bcommits , { desc = "Telescope git buffer commits"})
map("v", "<leader>gb", builtin.git_bcommits_range , { desc = "Telescope git buffer commits"})
map("n", "<leader>gs", builtin.git_status , { desc = "Telescope git status"})
map("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers"})

map("n", "<leader>re", builtin.lsp_references, { desc = "Telescope find references"})
map("n", "<leader>ii", builtin.lsp_implementations , { desc = "Telescope find implementations"})
map("n", "<leader>ic", builtin.lsp_incoming_calls , { desc = "Telescope find incoming calls"})
map("n", "<leader>oc", builtin.lsp_outgoing_calls , { desc = "Telescope find outgoing calls"})
map("n", "<leader>d", builtin.lsp_definitions , { desc = "Telescope find definitions"})

map("n", "<leader>rt", builtin.resume, { desc = "Telescope resume"})

-- Insert Mode Helpers
map("i", "<>", "<><left>", { desc = "Enter into angled brackets" })
map("i", "()", "()<left>", { desc = "Enter into round brackets" })
map("i", "{}", "{}<left>", { desc = "Enter into curly brackets" })
map("i", "[]", "[]<left>", { desc = "Enter into square brackets" })
map("i", '""', '""<left>', { desc = "Enter into double quotes" })
map("i", "''", "''<left>", { desc = "Enter into single quotes" })
map("i", "``", "``<left>", { desc = "Enter into backticks" })

