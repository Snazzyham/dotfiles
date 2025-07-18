-- HamBlue Light Neovim Color Scheme

local M = {}
local colors = {
  bg           = "#F4F4F9",
  fg           = "#000000",
  dark_blue    = "#2F4550",
  medium_blue  = "#577787",
  light_blue   = "#B8DBD9",
  white        = "#000000",
}

function M.setup()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
  vim.o.background   = "light"
  vim.o.termguicolors= true
  vim.g.colors_name  = "hamblue-light"

  local hl = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- basics
  hl("Normal",            { fg = colors.fg,        bg = colors.bg })
  hl("LineNr",            { fg = colors.medium_blue })
  hl("CursorLine",        { bg = colors.medium_blue })
  hl("CursorLineNr",      { fg = colors.white,     bold = true })
  hl("Visual",            { bg = colors.light_blue })

  -- syntax
  hl("Comment",           { fg = colors.medium_blue, italic = true })
  hl("Constant",          { fg = colors.light_blue })
  hl("String",            { fg = colors.light_blue })
  hl("Identifier",        { fg = colors.fg })
  hl("Function",          { fg = colors.fg,         bold = true })
  hl("Statement",         { fg = colors.medium_blue })
  hl("PreProc",           { fg = colors.medium_blue })
  hl("Type",              { fg = colors.light_blue })
  hl("Special",           { fg = colors.fg })

  -- TreeSitter
  hl("@variable",         { fg = colors.fg })
  hl("@function",         { fg = colors.fg,         bold = true })
  hl("@keyword",          { fg = colors.medium_blue })
  hl("@string",           { fg = colors.light_blue })
  hl("@number",           { fg = colors.light_blue })
  hl("@boolean",          { fg = colors.light_blue })
  hl("@operator",         { fg = colors.medium_blue })
  hl("@punctuation.delimiter",{ fg = colors.medium_blue })
  hl("@punctuation.bracket",{ fg = colors.medium_blue })
  hl("@tag",              { fg = colors.medium_blue })
  hl("@attribute",        { fg = colors.medium_blue })
  hl("@property",         { fg = colors.fg })

  -- UI
  hl("StatusLine",        { fg = colors.fg,        bg = colors.light_blue })
  hl("StatusLineNC",      { fg = colors.medium_blue,bg = colors.light_blue })
  hl("VertSplit",         { fg = colors.medium_blue })
  hl("Pmenu",             { fg = colors.fg,        bg = colors.light_blue })
  hl("PmenuSel",          { fg = colors.bg,        bg = colors.medium_blue })
  hl("MatchParen",        { fg = colors.fg,        bg = colors.medium_blue, bold = true })
  hl("Search",            { fg = colors.bg,        bg = colors.medium_blue })
end

return M
