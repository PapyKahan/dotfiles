" Maintainer:   Lars H. Nielsen (dengmao@gmail.com)
" Last Change:  January 22 2007

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "wombat"

let save_cpo = &cpo
set cpo&vim

" basic highlight groups (:help highlight-groups) {{{

" text {{{
hi Normal               guifg=#f6f3e8   guibg=#242424   gui=none
hi Folded               guibg=#384048   guifg=#a0a8b0   gui=none
hi LineNr               guifg=#857b6f   guibg=#000000   gui=none
hi NonText              guifg=#808080   guibg=#303030   gui=none
hi SpecialKey           guifg=#808080   guibg=#343434   gui=none
hi Directory            guifg=#80a0ff   guibg=NONE      gui=none

hi SpellBad             guifg=NONE      guibg=NONE      gui=undercurl
hi SpellCap             guifg=NONE      guibg=NONE      gui=undercurl
hi SpellLocal           guifg=NONE      guibg=NONE      gui=undercurl
hi SpellRare            guifg=NONE      guibg=NONE      gui=undercurl

"hi DiffAdd             guifg=#ffffff   guibg=#126493   gui=NONE
"hi DiffChange          guifg=#000000   guibg=#976398   gui=NONE
"hi DiffDelete          guifg=#000000   guibg=#be1923   gui=bold
"hi DiffText            guifg=#ffffff   guibg=#976398   gui=bold
" }}}

" borders / separators / menus {{{
hi FoldColumn           guifg=#857b6f   guibg=#444444   gui=none            
hi SignColumn           guifg=#857b6f   guibg=#444444   gui=none

hi Pmenu                guifg=#f6f3e8   guibg=#444444   gui=none
hi PmenuSel             guifg=#000000   guibg=#cae682   gui=none
"hi PmenuSbar           guifg=NONE      guibg=#555555   gui=NONE
"hi PmenuThumb          guifg=#000000      guibg=#cccccc   gui=NONE

hi StatusLine           guifg=#f6f3e8   guibg=#444444   gui=none
hi StatusLineNC         guifg=#857b6f   guibg=#444444   gui=none

hi WildMenu             guifg=#f6f3e8   guibg=#242424   gui=none

hi VertSplit            guifg=#444444   guibg=#444444   gui=none

hi TabLine              guifg=#857b6f   guibg=#444444   gui=none
hi TabLineFill          guifg=#857b6f   guibg=#444444   gui=none
hi TabLineSel           guifg=#f6f3e8   guibg=#242424   gui=none

"hi Menu                guifg=NONE      guibg=NONE      gui=NONE
"hi Scrollbar           guifg=NONE      guibg=NONE      gui=NONE
"hi Tooltip             guifg=NONE      guibg=NONE      gui=NONE
" }}}

" cursor / dynamic / other {{{
hi Cursor               guifg=NONE      guibg=#757575   gui=none
hi CursorLine           guifg=NONE      guibg=#2d2d2d   gui=none
hi CursorColumn         guifg=NONE      guibg=#2d2d2d   gui=none

hi Visual               guifg=#f6f3e8   guibg=#444444   gui=none

hi IncSearch            guifg=#efefd0   guibg=#9c9c00   gui=none
hi Search               guifg=#efefd0   guibg=#9c9c00   gui=none

hi MatchParen           guifg=#f6f3e8   guibg=#857b6f   gui=none

"hi VisualNOS           guifg=NONE      guibg=NONE      gui=NONE
" }}}

" listings / messages {{{
"hi ModeMsg             guifg=#eecc18   guibg=NONE      gui=NONE
hi Title                guifg=#f6f3e8   guibg=NONE      gui=none
"hi Question            guifg=#66d077   guibg=NONE      gui=NONE
"hi MoreMsg             guifg=#39d049   guibg=NONE      gui=NONE
"hi ErrorMsg            guifg=#ffffff   guibg=#ff0000   gui=bold
"hi WarningMsg          guifg=#ccae22   guibg=NONE      gui=bold    
" }}}

" syntax highlighting groups (:help group-name) {{{
hi Comment              guifg=#99968b   guibg=NONE      gui=none

hi Constant             guifg=#e5786d   guibg=NONE      gui=none
    hi String           guifg=#95e454   guibg=NONE      gui=none
    hi Character        guifg=#95e454   guibg=NONE      gui=none
    hi Number           guifg=#e5786d   guibg=NONE      gui=none  
    hi Boolean          guifg=#e5786d   guibg=NONE      gui=none  
    hi Float            guifg=#e5786d   guibg=NONE      gui=none  

hi Identifier           guifg=#cae682   guibg=NONE      gui=none
    hi Function         guifg=#cae682   guibg=NONE      gui=none

hi Statement            guifg=#8ac6f2   guibg=NONE      gui=none
    " if, then, else, endif, switch, etc.
    hi Conditional      guifg=#8ac6f2   guibg=NONE      gui=none
    " for, do, while, etc.
    hi Repeat           guifg=#8ac6f2   guibg=NONE      gui=none
    " case, default, etc.
    hi Label            guifg=#8ac6f2   guibg=NONE      gui=none
    " "sizeof", "+", "*", etc.
    hi Operator         guifg=#8ac6f2   guibg=NONE      gui=none
    " any other keyword
    hi Keyword          guifg=#8ac6f2   guibg=NONE      gui=none
    " try, catch, throw
    hi Exception        guifg=#8ac6f2   guibg=NONE      gui=none

hi PreProc              guifg=#e5786d   guibg=NONE      gui=none
    " preprocessor #include
    hi Include          guifg=#e5786d   guibg=NONE      gui=none
    " preprocessor #define
    hi Define           guifg=#e5786d   guibg=NONE      gui=none
    " same as Define
    hi Macro            guifg=#e5786d   guibg=NONE      gui=none
    " preprocessor #if, #else, #endif, etc.
    hi PreCondit        guifg=#e55446   guibg=NONE      gui=none

hi Type                 guifg=#cae682   guibg=NONE      gui=none
    " static, register, volatile, etc.
    hi StorageClass     guifg=#cae682   guibg=NONE      gui=none
    " struct, union, enum, etc.
    hi Structure        guifg=#cae682   guibg=NONE      gui=none
    " A typedef
    hi Typedef          guifg=#cae682   guibg=NONE      gui=none

hi Special              guifg=#e7f6da   guibg=NONE      gui=none
    " special character in a constant
    hi SpecialChar      guifg=#e7f6da   guibg=NONE      gui=none
    " you can use CTRL-] on this
    hi Tag              guifg=#e7f6da   guibg=NONE      gui=none
    " character that needs attention
    hi Delimiter        guifg=#e7f6da   guibg=NONE      gui=none
    " special things inside a comment
    hi SpecialComment   guifg=#e7f6da   guibg=NONE      gui=none
    " debugging statements
    hi Debug            guifg=#e7f6da   guibg=NONE      gui=none

hi Underlined       guifg=#80a0ff   guibg=NONE      gui=underline

hi Ignore           guifg=#888888   guibg=NONE      gui=NONE

"hi Error            guifg=#ffffff   guibg=#ff0000   gui=NONE
hi Error            guifg=#ffffff   guibg=#d62929   gui=none

hi Todo             guifg=#ffffff   guibg=#ee7700   gui=none
" }}}

let &cpo = save_cpo

" vim: fdm=marker fdl=0
