require("conform").setup({
    formatters = {
        prettier = {
            prepend_args = function()
                return {
                    "--config",
                    "C:/Users/themar/.config/nvim/lua/lsp/prettier.json",
                    "--config-precedence",
                    "prefer-file",
                };
            end
        },

    },
    formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
    },
    format_on_save = function(bufnr)
        local ignore = { "markdown" }
        if vim.tbl_contains(ignore, vim.bo[bufnr].filetype) then
            return
        end
        return { timeout_ms = 2000, lsp_fallback = true }
    end,
})
