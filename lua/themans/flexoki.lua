require("flexoki").setup({
    plugins = {
        "nvim_treesitter_context",
    }
})

require("lualine").setup({
    options = {
        theme = "flexoki",
    },
})

vim.o.background = "light"
