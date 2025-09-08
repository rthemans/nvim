require("themans")
require("lsp")
require("theme")

require("remap")
vim.wo.number = true
vim.wo.relativenumber = true 

local o = vim.o

o.expandtab = true 
-- expand tab input with spaces characters
o.smartindent = true 
-- syntax aware indentations for newline inserts
o.tabstop = 4 
-- num of space characters per tab
o.shiftwidth = 4 
-- spaces per indentation level

vim.o.clipboard = 'unnamedplus'
