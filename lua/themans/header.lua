require("header").setup({
    file_name = false,
    author = nil,
    project = nil,
    date_created = false,
    date_modified = false,
    line_separator = "",
    copyright_text = "Copyright 2025 Buy Way Personal Finance",
    license_from_file = false,
})
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("mygroup", { clear = true })

autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        print("header")
        local header = require("header")
        if header and header.update_date_modified then
            header.update_date_modified()
        else
            vim.notify_once("header.update_date_modified is not available", vim.log.levels.WARN)
        end
    end,
    group = "mygroup",
    desc = "Update header's date modified",
})
