require("telescope").setup({
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            },
        },
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "ignore_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    },

    defaults = {
        path_display={
            "smart"
        },
        vimgrep_arguments = {
            "grep",
            "--extended-regexp",
            "--color=never",
            "--with-filename",
            "--line-number",
            "-b", 
            "--ignore-case",
            "--recursive",
            "--no-messages",
            "--exclude-dir=*cache*",
            "--exclude-dir=*.git",
            "--exclude=.*",
            "--binary-files=without-match"
        },
    }
})
require("telescope").load_extension("ui-select")
