vim.g.mapleader = " "

require("themans.telescope")
require("themans.treesitter")
require("themans.blink")
require("themans.oil")
require("themans.colorizer")
require("themans.colorful")
require("themans.dashboard")
require("themans.header")

require("themans.tabline")

require("hardtime").setup()

vim.o.gp = "rg --vimgrep"
