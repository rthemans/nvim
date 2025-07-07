require("tokyonight").setup({
    style = "moon",
    transparent = true,
    day_brightness = 0.5,
    styles = {
--        sidebars = "transparent",
        floats = "normal",
    },
    on_colors = function(colors)
        colors.fg_gutter = "#b7c1e3"
    end,

    on_highlights = function(hl, c)
        local prompt = "#F5F5DC"
        hl.TelescopeNormal = {
            bg = c.bg_dark,
            fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
            bg = prompt,
        }
        hl.TelescopePromptBorder = {
            bg = prompt,
            fg = prompt,
        }
        hl.TelescopePromptTitle = {
            bg = prompt,
            fg = prompt,
        }
        hl.TelescopePreviewTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
    end,
})
