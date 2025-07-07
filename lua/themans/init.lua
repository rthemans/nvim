vim.g.mapleader = " "

require("themans.remap")
require("themans.telescope")
require("themans.treesitter")
require("themans.blink")
require("themans.lsp.config")
require("themans.oil")
require("themans.tree")
require("themans.colorizer")
require("themans.ufo")
require("themans.lualine")
require("themans.colorful")
require("themans.dashboard")
require("themans.header")

require("hardtime").setup()

-- themes
require("themans.theme")
require("themans.tokyonight")
require("themans.vague")
require("themans.nightfox")
require("themans.flexoki")

vim.cmd.colorscheme "kanso-pearl"

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
