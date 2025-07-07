-- Setup tree sitter
require'nvim-treesitter.configs'.setup {
    refactor = {
        highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
        },
        highlight_current_scope = {enable = false},
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "<leader>tsr",
            },
        },
    },

    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },

    indent = { enable = false },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
        },
    },

     textobjects = {
         select = {
             enable = true,
             lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
             keymaps = {
                 -- You can use the capture groups defined in textobjects.scm
                 ['aa'] = '@parameter.outer',
                 ['ia'] = '@parameter.inner',
                 ['af'] = '@function.outer',
                 ['if'] = '@function.inner',
                 ['ac'] = '@class.outer',
                 ['ic'] = '@class.inner',
             },
         },

         move = {
             enable = true,
             set_jumps = true, -- whether to set jumps in the jumplist
             goto_next_start = {
                 ['<leader>ni'] = '@conditional.outer',
                 ['<leader>nm'] = '@function.outer',
                 ['<leader>nc'] = '@class.outer',
                 ['<leader>np'] = '@parameter.outer',
             },
             goto_previous_start = {
                 ['<leader>pi'] = '@conditional.outer',
                 ['<leader>pm'] = '@function.outer',
                 ['<leader>pc'] = '@class.outer',
                 ['<leader>pp'] = '@parameter.outer',
             },
         },

         swap = {
             enable = true,
             swap_next = {
                 ['<leader>a'] = '@parameter.inner',
             },
             swap_previous = {
                 ['<leader>A'] = '@parameter.inner',
             },
         },
     },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs();
parser_config.java = {
    install_info = { 
        url = "/home/dev-rthemans@int.buyway.net/.config/nvim/parsers/java/",
        files = { "src/parser.c" },
    },
    filetype = "java",
};
parser_config.html = {
    install_info = {
        url = "/home/dev-rthemans@int.buyway.net/.config/nvim/parsers/html/",
        files = { "src/parser.c", "src/scanner.c" },
    },
    filetype = "html",
}
parser_config.css = {
    install_info = {
        url = "/home/dev-rthemans@int.buyway.net/.config/nvim/parsers/css/",
        files = { "src/parser.c", "src/scanner.c" },
    },
    filetype = "css",
}
parser_config.query = {
    install_info = {
        url = "/home/dev-rthemans@int.buyway.net/.config/nvim/parsers/query/",
        files = { "src/parser.c" },
    },
    filetype = "query",
}

parser_config.javascript = {
    install_info = {
        url = "/home/dev-rthemans@int.buyway.net/.config/nvim/parsers/javascript/",
        files = { "src/parser.c", "src/scanner.c" },
    },
    filetype = "javascript",
}
require("treesitter-context").setup({
})

