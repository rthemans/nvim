-- Fonction commune à tous les serveurs LSP
lsp_on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }

  -- Formattage si le serveur le supporte
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
    })
  end
end

lsp_capabilities = require('blink.cmp').get_lsp_capabilities()

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
-- Mise à jour des diagnostics en temps réel
vim.o.updatetime = 500
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false, close_events = {"CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", "WinLeave"} })
    end,
})

-- Auto reload quand angular.json ou tsconfig.json change
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
