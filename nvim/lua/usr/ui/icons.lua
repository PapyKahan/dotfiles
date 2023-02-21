local M = {}

M.lspkind = {
   Namespace = "",
   Text = " ",
   Method = " ",
   Function = " ",
   Constructor = " ",
   Field = "ﰠ ",
   Variable = " ",
   Class = "ﴯ ",
   Interface = " ",
   Module = " ",
   Property = "ﰠ ",
   Unit = "塞 ",
   Value = " ",
   Enum = " ",
   Keyword = " ",
   Snippet = " ",
   Color = " ",
   File = " ",
   Reference = " ",
   Folder = " ",
   EnumMember = " ",
   Constant = " ",
   Struct = "פּ ",
   Event = " ",
   Operator = " ",
   TypeParameter = " ",
   Table = "",
   Object = " ",
   Tag = "",
   Array = "[]",
   Boolean = " ",
   Number = " ",
   Null = "ﳠ",
   String = " ",
   Calendar = "",
   Watch = " ",
   Package = "",
   Copilot = "",
}

M.diagnostic_signs = {
    Error = "",
    Warn = "",
    Info = "",
    Hint = "",
    Other = "﫠"
}

return M
