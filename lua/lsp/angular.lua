local cwd = vim.fn.getcwd()
local project_library_path = cwd .. "/node_modules"

local cmd = { "ngserver", "--stdio", "--tsProbeLocations", project_library_path, "--ngProbeLocations",
    project_library_path }

vim.lsp.config('angularls', {
    on_attach = LSP_ON_ATTACH,
    cmd = cmd,
    capabilities = LSP_CAPABILITIES
})




vim.lsp.enable('angularls')
