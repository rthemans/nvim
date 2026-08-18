-- my remappings
require("remap.telescope")
require("remap.utils")
require("remap.jdtls")
require("remap.lsp")
require("remap.buffer")
require("remap.oil")
require("remap.spider")

local map = vim.keymap.set

map({ 'i', 's', 'n' }, '<Tab>', function()
    if vim.snippet.active({ direction = 1 }) then
        return '<cmd>lua vim.snippet.jump(1)<cr>'
    else
        print("no active snippet")
        return '<Tab>'
    end
end, { expr = true })
