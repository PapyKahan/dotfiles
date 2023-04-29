local cmd = vim.cmd
local has = vim.fn.has
local set = vim.opt

-------------------------------------------------------------------
-- shell configuration
-------------------------------------------------------------------
if (has('win32') == 1 or has('win64') == 1 or has('win32unix') == 1) then
    -- Language
    cmd [[language en_US]]

    -- Set the shell to powershell
    local shell_options = {
        shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
        shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
        shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
        shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
        shellquote = "",
        shellxquote = "",
    }

    if vim.fn.executable "nu" then
        shell_options = {
            shell = "nu",
            shellcmdflag = "-c",
            shellquote = "",
            shellxquote = "",
        }
    end

    for option, value in pairs(shell_options) do
      set[option] = value
    end
end

-------------------------------------------------------------------
-- General settings
-------------------------------------------------------------------
set.modeline = false
set.backspace = 'indent,eol,start'
set.autoread = true
set.mouse = 'a'
set.encoding = 'utf-8'
set.lazyredraw = true
set.number = true
set.numberwidth = 4
set.signcolumn = 'yes'
set.cursorline = true


-------------------------------------------------------------------
-- Search options
-------------------------------------------------------------------
set.incsearch = true
set.hlsearch = true

-------------------------------------------------------------------
-- Command menu options
-------------------------------------------------------------------
set.wildmenu = true
set.wildmode = 'longest:full,full'

-------------------------------------------------------------------
-- Text formating
-------------------------------------------------------------------
set.wrap = false

-------------------------------------------------------------------
-- Diff options
-------------------------------------------------------------------
set.diffopt = 'internal,filler,closeoff,iwhite'

-------------------------------------------------------------------
-- Filetype
-------------------------------------------------------------------
set.fileformats = 'dos,unix'
set.fileencoding = 'utf-8'
cmd [[filetype plugin indent on]]

-------------------------------------------------------------------
-- Visual
-------------------------------------------------------------------
set.syntax = 'ON'
set.showcmd = true
set.showmatch = true
set.laststatus = 2
set.visualbell = false
set.errorbells = false
set.guioptions = 'ig'
set.background = 'dark'
--cmd [[colorscheme tokyonight]]
set.guifont = 'JetbrainsMono NF:h12'
if has('termguicolors') then
    set.termguicolors = true
end
set.updatetime=300


-------------------------------------------------------------------
-- Indentation
-------------------------------------------------------------------
set.autoindent = true
set.cindent = true
set.smartindent = true -- make indenting smarter again
set.smartcase = true -- smart case
set.tabstop = 4
set.shiftwidth = 4
set.smarttab = true
set.softtabstop = 4
set.expandtab = true

-------------------------------------------------------------------
-- Completion settings config
-------------------------------------------------------------------
set.completeopt = 'longest,menuone,preview'

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
set.clipboard = 'unnamedplus'
