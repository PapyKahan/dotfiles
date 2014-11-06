"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('vim_starting')
    set nocompatible											" Use vim defaults
    set runtimepath+=~/vimfiles/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/vimfiles/bundle'))

" Required: Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

NeoBundle 'tomasr/molokai'

NeoBundle 'bling/vim-airline'
NeoBundle 'bling/vim-bufferline'
NeoBundle 'scrooloose/nerdtree', { 'augroup' : 'NERDTreeHijackNetrw'}

NeoBundle 'cream-showinvisibles'
NeoBundle 'cmdline-completion'
NeoBundle 'KabbAmine/vCoolor.vim'

" Note: Dépendance de beaucoup de plugins
NeoBundle 'Shougo/vimproc.vim', {
            \   'build' : {
            \       'windows' : 'tools\\update-dll-mingw',
            \       'cygwin' : 'make -f make_cygwin.mak',
            \       'mac' : 'make -f make_mac.mak',
            \       'unix' : 'make -f make_unix.mak',
            \    }
            \ }

NeoBundle 'mattn/webapi-vim'

" Required: git commandline
NeoBundle 'tpope/vim-fugitive', { 'augroup' : 'fugitive'}
NeoBundle 'tpope/vim-dispatch', { 'augroup' : 'vimdispatch' }

" Note: Syntastic
NeoBundle 'scrooloose/syntastic'
NeoBundle 'kien/ctrlp.vim'

" Use: vimproc
NeoBundle 'Shougo/unite.vim', { 'augroup' : 'unitevim' }

" Note: neconeocomplete doit être installé avant neosnippet
NeoBundle 'Shougo/neocomplete.vim', { 'augroup' : 'neocomplete' }

NeoBundle 'Shougo/neosnippet.vim', {
            \ 'augroup' : 'neosnippet',
            \ 'depends' : [ 'Shougo/context_filetype.vim' ]
            \ }
"NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'

" Note: C# related.
NeoBundle 'OrangeT/vim-csharp', {
            \   'autoload':{ 'filetypes': ['cs'], }
            \ }

NeoBundle 'nosami/Omnisharp', {
            \   'autoload': {'filetypes': ['cs']},
            \   'build': {
            \       'windows' : 'C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319\\MSBuild.exe server/OmniSharp.sln /p:Platform="Any CPU" /verbosity:quiet',
            \       'mac'     : 'xbuild server/OmniSharp.sln',
            \       'unix'    : 'xbuild server/OmniSharp.sln',
            \   },
            \   'disable': !(has("win16") || has("win32") || has("win64") || has("win95")),
            \   'augroup': 'omnisharp_commands'
            \ }

" Note: Powershell related.
NeoBundle 'PProvost/vim-ps1', {
            \ 'autoload': {'filetypes': ['ps1']},
            \ 'disable': !(has("win32") || has("win64")),
            \ }

NeoBundle 'cd01/poshcomplete-vim', {
            \   'autoload': {'filetypes': ['ps1']},
            \   'build' : {
            \       'windows' : 'nuget restore server/PoshComplete.sln ; C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319\\MSBuild.exe server/PoshComplete.sln /p:Platform="Any CPU" /p:Configuration=Release /verbosity:quiet'
            \   },
            \   'depends': ['Shougo/vimproc.vim', 'mattn/webapi-vim' ],
            \   'disable': !(has("win32") || has("win64")),
            \ }

" Note: Markdown reladrelated.
NeoBundle 'tpope/vim-markdown', {
    \ 'autoload': {'filetypes': ['md']},
    \ }

" Note: SQL
NeoBundle 'sqlserver.vim' " 1.0.0 Syntax file for SQL Server 2005/2008

" Note: Node.js related.
NeoBundle 'moll/vim-node'
NeoBundle 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
NeoBundle 'JavaScript-Indent', {'autoload':{'filetypes':['javascript']}}
NeoBundle 'marijnh/tern_for_vim', {
            \ 'autoload': {'filetypes':['javascript']},
            \   'build' : {
            \       'windows': 'npm install ; npm update',
            \       'mac': 'npm install ; npm update',
            \       'unix': 'npm install ; npm update'
            \   }
            \ }
NeoBundle 'digitaltoad/vim-jade'

