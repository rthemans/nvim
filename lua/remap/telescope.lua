local map = vim.keymap.set
local builtin = require("telescope.builtin")
-- global neovim helpers
map("n", "<leader>tr", builtin.registers, { desc = "Telescope registers"})
map("n", "<leader>ma", builtin.marks, { desc = "Telescope marks" })
map("n", "<leader>bu", builtin.buffers, { desc = "Telescope buffers"})
map("n", "<leader>rt", builtin.resume, { desc = "Telescope resume"})

-- Search Files
map("n", "<leader>fg", builtin.find_files , { desc = "Global Find Files"})
map("n", "<leader>ff", builtin.git_files, { desc = "Find Git Files" })

-- Search Strings
map({"n", "v"}, "<leader>*", builtin.grep_string, { desc = "Telescope find files under cursor" })
map("n", "<leader>lg", builtin.live_grep, { desc = "Telescope Live grep" })
map("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ")});
end)

-- Treesitter
map("n", "<leader>of", builtin.treesitter, { desc = "Telescope full treesitter output"})
map("n", "<leader>ol", function()
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

-- GIT
map("n", "<leader>gc", builtin.git_commits , { desc = "Telescope git commits"})
map("n", "<leader>gb", builtin.git_bcommits , { desc = "Telescope git buffer commits"})
map("v", "<leader>gb", builtin.git_bcommits_range , { desc = "Telescope git buffer commits"})
map("n", "<leader>gs", builtin.git_status , { desc = "Telescope git status"})
map("n", "<leader>gf", builtin.git_files , { desc = "Git Find Files"})

-- LSP
map("n", "<leader>lq", builtin.quickfix, { desc = "Telescope quick fix"})
map("n", "<leader>lr", builtin.lsp_references, { desc = "Telescope find references"})
map("n", "<leader>li", builtin.lsp_implementations , { desc = "Telescope find implementations"})
map("n", "<leader>lc", builtin.lsp_incoming_calls , { desc = "Telescope find incoming calls"})
map("n", "<leader>lo", builtin.lsp_outgoing_calls , { desc = "Telescope find outgoing calls"})
map("n", "<leader>ld", builtin.lsp_definitions , { desc = "Telescope find definitions"})
