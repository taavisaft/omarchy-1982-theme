-- cga1982 — the editor exception for the 1982 Omarchy theme.
--
-- The desktop runs MDA green-on-black. Code does not: this is the IBM Color
-- Graphics Adapter palette that shipped the same year, so an editor is the one
-- surface on the machine that gets hues.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.o.background = "dark"
vim.g.colors_name = "cga1982"

-- CGA's 16 colors. Names are the originals.
local cga = {
  black         = "#000000",
  blue          = "#0000AA",
  green         = "#00AA00",
  cyan          = "#00AAAA",
  red           = "#AA0000",
  magenta       = "#AA00AA",
  brown         = "#AA5500",
  light_gray    = "#AAAAAA",
  dark_gray     = "#555555",
  light_blue    = "#5555FF",
  light_green   = "#55FF55",
  light_cyan    = "#55FFFF",
  light_red     = "#FF5555",
  light_magenta = "#FF55FF",
  yellow        = "#FFFF55",
  white         = "#FFFFFF",
}

-- Near-black rather than pure black so CursorLine and Pmenu can separate from
-- the canvas without a border.
local surface = "#0A0A0A"

-- Neutral buffer text: the one role that steps outside the CGA 16. Light grey
-- read as white against a machine that is green everywhere else. Kept clear of
-- light_green (strings) and light_cyan (functions) so roles stay separable.
local text = "#8FE88F"

local hl = {
  -- Canvas
  Normal       = { fg = text, bg = cga.black },
  NormalFloat  = { fg = text, bg = surface },
  FloatBorder  = { fg = cga.dark_gray,  bg = surface },
  CursorLine   = { bg = surface },
  ColorColumn  = { bg = surface },
  Visual       = { fg = cga.white, bg = cga.blue },
  Search       = { fg = cga.black, bg = cga.yellow },
  IncSearch    = { fg = cga.black, bg = cga.light_red },
  MatchParen   = { fg = cga.yellow, bold = true },
  Cursor       = { fg = cga.black, bg = cga.white },

  -- Gutter and chrome
  LineNr       = { fg = cga.dark_gray },
  CursorLineNr = { fg = cga.yellow, bold = true },
  SignColumn   = { bg = cga.black },
  VertSplit    = { fg = cga.dark_gray },
  WinSeparator = { fg = cga.dark_gray },
  StatusLine   = { fg = cga.black, bg = text },
  StatusLineNC = { fg = text, bg = surface },
  Pmenu        = { fg = text, bg = surface },
  PmenuSel     = { fg = cga.white, bg = cga.blue, bold = true },
  Folded       = { fg = cga.dark_gray, bg = surface },
  NonText      = { fg = cga.dark_gray },
  Whitespace   = { fg = cga.dark_gray },

  -- Syntax. One hue per role, and no role shares a hue with another.
  Comment      = { fg = cga.dark_gray, italic = true },
  Constant     = { fg = cga.light_red },
  String       = { fg = cga.light_green },
  Character    = { fg = cga.light_green },
  Number       = { fg = cga.light_red },
  Boolean      = { fg = cga.light_red },
  Float        = { fg = cga.light_red },
  Identifier   = { fg = text },
  Function     = { fg = cga.light_cyan },
  Statement    = { fg = cga.light_magenta },
  Conditional  = { fg = cga.light_magenta },
  Repeat       = { fg = cga.light_magenta },
  Operator     = { fg = text },
  Keyword      = { fg = cga.light_magenta },
  Exception    = { fg = cga.light_magenta },
  PreProc      = { fg = cga.brown },
  Include      = { fg = cga.brown },
  Define       = { fg = cga.brown },
  Macro        = { fg = cga.brown },
  Type         = { fg = cga.yellow },
  StorageClass = { fg = cga.yellow },
  Structure    = { fg = cga.yellow },
  Typedef      = { fg = cga.yellow },
  Special      = { fg = cga.light_cyan },
  Delimiter    = { fg = text },
  Todo         = { fg = cga.black, bg = cga.yellow, bold = true },
  Error        = { fg = cga.light_red, bold = true },

  -- Diagnostics
  DiagnosticError = { fg = cga.light_red },
  DiagnosticWarn  = { fg = cga.yellow },
  DiagnosticInfo  = { fg = cga.light_cyan },
  DiagnosticHint  = { fg = cga.light_blue },

  -- Diffs
  DiffAdd      = { fg = cga.light_green },
  DiffChange   = { fg = cga.yellow },
  DiffDelete   = { fg = cga.light_red },
  DiffText     = { fg = cga.white, bg = cga.blue },
}

-- Treesitter captures, mapped onto the same roles.
local ts = {
  ["@comment"]              = "Comment",
  ["@string"]               = "String",
  ["@number"]               = "Number",
  ["@boolean"]              = "Boolean",
  ["@constant"]             = "Constant",
  ["@constant.builtin"]     = "Constant",
  ["@function"]             = "Function",
  ["@function.builtin"]     = "Function",
  ["@function.call"]        = "Function",
  ["@method"]               = "Function",
  ["@constructor"]          = "Type",
  ["@keyword"]              = "Keyword",
  ["@keyword.function"]     = "Keyword",
  ["@keyword.return"]       = "Keyword",
  ["@conditional"]          = "Conditional",
  ["@repeat"]               = "Repeat",
  ["@type"]                 = "Type",
  ["@type.builtin"]         = "Type",
  ["@variable"]             = "Identifier",
  ["@variable.builtin"]     = "Constant",
  ["@property"]             = "Identifier",
  ["@field"]                = "Identifier",
  ["@parameter"]            = "Identifier",
  ["@operator"]             = "Operator",
  ["@punctuation.bracket"]  = "Delimiter",
  ["@punctuation.delimiter"] = "Delimiter",
  ["@preproc"]              = "PreProc",
  ["@tag"]                  = "Keyword",
  ["@tag.attribute"]        = "Type",
}

for group, spec in pairs(hl) do
  vim.api.nvim_set_hl(0, group, spec)
end
for capture, group in pairs(ts) do
  vim.api.nvim_set_hl(0, capture, { link = group })
end