" Note: Web
NeoBundle 'genoma/vim-less', { 'depends': [ 'JulesWang/css.vim' ]}

" Note: TODO lists management
NeoBundle 'jceb/vim-orgmode', {
    \ 'autoload': {'filetypes': ['org']},
    \ 'depends' : ['mattn/calendar-vim', 'chrisbra/NrrwRgn', 'utl.vim', 'SyntaxRange', 'tpope/vim-speeddating']
    \ }

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if (has("win16") || has("win32") || has("win64") || has("win95") || has("win32unix"))
    language us                                             " sets global language to US
endif
set nomodeline												" No modeline
set backspace=indent,eol,start								" Backspace options
set ghr=0													" room (in pixels) left above/below the window
set autoread												" automatically read a file when it was modified outside of Vim
set mouse=a													" set all mouse options
set encoding=utf-8                                          " sets the character encoding used inside Vim.
set lazyredraw                                              " Don't redraw while executing marcros (good performance config)
set showmatch                                               " Shows matching bracets
set number                                                  " Shows line number

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
syn on														" enable syntax highlighting
set stal=1													" show tabulation line
set ttyfast													" smoother changes
set showcmd													" When inserting a bracket, briefly jump to its match
set showmatch												" When inserting a bracket, briefly jump to its match
set laststatus=2											" Always show status line
set statusline=%<%f%h%m%r%=[format:%{&ff}][encoding:%{&fenc}]\ %l,%c%V\ %P   " Format the status line
set visualbell t_vb=										" turn off error beep/flash
set novisualbell											" turn off visual bell
set noerrorbells											" ring the bell for error messages
if has('gui_running')
    " set guioptions=mtTig									" default gui options
    set guioptions=ig										" remove gui menu and toolbar
    " enable midle mouse insert
    map <S-Insert> <MiddleMouse>
    map! <S-Insert> <MiddleMouse>
    "set background=dark										" set gui background
    colorscheme wombat									    " set color scheme for gui
    if (has("win16") || has("win32") || has("win64") || has("win95") || has("win32unix"))
        " set guifont=Courier_New:h10:cANSI				    " set gui font
        "set guifont=Consolas:h10:cANSI				    " set gui font
        "set guifont=Inconsolata\ for\ Powerline:h11:cDEFAULT
        set guifont=Consolas_for_Powerline_FixedD:h10       " Set gui font

        map <F10> :simalt ~n<CR>
        imap <F10> :simalt ~n<CR>
        vmap <F10> :simalt ~n<CR>

        map <F11> :simalt ~R<CR>
        imap <F11> :simalt ~R<CR>
        vmap <F11> :simalt ~R<CR>

        map <F12> :simalt ~x<CR>
        imap <F12> :simalt ~x<CR>
        vmap <F12> :simalt ~x<CR>
    endif
else
    if &term =~ "xterm" || &term =~ "rxvt"
        set t_Co=256									" set 256 colors
        colorscheme lucius							" set color scheme
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ai														" set auto indentation
set cindent													" enable c indentation
" Tabulations
" always insert a tab character when Shift-Tab is hit
inoremap <S-Tab> <C-V><Tab>
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

" Previous buffer
map <silent> <F2> :bp!<CR>
imap <silent> <F2> <esc>:bp!<CR>
vmap <silent> <F2> <esc>:bp!<CR>
" Next buffer
map <silent> <F3> :bn<CR>
imap <silent> <F3> <esc>:bn<CR>
vmap <silent> <F3> <esc>:bn<CR>
" Close buffer
map <silent> <C-F2> :bw!<CR>
imap <silent> <C-F2> <esc>:bw!<CR>
vmap <silent> <C-F2> <esc>:bw!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabbing related config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showtabline=2
" Create a new tab in normal mode, insert mode and visual mode.
" map <silent> <C-W>tn :tabnew<CR>
" imap <silent> <C-W>tn :tabnew<CR>
" vmap <silent> <C-W>tn :tabnew<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files/Backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backup " make backup file
if (has("win16") || has("win32") || has("win64") || has("win95") || has("win32unix"))
    set backupdir=$HOME\vimfiles\filebackup\backup			" where to put backup file
    set directory=$HOME\vimfiles\filebackup\swap			" directory is the directory for temp file
