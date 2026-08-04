--[[
-- Author: Raphaël Thémans
--
-- Copyright 2026 Airthems SRL
--]]

local M = {}

local function setup_highlights()
    vim.api.nvim_set_hl(0, "TablineGitAdded", { fg = "#98c379", bold = true })
    vim.api.nvim_set_hl(0, "TablineGitModified", { fg = "#edb21c", bold = true })
    vim.api.nvim_set_hl(0, "TablineGitRemoved", { fg = "#e06c75", bold = true })
    vim.api.nvim_set_hl(0, "TablineLastDot", { fg = "#61afef", bold = true })
end

setup_highlights()

_G.__tabline_last_tabpage = nil

local tabline_group = vim.api.nvim_create_augroup("TablineLastTab", { clear = true })

vim.api.nvim_create_autocmd("TabLeave", {
    group = tabline_group,
    callback = function()
        _G.__tabline_last_tabpage = vim.fn.tabpagenr()
    end,
})

vim.api.nvim_create_autocmd("TabClosed", {
    group = tabline_group,
    callback = function()
        _G.__tabline_last_tabpage = nil
    end,
})

local function get_icon(bufname, is_current)
    local has_devicons, devicons = pcall(require, "nvim-web-devicons")
    if not has_devicons then
        return ""
    end
    local filename = vim.fn.fnamemodify(bufname, ":t")
    local ext = vim.fn.fnamemodify(bufname, ":e")
    local icon, icon_hl = devicons.get_icon(filename, ext, { default = true })
    if is_current then
        return icon and (string.format("%%#%s#%s%%* ", icon_hl, icon)) or ""
    end

    return icon and (icon .. " ") or ""
end

local function get_git_stats(bufnr)
    local ok, status = pcall(function()
        return vim.b[bufnr].gitsigns_status_dict
    end)
    if not ok or not status then
        return nil
    end
    local added = status.added or 0
    local modified = status.changed or 0
    local removed = status.removed or 0
    if added == 0 and removed == 0 and modified == 0 then
        return nil
    end
    return added, modified, removed
end

local function tab_label(tabnr, is_current)
    local buflist = vim.fn.tabpagebuflist(tabnr)
    local winnr = vim.fn.tabpagewinnr(tabnr)
    local bufnr = buflist[winnr]
    local bufname = vim.fn.bufname(bufnr)

    local filename = vim.fn.fnamemodify(bufname, ":t")
    if filename == "" then
        filename = "[No Name]"
    end

    local icon = get_icon(bufname, is_current)

    local added, modified, removed = get_git_stats(bufnr)
    local parts = {}
    if (added and added > 0) then
        table.insert(parts, string.format("%%#TablineGitAdded#+%d%%*", added))
    end
    if (modified and modified > 0) then
        table.insert(parts, string.format("%%#TablineGitModified#~%d%%*", modified))
    end
    if (removed and removed > 0) then
        table.insert(parts, string.format("%%#TablineGitRemoved#-%d%%*", removed))
    end

    local git_part = ""
    local tabColor = is_current and "%#TabLineSel#" or "%#TabLine#"
    if #parts > 0 then
        git_part = string.format("%s(%s%s) ", tabColor, table.concat(parts, " "), tabColor)
    end

    local is_last_visited = tabnr == _G.__tabline_last_tabpage
    local dot = is_last_visited and " %#TablineLastDot#●%*" or ""

    return string.format(" %s%s%s%s ", icon, git_part, filename, dot)
end

local augroup = vim.api.nvim_create_augroup("TablineGitSigns", { clear = true })

vim.api.nvim_create_autocmd("User", {
    pattern = "GitSignsUpdate",
    group = augroup,
    callback = function()
        vim.cmd("redrawtabline")
    end,
})

function M.render()
    local s = ""
    local total = vim.fn.tabpagenr("$")

    for i = 1, total do
        local is_current = i == vim.fn.tabpagenr()
        s = s .. (is_current and "%#TabLineSel#" or "%#TabLine#")
        s = s .. "%" .. i .. "T" -- clickable zone start, tabnr i
        s = s .. tab_label(i, is_current)
    end

    s = s .. "%#TabLineFill#%T" -- fin de la zone clickable
    return s
end

_G.tabline_render = M.render

vim.o.tabline = "%!v:lua.tabline_render()"
vim.o.showtabline = 2 -- toujours afficher la tabline

return M
