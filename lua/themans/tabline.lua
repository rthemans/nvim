--[[
-- Author: Raphaël Thémans
-- 
-- Copyright 2026 Airthems SRL
--]]

-- ~/.config/nvim/lua/tabline.lua
--
-- Custom tabline:
--   [icon] [+added -removed] filename [●]  -- ● = dernier tab visité avant le tab courant
--
-- Sources:
--   - :help tabline / :help setting-tabline
--   - :help TabLeave / :help TabClosed
--   - nvim-web-devicons README (get_icon API)
--   - gitsigns.nvim README, section "Status Line" (b:gitsigns_status_dict)

local M = {}

-- Highlight groups setup (colors for added/removed + last-tab dot)
local function setup_highlights()
  vim.api.nvim_set_hl(0, "TablineGitAdded", { fg = "#98c379", bold = true }) -- vert
  vim.api.nvim_set_hl(0, "TablineGitModified", { fg = "#edb21c", bold = true }) -- rouge
  vim.api.nvim_set_hl(0, "TablineGitRemoved", { fg = "#e06c75", bold = true }) -- rouge
  vim.api.nvim_set_hl(0, "TablineLastDot", { fg = "#61afef", bold = true }) -- bleu
end

setup_highlights()

-- ---------------------------------------------------------------------
-- Tracking du "dernier tab visité avant le tab courant"
-- ---------------------------------------------------------------------
-- Neovim n'a pas d'équivalent natif à bufnr('#') pour les tabs,
-- donc on le track nous-même via TabLeave.
_G.__tabline_last_tabpage = nil

local tabline_group = vim.api.nvim_create_augroup("TablineLastTab", { clear = true })

vim.api.nvim_create_autocmd("TabLeave", {
  group = tabline_group,
  callback = function()
    _G.__tabline_last_tabpage = vim.fn.tabpagenr()
  end,
})

-- Si le tab "last" est fermé, sa référence n'a plus de sens.
-- On réinitialise pour éviter de pointer sur un mauvais tab après renumérotation.
vim.api.nvim_create_autocmd("TabClosed", {
  group = tabline_group,
  callback = function()
    _G.__tabline_last_tabpage = nil
  end,
})

-- ---------------------------------------------------------------------
-- Devicons
-- ---------------------------------------------------------------------
local function get_icon(bufname)
  local has_devicons, devicons = pcall(require, "nvim-web-devicons")
  if not has_devicons then
    return ""
  end
  local filename = vim.fn.fnamemodify(bufname, ":t")
  local ext = vim.fn.fnamemodify(bufname, ":e")
  local icon = devicons.get_icon(filename, ext, { default = true })
  return icon and (icon .. " ") or ""
end

-- ---------------------------------------------------------------------
-- Gitsigns stats
-- ---------------------------------------------------------------------
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

-- ---------------------------------------------------------------------
-- Rendu d'un tab
-- ---------------------------------------------------------------------
local function tab_label(tabnr)
  local buflist = vim.fn.tabpagebuflist(tabnr)
  local winnr = vim.fn.tabpagewinnr(tabnr)
  local bufnr = buflist[winnr]
  local bufname = vim.fn.bufname(bufnr)

  local filename = vim.fn.fnamemodify(bufname, ":t")
  if filename == "" then
    filename = "[No Name]"
  end

  local icon = get_icon(bufname)

  local added, modified, removed = get_git_stats(bufnr)
  local parts = {}
  if ( added and added > 0 ) then
      table.insert(parts, string.format("%%#TablineGitAdded#+%d%%*", added))
  end
  if ( modified and modified > 0 ) then
      table.insert(parts, string.format("%%#TablineGitModified#~%d%%*", modified))
  end
  if ( removed and removed > 0 ) then
      table.insert(parts, string.format("%%#TablineGitRemoved#-%d%%*", removed))
  end

  local git_part = ""
  if #parts > 0 then
      git_part = string.format("(%s) ", table.concat(parts, " "))
  end

  local is_last_visited = tabnr == _G.__tabline_last_tabpage
  local dot = is_last_visited and " %#TablineLastDot#●%*" or ""

  return string.format(" %s%s%s%s ", icon, git_part, filename, dot)
end

-- ---------------------------------------------------------------------
-- redrawtabline
-- ---------------------------------------------------------------------
local augroup = vim.api.nvim_create_augroup("TablineGitSigns", { clear = true })

vim.api.nvim_create_autocmd("User", {
  pattern = "GitSignsUpdate",
  group = augroup,
  callback = function()
    vim.cmd("redrawtabline")
  end,
})

-- ---------------------------------------------------------------------
-- Rendu global
-- ---------------------------------------------------------------------
function M.render()
  local s = ""
  local total = vim.fn.tabpagenr("$")

  for i = 1, total do
    local is_current = i == vim.fn.tabpagenr()
    s = s .. (is_current and "%#TabLineSel#" or "%#TabLine#")
    s = s .. "%" .. i .. "T" -- clickable zone start, tabnr i
    s = s .. tab_label(i)
  end

  s = s .. "%#TabLineFill#%T" -- fin de la zone clickable
  return s
end

_G.tabline_render = M.render

vim.o.tabline = "%!v:lua.tabline_render()"
vim.o.showtabline = 2 -- toujours afficher la tabline

return M
