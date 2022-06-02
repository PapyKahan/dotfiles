"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VimPlug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('vim_starting')
    if &compatible
        set nocompatible
    endif											" Use vim defaults
endif

" Install vim-plug if not found
if empty(glob('~/vimfiles/autoload/plug.vim'))
    silent !curl -fLo ~/vimfiles/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Required:
call plug#begin('~/vimfiles/plugged')

" Color and visual plugins
Plug 'sainnhe/gruvbox-material'
Plug 'vim-scripts/cream-showinvisibles'

" Airline and bufferline plugins
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'

" Note: NerdTree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Required: git commandline
Plug 'tpope/vim-fugitive', {'augroup' : 'fugitive'}

" Note: Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Note: Tree-Sitter syntax optimizations
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Note: Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python' " need python dependency : pip install debugpy

call plug#end()

" Required:
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if (has("win16") || has("win32") || has("win64") || has("win95") || has("win32unix"))
    language us                                             " sets global language to US
    let &shell = has('win32') ? 'powershell' : 'pwsh'
	let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
	let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
	let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
	set shellquote= shellxquote=

endif
set nomodeline												" No modeline
set backspace=indent,eol,start								" Backspace options
set autoread												" automatically read a file when it was modified outside of Vim
set mouse=a													" set all mouse options
set encoding=utf-8                                          " sets the character encoding used inside Vim.
set lazyredraw                                              " Don't redraw while executing marcros (good performance config)
set showmatch                                               " Shows matching bracets
set number                                                  " Shows line number
set signcolumn=number

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set is														" Set incremental search
set hlsearch                                                " set highlight search for all matches

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command menu options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu												" When 'wildmenu' is on, command-line completion operates in an enhanced mode
set wildmode=longest:full,full								" set autocompletion

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cscope Relative
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cscopeverbose											" give messages when adding a cscope database

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text formating
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowrap													" turn off word wrap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Diff options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set diffopt+=iwhite

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fileformats=dos,unix
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable												" enable syntax highlighting
set stal=1													" show tabulation line
set ttyfast													" smoother changes
set showcmd													" When inserting a bracket, briefly jump to its match
set showmatch												" When inserting a bracket, briefly jump to its match
set laststatus=2											" Always show status line
set visualbell t_vb=										" turn off error beep/flash
set novisualbell											" turn off visual bell
set noerrorbells											" ring the bell for error messages
set guioptions=ig										    " remove gui menu and toolbar. Default: mtTig
set background=dark										    " set gui background
colorscheme gruvbox-material						        " set color scheme for gui
set guifont=Hack\ NF                                        " Set gui font
if &term =~ "xterm" || &term =~ "rxvt"
    set t_Co=256									        " set 256 colors
endif
if has("termguicolors")
    set termguicolors
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ai														" set auto indentation
set cindent													" enable c indentation
" Tabulations
" always insert a tab character when Shift-Tab is hit
inoremap <S-Tab> <C-V> <Tab>
set ts=4													" set tab stops to 4 spaces
set shiftwidth=4											" number of spaces to use for each step of (auto)indent.
set smarttab												" When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
set softtabstop=4                                           " Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>.
set expandtab												" In Insert mode: Use the appropriate number of spaces to insert a <Tab>.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion settings config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=longest,menuone,preview						" A comma separated list of options for Insert mode completion.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffer related config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <F6> :set number!<CR>
let mapleader=","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabbing related config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showtabline=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files/Backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowritebackup

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clipboard configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set clipboard+=unnamedplus

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins related configuration.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <F3> :NERDTreeToggle<CR>
imap <silent> <F3> :NERDTreeToggle<CR>
vmap <silent> <F3> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=60


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lualine configuraiton
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff' },
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', { 'filetype', colored = false } },
        lualine_y = {
            {
                'diagnostics',
                -- Table of diagnostic sources, available sources are:
                --   'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'.
                -- or a function that returns a table as such:
                --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
                sources = { 'coc' },
    
                -- Displays diagnostics for the defined severity types
                sections = { 'error', 'warn', 'info', 'hint' },
    
                diagnostics_color = {
                    error = { fg = '#DF0000' },
                    warn  = { fg = '#D75F00' },
                    info  = { fg = '#0087AF' },
                    hint  = { fg = '#008700' }
                },
                symbols = {
                    error = " ",
                    warn  = " ",
                    info  = " ",
                    hint  = " "
                },
                colored = true,           -- Displays diagnostics status in color if set to true.
                update_in_insert = false, -- Update diagnostics in insert mode.
                always_visible = false,   -- Show diagnostics even if there are none.
            }},
        lualine_z = {'progress', 'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        lualine_a = {{
            'buffers',
            symbols = {
                modified = ' ',      -- Text to show when the buffer is modified
                alternate_file = '#', -- Text to show to identify the alternate file
                directory =  '',     -- Text to show when the buffer is a directory
            },
        }},
        lualine_b = {
            {
                'filename',
                symbols = {
                    modified = ' ',       -- Text to show when the file is modified.
                    readonly = ' ',      -- Text to show when the file is non-modifiable or readonly.
                    unnamed = '[No Name]', -- Text to show for unnamed buffers.
                }
            }
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    extensions = {}
}
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Debugger Adapter Provider
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('dap-python').setup('c:/ieu/tools/python3/python.exe')
nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>

nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

lua << EOF
require('dap')
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='🔘', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='❕', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='🔷', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🚫', texthl='', linehl='', numhl=''})
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:coc_global_extensions = ['coc-json', 'coc-html', 'coc-html-css-support', 'coc-tsserver', 'coc-yaml', 'coc-lists', 'coc-pairs', 'coc-pyright', 'coc-clangd']

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
