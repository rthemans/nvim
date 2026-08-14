-- Filetypes handled by conform — LSP formatting is skipped for these
local CONFORM_FILETYPES = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "css", "json" }

-- Fonction commune à tous les serveurs LSP
LSP_ON_ATTACH = function(client, bufnr)
    local ft = vim.bo[bufnr].filetype
    if client.server_capabilities.documentFormattingProvider and
        not vim.tbl_contains(CONFORM_FILETYPES, ft) then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
        })
    end
end

LSP_CAPABILITIES = require('blink.cmp').get_lsp_capabilities()

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',

        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
        },
        numhl = {
            [vim.diagnostic.severity.WARN] = 'WarningMsg',
        },
    },
})
vim.o.updatetime = 500
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil,
            { focusable = false, close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", "WinLeave" } })
    end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "angular.json", "tsconfig.json" },
    callback = function()
        vim.cmd("LspRestart")
    end,
})

require("lsp.java")
require("lsp.angular")
require("lsp.conform")
require("lsp.lint")
require("lsp.lua")
require("lsp.qml")

vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'
