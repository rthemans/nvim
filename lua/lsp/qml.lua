vim.lsp.config("qmlls", {
    on_attach = LSP_ON_ATTACH,
    capabilities = LSP_CAPABILITIES,
})

vim.lsp.enable("qmlls")
