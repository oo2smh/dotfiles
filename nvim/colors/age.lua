local frappe = {
  flamingo   = "#eebebe",
  red        = "#ff7080",
  red0       = "#ef6070",
  peach      = "#ef9f96",
  yellow     = "#f0d0aa",
  green      = "#86e1a9",
  green0     = "#86aa99",
  sapphire   = "#85dcdc",
  blue       = "#55bdff",
  blue0      = "#5787aa",
  lavender   = "#cabbf1",
  text       = "#cccccc",
  subtext    = "#8080a0",
  overlay2   = "#949cbb",
  surface2   = "#626880",
  surface1   = "#41576d",
  surface0   = "#415559",
  base       = "#305450",
  mantle     = "#2f3f3c",
  crust      = "#255045",
  diffadd    = "#204035",
  diffdel    = "#504040",
}

-- GENERAL UI
hl(0,"Normal", { fg = frappe.text ,bg = frappe.mantle })
hl(0,"PMenu", { fg = frappe.text ,bg = frappe.mantle })
hl(0,"NormalFloat", { fg = frappe.text ,bg = frappe.mantle })
hl(0,"ColorColumn", { bg = frappe.base})
hl(0,"LineNr", { fg = frappe.surface2})
hl(0,"Winbar", { bg = frappe.surface0,fg = frappe.text })
hl(0,"Search", { bg = frappe.surface1})
hl(0,"Visual", { bg = frappe.crust})
hl(0,"FoldColumn", { fg = frappe.flamingo})

-- CURSOR
hl(0, "CursorLineNr", { fg = frappe.text, bg = frappe.surface0, bold = true, italic = true })
hl(0, "CursorLine", { bg = frappe.surface0 })

-- DIFF
hl(0, "ErrorMsg",    { fg = frappe.red  })
hl(0, "DiffAdd",    { fg = frappe.green,    bg = frappe.diffadd,   })
hl(0, "DiffChange", { fg = frappe.surface2, bg = frappe.surface1, })
hl(0, "DiffDelete", { fg = frappe.red, bg = frappe.diffdel,  italic = true })
hl(0, "DiffText",   { fg = frappe.text, bg = frappe.blue0, italic = true,  })
hl(0, "Removed",  { fg = frappe.red0 })
hl(0, "Changed",  { fg = frappe.blue0 })
hl(0, "Added",  { fg = frappe.green0 })

-- OTHER
hl(0, "MatchParen",   { fg = frappe.red, bold = true, italic = true })
hl(0, "SpellBad",     { fg = frappe.red, bg = frappe.flamingo, italic = true })
hl(0, "Directory",     { fg = frappe.blue })

----------------------------
-- SYNTAX
----------------------------
-- DEEMPHASIZE
local deemphasize = { "String", "Number", "Float", "Character", }
for _, group in ipairs(deemphasize) do hl(0, group, { fg = frappe.text }) end
hl(0, "Special", {fg = frappe.overlay2})
hl(0, "PreProc", {fg = frappe.overlay2})
hl(0, "comment", {fg = frappe.subtext})

local orange =            { fg = frappe.yellow }
hl(0, "@variable",          orange)
hl(0, "@property",          orange)
hl(0, "@module",            orange)
hl(0, "@constant",        { fg = frappe.flamingo })
hl(0, "@variable.member", { fg = frappe.peach })
hl(0, "Type",             {fg = frappe.peach})

-- WARM: Functions & Keywords
hl(0, "@function.call",        { fg = frappe.blue })
hl(0, "@function.method.call", { fg = frappe.blue })
hl(0, "@function.builtin",     { fg = frappe.sapphire})
hl(0, "Operator",              { fg = frappe.sapphire})
hl(0, "Function",              { fg = frappe.red })
hl(0, "@function.method",      { fg = frappe.red })
hl(0, "@keyword.return",       { fg = frappe.red })
hl(0, "Exception",             { fg = frappe.red, bold = true })

-- MYSTIC: keywords
hl(0, "Statement",              { fg = frappe.lavender })
hl(0, "@keyword.operator",     { fg = frappe.lavender, italic = true, bold = true })
--
-- GREEN: Logic & Comments
local logic_base = { fg = frappe.green, }
hl(0, "Boolean",             logic_base)
hl(0, "Conditional",      logic_base)
hl(0, "Label", logic_base)
hl(0, "Repeat", logic_base)
hl(0, "@keyword.conditional", { fg = frappe.green, italic = true    })
hl(0, "@keyword.repeat",      { fg = frappe.green, italic = true    })
hl(0, "@keyword.repeat.c",      { fg = frappe.red, italic = true    })

-- MARKDOWN
hl(0, "@markup.list.markdown",    { fg = frappe.lavender })
hl(0, "@markup.link",          { fg = frappe.blue })
hl(0, "@markup.quote",         { fg = frappe.lavender, italic = true })
hl(0, "@markup.italic",        { italic = true })
hl(0, "DiagonsticInfo",        { fg = frappe.blue,})
hl(0, "RenderMarkdownCodeInline",    { fg = frappe.green, italic = true})
hl(0, "RenderMarkdownCode",    { bg = frappe.surface1})
hl(0, "RenderMarkdownBullet",    { fg = frappe.lavender })
hl(0, "DiagnosticInfo",    { fg = frappe.blue, bold = false })
hl(0, "@markup.heading",    { fg = frappe.blue, bold = true })
hl(0, "@markup.heading.1",    { fg = frappe.base, bg = frappe.yellow, bold = true })
hl(0, "@markup.heading.2",    { fg = frappe.peach, bg  = frappe.surface0, bold = true, })
hl(0, "@markup.heading.3",    { fg = frappe.red, bold = true })
hl(0, "@markup.heading.4",    { fg = frappe.lavender, bold = true })
hl(0, "@markup.heading.5",    { fg = frappe.blue, bold = true })
hl(0, "@markup.heading.6",    { fg = frappe.sapphire, bold = true })

hl(0, "RenderMarkdownH1Bg",    { fg = frappe.base, bg = frappe.yellow, bold = false })
hl(0, "RenderMarkdownH2Bg",    { fg = frappe.peach, bg = "none", })
hl(0, "RenderMarkdownH3Bg",    { fg = frappe.red, bg = "none" })
hl(0, "RenderMarkdownH4Bg",    { fg = frappe.lavender, bg = "none" })
hl(0, "RenderMarkdownH5Bg",    { fg = frappe.blue, bg = "none" })
hl(0, "RenderMarkdownBullet",   { fg = frappe.green, bg = "none" })
hl(0, "RenderMarkdownTableHead", { fg = frappe.blue})
hl(0, "RenderMarkdownTableRow", { fg = frappe.blue})