else
    set backupdir=$HOME/.vim/filebackup/backup				" where to put backup file
    set directory=$HOME/.vim/filebackup/swap				" directory is the directory for temp file
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins related configuration.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <F5> :NERDTreeToggle<CR>
imap <silent> <F5> :NERDTreeToggle<CR>
vmap <silent> <F5> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=60

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bufferline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:bufferline_echo = 0
let g:bufferline_active_buffer_left = '⮀'
let g:bufferline_active_buffer_right = '⮀'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Air line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts=1
"let g:airline_theme = 'wombat'
let g:airline_enable_branch = 1
let g:airline_enable_syntastic = 1
let g:airline_detect_modified=1
let g:airline_detect_paste=1

" Airline buffer line configuration
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#bufferline#overwrite_variables = 1

" Airline tabbar configuration
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#left_sep = '⮀'
let g:airline#extensions#tabline#left_alt_sep = '⮁'
let g:airline#extensions#tabline#right_sep = '⮂'
let g:airline#extensions#tabline#right_alt_sep = '⮃'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

"let g:airline_left_sep = "\u2b80" "use double quotes here
"let g:airline_left_alt_sep = "\u2b81"
"let g:airline_right_sep = "\u2b82"
"let g:airline_right_alt_sep = "\u2b83"
"let g:airline_symbols.branch = "\u2b60"
"let g:airline_symbols.readonly = "\u2b64"
"let g:airline_symbols.linenr = "\u2b61"

let g:airline_left_sep          = '⮀'
let g:airline_left_alt_sep      = '⮁'
let g:airline_right_sep         = '⮂'
let g:airline_right_alt_sep     = '⮃'
let g:airline_branch_prefix     = '⭠'
let g:airline_readonly_symbol   = '⭤'
let g:airline_linecolumn_prefix = '⭡'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unite configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_source_menu_menus = {}
let g:unite_source_menu_menus.git = {
            \ 'description' : '            source manager git
            \                            ⌘ [menu]g',
            \}
let g:unite_source_menu_menus.git.command_candidates = [
            \['▷ tig                                                        ⌘ ,gt',
            \'normal ,gt'],
            \['▷ git status       (Fugitive)                                ⌘ ,gs',
            \'Gstatus'],
            \['▷ git diff         (Fugitive)                                ⌘ ,gd',
            \'Gdiff'],
            \['▷ git commit       (Fugitive)                                ⌘ ,gc',
            \'Gcommit'],
            \['▷ git log          (Fugitive)                                ⌘ ,gl',
            \'exe "silent Glog | Unite quickfix"'],
            \['▷ git blame        (Fugitive)                                ⌘ ,gb',
            \'Gblame'],
            \['▷ git stage        (Fugitive)                                ⌘ ,gw',
            \'Gwrite'],
            \['▷ git checkout     (Fugitive)                                ⌘ ,go',
            \'Gread'],
            \['▷ git rm           (Fugitive)                                ⌘ ,gr',
            \'Gremove'],
            \['▷ git mv           (Fugitive)                                ⌘ ,gm',
            \'exe "Gmove " input("destino: ")'],
            \['▷ git push         (Fugitive, only for buffer)               ⌘ ,gp',
            \'Git! push'],
            \['▷ git pull         (Fugitive, only for buffer)               ⌘ ,gP',
            \'Git! pull'],
            \['▷ git prompt       (Fugitive, only for buffer)               ⌘ ,gi',
            \'exe "Git! " input("command git: ")'],
            \['▷ git cd           (Fugitive)',
            \'Gcd'],
            \]
