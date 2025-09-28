require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    json = { "prettier" },
    -- ajoute d'autres au besoin
  },
  -- Format à l’enregistrement
  format_on_save = function(bufnr)
    -- On peut choisir d’ignorer certains filetypes
    local ignore = { "markdown" }
    if vim.tbl_contains(ignore, vim.bo[bufnr].filetype) then
      return
    end
    return { timeout_ms = 2000, lsp_fallback = true }
  end,
})
