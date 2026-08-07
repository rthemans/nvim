local map = vim.keymap.set
local builtin = require("telescope.builtin")

local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

local rg_args = {
    "--color=never", "--no-heading", "--with-filename",
    "--line-number", "--column", "--smart-case",
}

-- uv.spawn can't run .cmd/.ps1 wrappers (e.g. npm-installed rg on Windows).
-- Spawning cmd.exe /c rg delegates to the shell which resolves the .cmd wrapper.
local function shell_grep(opts)
    opts = opts or {}
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local make_entry = require("telescope.make_entry")

    pickers.new(opts, {
        prompt_title = "Live Grep",
        finder = finders.new_async_job({
            command_generator = function(prompt)
                if not prompt or prompt == "" then return nil end
                local cmd = { "cmd", "/c", "rg" }
                vim.list_extend(cmd, rg_args)
                table.insert(cmd, "--")
                table.insert(cmd, prompt)
                return cmd
            end,
            entry_maker = make_entry.gen_from_vimgrep(opts),
            cwd = vim.fn.getcwd(),
        }),
        previewer = conf.grep_previewer(opts),
        sorter = require("telescope.sorters").empty(),
    }):find()
end

local function live_grep(opts)
    if not is_windows then return builtin.live_grep(opts) end
    shell_grep(opts)
end

local function get_visual_selection()
    local regtype = vim.fn.mode():match("[vV\22]") or "v"
    local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = regtype })
    return table.concat(lines, "\n");
end

local function grep_visual(opts)
    if not is_windows then return builtin.grep_string(opts) end
    opts = opts or {}
    opts.default_text = get_visual_selection()
    shell_grep(opts)
end
-- global neovim helpers
map("n", "<leader>tr", builtin.registers, { desc = "Telescope registers" })
map("n", "<leader>ma", builtin.marks, { desc = "Telescope marks" })
map("n", "<leader>bu", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>rt", builtin.resume, { desc = "Telescope resume" })

-- Search Files
map("n", "<leader>fg", builtin.find_files, { desc = "Global Find Files" })
map("n", "<leader>ff", builtin.git_files, { desc = "Find Git Files" })

-- Search Strings
map({ "n", "v" }, "<leader>*", grep_visual, { desc = "Telescope find files under cursor" })
map("n", "<leader>lg", live_grep, { desc = "Telescope Live grep" })
map("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- Treesitter
map("n", "<leader>of", builtin.treesitter, { desc = "Telescope full treesitter output" })
map("n", "<leader>ol", function()
    builtin.treesitter({
        ignore_symbols = {
            "import",
            "parameter",
            "var"
        }
    })
end, { desc = "Telescope Outline" })

map("n", "<leader>om", function()
    builtin.treesitter({
        symbols = {
            "method",
        }
    })
end, { desc = "Telescope methods outline" })

-- GIT
map("n", "<leader>gc", builtin.git_commits, { desc = "Telescope git commits" })
map("n", "<leader>gb", builtin.git_bcommits, { desc = "Telescope git buffer commits" })
map("v", "<leader>gb", builtin.git_bcommits_range, { desc = "Telescope git buffer commits" })
map("n", "<leader>gs", builtin.git_status, { desc = "Telescope git status" })
map("n", "<leader>gf", builtin.git_files, { desc = "Git Find Files" })

-- LSP
map("n", "<leader>lq", builtin.quickfix, { desc = "Telescope quick fix" })
map("n", "<leader>lr", builtin.lsp_references, { desc = "Telescope find references" })
map("n", "<leader>li", builtin.lsp_implementations, { desc = "Telescope find implementations" })
map("n", "<leader>lc", builtin.lsp_incoming_calls, { desc = "Telescope find incoming calls" })
map("n", "<leader>lo", builtin.lsp_outgoing_calls, { desc = "Telescope find outgoing calls" })
map("n", "<leader>ld", builtin.lsp_definitions, { desc = "Telescope find definitions" })

-- Trivia
map("n", "<leader>c", function()
    builtin.colorscheme({ enable_preview = true, ignore_builtins = true })
end
, { desc = "Telescope display colorschemes" })
