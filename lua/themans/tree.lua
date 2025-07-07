-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
local width_unit = math.floor(vim.fn.winwidth(0) * 0.1) 
local height_unit = math.floor(vim.fn.winheight(0) * 0.1)
require("nvim-tree").setup({
    view = {
        centralize_selection = true,
        side = "right",
        float = {
            enable = true,
            open_win_config = {
                width = 8 * width_unit,
                col = width_unit,
                height = math.floor( 9.5 * height_unit),
                row = height_unit,
            },
        }
    }
})
