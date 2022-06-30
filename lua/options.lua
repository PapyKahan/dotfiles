require 'impatient'

local cmd = vim.cmd
local has = vim.fn.has
local set = vim.opt

vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

-------------------------------------------------------------------
-- shell configuration
-------------------------------------------------------------------
if (has("win32") or has("win64") or has("win32unix")) then
    -- Language
    cmd [[language en_US]]
    if vim.fn.has('win32') then
        set.shell = 'powershell'
    else
        set.shell = 'pwsh'
    end
    set.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    set.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    set.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    set.shellquote = nil
    set.shellxquote = nil
end

-------------------------------------------------------------------
-- General settings
-------------------------------------------------------------------
set.modeline = false
set.backspace = "indent,eol,start"        -- Backspace options
set.autoread = true                       -- automatically read a file when it was modified outside of Vim
set.mouse = "a"                           -- set all mouse options
set.encoding = "utf-8"                    -- sets the character encoding used inside Vim.
set.lazyredraw = true                     -- Don't redraw while executing marcros (good performance config)
set.number = true                         -- Shows line number
set.signcolumn = "number"


-------------------------------------------------------------------
-- Search options
-------------------------------------------------------------------
set.incsearch = true                             -- Set incremental search
set.hlsearch = true                       -- set highlight search for all matches

-------------------------------------------------------------------
-- Command menu options
-------------------------------------------------------------------
set.wildmenu = true                       -- When 'wildmenu' is on, command-line completion operates in an enhanced mode
set.wildmode = "longest:full,full"        -- set autocompletion

-------------------------------------------------------------------
-- Text formating
-------------------------------------------------------------------
set.wrap = false                          -- turn off word wrap

-------------------------------------------------------------------
-- Diff options
-------------------------------------------------------------------
set.diffopt = "internal,filler,closeoff,iwhite"

-------------------------------------------------------------------
-- Filetype
-------------------------------------------------------------------
set.fileformats = "dos,unix"
cmd [[filetype plugin indent on]]

-------------------------------------------------------------------
-- Visual
-------------------------------------------------------------------
set.syntax = "ON"											-- enable syntax highlighting
set.showcmd = true											-- When inserting a bracket, briefly jump to its match
set.showmatch = true										-- When inserting a bracket, briefly jump to its match
set.laststatus = 2											-- Always show status line
set.visualbell = false										-- turn off visual bell
set.errorbells = false										-- ring the bell for error messages
set.guioptions = "ig"									    -- remove gui menu and toolbar. Default: mtTig
set.background = "dark"									    -- set gui background
cmd [[colorscheme gruvbox-material]]			            -- set color scheme for gui
set.guifont = "Hack NF"                                     -- Set gui font
set.termguicolors = true


-------------------------------------------------------------------
-- Indentation
-------------------------------------------------------------------
set.autoindent = true										-- set auto indentation
set.cindent = true											-- enable c indentation
set.tabstop = 4												-- set tab stops to 4 spaces
set.shiftwidth = 4											-- number of spaces to use for each step of (auto)indent.
set.smarttab = true											-- When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
set.softtabstop = 4                                         -- Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>.
set.expandtab = true										-- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.

-------------------------------------------------------------------
-- Completion settings config
-------------------------------------------------------------------
set.completeopt = "longest,menuone,preview"					-- A comma separated list of options for Insert mode completion.

-------------------------------------------------------------------
-- Tab related config
-------------------------------------------------------------------
set.showtabline = 2

-------------------------------------------------------------------
-- Files/Backups
-------------------------------------------------------------------
set.backup = false
set.writebackup = false

-------------------------------------------------------------------
-- Clipboard configuration
-------------------------------------------------------------------
set.clipboard = "unnamedplus"
