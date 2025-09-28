local cwd = vim.fn.getcwd()
local project_library_path = cwd .. "/node_modules"

local cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path}

vim.lsp.config('angularls', {
    on_attach = lsp_on_attach,
  cmd = cmd,
  capabilities = blink_capabilities
})

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

require("lspconfig").ts_ls.setup {
  on_attach = lsp_on_attach,
  capabilities = require("blink.cmp").get_lsp_capabilities(), 
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports"
    }
  }
}


vim.lsp.enable('angularls')
