"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dein
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('vim_starting')
    if &compatible
        set nocompatible
    endif											" Use vim defaults
    set runtimepath+=~/vimfiles/bundle/dein.vim/
endif

" Required:
if dein#load_state(expand('~/vimfiles/bundle/'))
    call dein#begin(expand('~/vimfiles/bundle/'))
    call dein#add(expand('~/vimfiles/bundle/dein.vim/'))
    
    call dein#add('fatih/molokai')
    call dein#add('cfajardo/Wombat')

    call dein#add('vim-airline/vim-airline')
    call dein#add('bling/vim-bufferline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('scrooloose/nerdtree', { 'augroup' : 'NERDTreeHijackNetrw'})

    call dein#add('cream-showinvisibles')
    call dein#add('cmdline-completion')
    call dein#add('haya14busa/incsearch.vim') ", { 'augroup' : 'incsearchvim'})

    " Required: git commandline
    call dein#add('tpope/vim-fugitive') ", { 'augroup' : 'fugitive'})

    " Note: Syntastic
    call dein#add('scrooloose/syntastic')

    " Note: Golang
    call dein#add('fatih/vim-go')
    call dein#add('garyburd/go-explorer')

    " Note: Tagbar
    call dein#add('majutsushi/tagbar')

    call dein#add('Shougo/neocomplete.vim')

    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on

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
syntax enable												" enable syntax highlighting
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
    set guioptions=ig										" remove gui menu and toolbar. Default: mtTig
    set background=dark										" set gui background
    colorscheme wombat									    " set color scheme for gui
    if (has("win16") || has("win32") || has("win64") || has("win95") || has("win32unix"))
        set guifont=Consolas_for_Powerline_FixedD:h10       " Set gui font
    endif
else
    if &term =~ "xterm" || &term =~ "rxvt"
        set t_Co=256									    " set 256 colors
        colorscheme wombat							        " set color scheme
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabbing related config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showtabline=2

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
if dein#tap('nerdtree')
    map <silent> <F5> :NERDTreeToggle<CR>
    imap <silent> <F5> :NERDTreeToggle<CR>
    vmap <silent> <F5> :NERDTreeToggle<CR>
    let g:NERDTreeWinSize=60
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bufferline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if dein#tap('vim-bufferline')
    let g:bufferline_echo = 0
    let g:bufferline_active_buffer_left = '⮀'
    let g:bufferline_active_buffer_right = '⮀'
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Air line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if dein#tap('vim-airline')
    let g:airline_powerline_fonts=1
    let g:airline_theme = 'wombat'
    let g:airline_detect_modified=1
    let g:airline_detect_paste=1

    let g:airline_extensions = ['branch', 'tabline', 'syntastic']

    let g:airline#extensions#syntastic#enabled = 1

    " Airline branch extention
    let g:airline#extensions#branch#enabled = 1

    " Airline buffer line configuration
    let g:airline#extensions#bufferline#enabled = 1
    let g:airline#extensions#bufferline#overwrite_variables = 1

    " Airline tabline configuration
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#fnamecollapse = 1

    let g:airline#extensions#tabline#left_sep = '⮀'
    let g:airline#extensions#tabline#left_alt_sep = '⮁'
    let g:airline#extensions#tabline#right_sep = '⮂'
    let g:airline#extensions#tabline#right_alt_sep = '⮃'

    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif

    let g:airline_left_sep          = '⮀'
    let g:airline_left_alt_sep      = '⮁'
    let g:airline_right_sep         = '⮂'
    let g:airline_right_alt_sep     = '⮃'
    let g:airline_symbols.branch    = '⭠'
    let g:airline_symbols.readonly  = '⭤'
    let g:airline_symbols.linenr    = '⭡'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unite configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if dein#tap('unite.vim')
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
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neocomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if dein#tap('neocomplete.vim')
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
" incsearch.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if dein#tap('incsearch.vim')
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if dein#tap('syntastic')
    let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if dein#tap('vim-go')
    if dein#tap('syntastic')
        let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
        let g:go_list_type = "quickfix"
    endif
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_interfaces = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1

    let g:go_fmt_command = "goimports"
    let g:go_fmt_fail_silently = 1

    " Mapping
    au FileType go nmap <leader>r <Plug>(go-run)
    au FileType go nmap <leader>b <Plug>(go-build)
    au FileType go nmap <leader>t <Plug>(go-test)
    au FileType go nmap <leader>c <Plug>(go-coverage)

    au FileType go nmap <Leader>ds <Plug>(go-def-split)
    au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
    au FileType go nmap <Leader>dt <Plug>(go-def-tab)

    au FileType go nmap <Leader>gd <Plug>(go-doc)
    au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
    au FileType go nmap <Leader>s <Plug>(go-implements)

    au FileType go nmap <Leader>i <Plug>(go-info)

    au FileType go nmap <Leader>e <Plug>(go-rename)
endif

" Tagbar
if dein#tap('tagbar')
    if dein#tap('vim-go')
        let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ }
    endif
endif