nnoremap <silent>[menu]g :Unite -silent -start-insert menu:git<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neocomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if neobundle#is_installed('neocomplete.vim')
    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Don't Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_ignore_case = 1
    let g:neocomplete#enable_fuzzy_completion = 1
    let g:neocomplete#enable_auto_close_preview = 0
    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist'
                \ }

    " Define Keyword
	if !exists('g:neocomplete#keyword_patterns')
		let g:neocomplete#keyword_patterns = {}
	endif
	let g:neocomplete#keyword_patterns._ = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        "return neocomplete#close_popup() . "\<CR>"
        " For no inserting <CR> key.
        return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()

    " let g:neocomplete#enable_auto_select = 0
    " let g:neocomplete#disable_auto_complete = 0

    " Enable omnicompletion
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    "autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
    autocmd FileType javascript setlocal omnifunc=tern#Complete
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.

    "call neocomplete#custom#source('_', 'sorters', [])
	call neocomplete#custom#source('_', 'matchers', ['matcher_head', 'matcher_length'])


    if !exists('g:neocomplete#sources')
        let g:neocomplete#sources = {}
    endif

    let g:neocomplete#sources.cs = ['omni', 'member', 'syntax', 'buffer', 'dictionary', 'file', 'neosnippet']
    if neobundle#is_installed('poshcomplete.vim')
        let g:neocomplete#sources.ps1 = ['omni', 'member', 'syntax', 'buffer', 'dictionary', 'file']
    endif

    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif

    let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);"]'
	let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

    "let g:neocomplete#enable_refresh_always = 0
    let g:echodoc_enable_at_startup = 1
    let g:neocomplete#enable_insert_char_pre = 1
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Omnisharp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if neobundle#is_installed('Omnisharp')

    if neobundle#is_installed('syntastic')
        " Get Code Issues and syntax errors
        let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
    endif

    augroup omnisharp_commands
        autocmd!

        "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
        autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

        " Synchronous build (blocks Vim)
        "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
        " Builds can also run asynchronously with vim-dispatch installed
        autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
        "autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

        " Automatically add new cs files to the nearest project on save
        autocmd BufWritePost *.cs call OmniSharp#AddToProject()

        "show type information automatically when the cursor stops moving
        autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

        "The following commands are contextual, based on the current cursor position.

        autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
        autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
        autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
        autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
        autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
        autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr> "finds members in the current buffer
        " cursor can be anywhere on the line containing an issue
        autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
        autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
        autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
        autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
        autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr> "navigate up by method/property/field
        autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr> "navigate down by method/property/field
    augroup END

    " this setting controls how long to wait (in ms) before fetching type / symbol information.
    set updatetime=500
    " Remove 'Press Enter to continue' message when type information is longer than one line.
    "set cmdheight=2

    if neobundle#is_installed('ctrlp.vim')
        " Contextual code actions (requires CtrlP)
        nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
        " Run code actions with text selected in visual mode to extract method
        vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>
    endif
    
    " rename with dialog
    nnoremap <leader>nm :OmniSharpRename<cr>
    nnoremap <F2> :OmniSharpRename<cr>      
    " rename without dialog - with cursor on the symbol to rename... ':Rename newname'
    command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")
    
    " Force OmniSharp to reload the solution. Useful when switching branches etc.
    nnoremap <leader>rl :OmniSharpReloadSolution<cr>
    nnoremap <leader>cf :OmniSharpCodeFormat<cr>
    " Load the current .cs file to the nearest project
    nnoremap <leader>tp :OmniSharpAddToProject<cr>
    
    if neobundle#is_installed('vimproc.vim') || neobundle#is_installed('vim-dispatch')
        " (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
        nnoremap <leader>ss :OmniSharpStartServer<cr>
        nnoremap <leader>sp :OmniSharpStopServer<cr>
    end
    
    " Add syntax highlighting for types and interfaces
    nnoremap <leader>th :OmniSharpHighlightTypes<cr>
    "Don't ask to save when changing buffers (i.e. when jumping to a type definition)
    set hidden
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Poshcomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if neobundle#is_installed('poshcomplete.vim')
    let g:PoshComplete_Port=1234
    autocmd FileType ps1 setl omnifunc=poshcomplete#CompleteCommand
    call poshcomplete#StartServer()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neosnippet
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if neobundle#is_installed('neosnippet.vim')
    let g:neosnippet#enable_snipmate_compatibility = 1
    let g:neosnippet#snippets_directory=$HOME.'/vimfiles/bundle/vim-snippets/snippets'
	let g:neosnippet#disable_runtime_snippets = { '_' : 1, }

    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if neobundle#is_installed('vim-markdown')
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SyntaxRange
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if neobundle#is_installed('SyntaxRange')
    autocmd Syntax *.org call SyntaxRange#Include(...)
endif
