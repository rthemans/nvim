vim.lsp.config("ts_ls", {
    on_attach = function(client, bufnr)
        LSP_ON_ATTACH(client, bufnr)
        vim.lsp.linked_editing_range.enable(true, { bufnr = bufnr, client_id = client.id })
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr, client_id = client.id })
    end,
    capabilities = LSP_CAPABILITIES,
    settings = {
        codeActionsOnSave = {
            source = {
                organizeImports = true
            }
        },
        typescript = {
            format = {
                enabled = false,
            },
            referencesCodeLens = {
                enabled = true,
                showOnAllFunctions = true
            },
            implementationsCodeLens = {
                enabled = true,
                showOnInterfaceMethods = true,
                showOnAllClassMethods = true,
            },
            inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            }
        }
    }
})

vim.lsp.enable('ts_ls')
