require('jdtls').start_or_attach(jdtls_config)

vim.diagnostic.config({ virtual_lines = true })

vim.wo.number = true
vim.wo.relativenumber = true

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("mygroup", { clear = true })

autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
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
