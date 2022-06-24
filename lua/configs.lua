vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

require 'impatient'

local g = vim.g
local cmd = vim.cmd
local o, wo, bo = vim.o, vim.wo, vim.bo


-- local buffer = { o, bo }
-- local window = { o, wo }
-------------------------------------------------------------------
-- General settings
-------------------------------------------------------------------

o.compatible = false
o.modeline = false
o.backspace = "indent,eol,start"        -- Backspace options
o.autoread = true                       -- automatically read a file when it was modified outside of Vim
o.mouse = "a"                           -- set all mouse options
o.encoding = "utf-8"                    -- sets the character encoding used inside Vim.
o.lazyredraw = true                     -- Don't redraw while executing marcros (good performance config)
o.number = true                         -- Shows line number
o.signcolumn = "number"


-------------------------------------------------------------------
-- Search options
-------------------------------------------------------------------
o.is = true                             -- Set incremental search
o.hlsearch = true                       -- set highlight search for all matches

-------------------------------------------------------------------
-- Command menu options
-------------------------------------------------------------------
o.wildmenu = true                       -- When 'wildmenu' is on, command-line completion operates in an enhanced mode
o.wildmode = "longest:full,full"        -- set autocompletion

-------------------------------------------------------------------
-- Text formating
-------------------------------------------------------------------
o.wrap = false                          -- turn off word wrap


-------------------------------------------------------------------
-- Diff options
-------------------------------------------------------------------
-- vim.o.diffopt += "iwhite"


-------------------------------------------------------------------
-- Filetype
-------------------------------------------------------------------
o.fileformats = "dos,unix"
cmd([[filetype plugin indent on]])


-------------------------------------------------------------------
-- Visual
-------------------------------------------------------------------
o.syntax = "enable"											-- enable syntax highlighting
o.stal = 1													-- show tabulation line
o.ttyfast = true											-- smoother changes
o.showcmd = true											-- When inserting a bracket, briefly jump to its match
o.showmatch = true											-- When inserting a bracket, briefly jump to its match
o.laststatus = 2											-- Always show status line
o.visualbell = false										-- turn off visual bell
o.errorbells = false										-- ring the bell for error messages
o.guioptions = "ig"										    -- remove gui menu and toolbar. Default: mtTig
o.background = "dark"									    -- set gui background
cmd [[colorscheme gruvbox-material]]			            -- set color scheme for gui
o.guifont = "Hack NF"                                       -- Set gui font
o.termguicolors = true


-------------------------------------------------------------------
-- Indentation
-------------------------------------------------------------------
o.ai = true													-- set auto indentation
o.cindent = true											-- enable c indentation
o.ts = 4													-- set tab stops to 4 spaces
o.shiftwidth = 4											-- number of spaces to use for each step of (auto)indent.
o.smarttab = true											-- When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
o.softtabstop = 4                                           -- Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>.
o.expandtab = true											-- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.

-------------------------------------------------------------------
-- Completion settings config
-------------------------------------------------------------------
o.completeopt = "longest,menuone,preview"					-- A comma separated list of options for Insert mode completion.
