local cwd = vim.fn.getcwd()
local project_library_path = cwd .. "/node_modules"

local cmd = { "ngserver", "--stdio", "--tsProbeLocations", project_library_path, "--ngProbeLocations",
    project_library_path }

vim.lsp.config('angularls', {
    on_attach = LSP_ON_ATTACH,
    cmd = cmd,
    capabilities = LSP_CAPABILITIES
})

local function organize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

vim.lsp.config("ts_ls", {
    on_attach = LSP_ON_ATTACH,
    capabilities = LSP_CAPABILITIES,
    commands = {
        OrganizeImports = {
            organize_imports,
            description = "Organize Imports"
        }
    }
})


vim.lsp.enable('angularls')
vim.lsp.enable('ts_ls')
