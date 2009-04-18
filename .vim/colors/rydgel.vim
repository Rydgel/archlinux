" rydgel color scheme
" rydgel@ymail.com


" set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "rydgel"


"hi Example         guifg=NONE        guibg=NONE        gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE

" General colors
hi Normal           guifg=#f6f3e8     guibg=#121212       gui=NONE      ctermfg=254        ctermbg=233        cterm=NONE
hi NonText          guifg=#080808     guibg=#121212       gui=NONE      ctermfg=232       ctermbg=233        cterm=NONE

hi Cursor           guifg=black       guibg=white       gui=NONE      ctermfg=black       ctermbg=white       cterm=reverse
hi LineNr           guifg=#3A3A3A     guibg=#121212       gui=NONE      ctermfg=237    ctermbg=233        cterm=NONE

hi VertSplit        guifg=#1C1C1C     guibg=#1C1C1C     gui=NONE      ctermfg=234    ctermbg=234    cterm=NONE
hi StatusLine       guifg=#C6C6C6     guibg=#121212     gui=italic    ctermfg=251       ctermbg=233    cterm=NONE
hi StatusLineNC     guifg=black       guibg=#121212     gui=NONE      ctermfg=blue        ctermbg=233    cterm=NONE  

hi Folded           guifg=#8787FF     guibg=#5F5F87     gui=NONE      ctermfg=105        ctermbg=60        cterm=NONE
hi Title            guifg=#f6f3e8     guibg=NONE        gui=bold      ctermfg=254        ctermbg=NONE        cterm=NONE
hi Visual           guifg=NONE        guibg=#262D51     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=REVERSE

hi SpecialKey       guifg=#808080     guibg=#303030     gui=NONE      ctermfg=244        ctermbg=236        cterm=NONE

hi WildMenu         guifg=green       guibg=yellow      gui=NONE      ctermfg=black       ctermbg=yellow      cterm=NONE
hi PmenuSbar        guifg=black       guibg=white       gui=NONE      ctermfg=black       ctermbg=white       cterm=NONE
"hi Ignore           guifg=gray        guibg=black       gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE

hi Error            guifg=NONE        guibg=NONE        gui=undercurl ctermfg=white       ctermbg=red         cterm=NONE     guisp=#FF6C60
hi ErrorMsg         guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=white       ctermbg=red         cterm=NONE
hi WarningMsg       guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=white       ctermbg=red         cterm=NONE

" Message displayed in lower left, such as --INSERT--
hi ModeMsg          guifg=black       guibg=#C6C5FE     gui=BOLD      ctermfg=black       ctermbg=cyan        cterm=BOLD

if version >= 700 " Vim 7.x specific colors
  hi CursorLine     guifg=NONE        guibg=#121212     gui=NONE      ctermfg=NONE        ctermbg=233        cterm=BOLD
  hi CursorColumn   guifg=NONE        guibg=#121212     gui=NONE      ctermfg=NONE        ctermbg=233        cterm=BOLD
  hi MatchParen     guifg=#f6f3e8     guibg=#857b6f     gui=BOLD      ctermfg=254       ctermbg=233    cterm=NONE
  hi Pmenu          guifg=#f6f3e8     guibg=#444444     gui=NONE      ctermfg=254        ctermbg=238        cterm=NONE
  hi PmenuSel       guifg=#000000     guibg=#AFFFAF     gui=NONE      ctermfg=0        ctermbg=157        cterm=NONE
  hi Search         guifg=NONE        guibg=NONE        gui=underline ctermfg=NONE        ctermbg=NONE        cterm=underline
endif

" Syntax highlighting
hi Comment          guifg=#767676     guibg=NONE        gui=NONE      ctermfg=243    ctermbg=NONE        cterm=NONE
hi String           guifg=#87FF87     guibg=NONE        gui=NONE      ctermfg=120       ctermbg=NONE        cterm=NONE
hi Number           guifg=#FF5FFF     guibg=NONE        gui=NONE      ctermfg=207     ctermbg=NONE        cterm=NONE

hi Keyword          guifg=#87D7D7     guibg=NONE        gui=NONE      ctermfg=116       ctermbg=NONE        cterm=NONE
hi PreProc          guifg=#87D7D7     guibg=NONE        gui=NONE      ctermfg=116        ctermbg=NONE        cterm=NONE
hi Conditional      guifg=#5F87FF     guibg=NONE        gui=NONE      ctermfg=69        ctermbg=NONE        cterm=NONE

hi Todo             guifg=#D78787     guibg=NONE        gui=NONE      ctermfg=174         ctermbg=NONE        cterm=NONE
hi Constant         guifg=#87D787     guibg=NONE        gui=NONE      ctermfg=114        ctermbg=NONE        cterm=NONE

hi Identifier       guifg=#AFAFFF     guibg=NONE        gui=NONE      ctermfg=147        ctermbg=NONE        cterm=NONE
hi Function         guifg=#FFAF87     guibg=NONE        gui=NONE      ctermfg=216       ctermbg=NONE        cterm=NONE
hi Type             guifg=#FFFFAF     guibg=NONE        gui=NONE      ctermfg=229      ctermbg=NONE        cterm=NONE
hi Statement        guifg=#5FAFD7     guibg=NONE        gui=NONE      ctermfg=74   ctermbg=NONE        cterm=NONE

hi Special          guifg=#FF875F     guibg=NONE        gui=NONE      ctermfg=209       ctermbg=NONE        cterm=NONE
hi Delimiter        guifg=#00AFAF     guibg=NONE        gui=NONE      ctermfg=37        ctermbg=NONE        cterm=NONE
hi Operator         guifg=white       guibg=NONE        gui=NONE      ctermfg=white       ctermbg=NONE        cterm=NONE

hi link Character       Constant
hi link Boolean         Constant
hi link Float           Number
hi link Repeat          Statement
hi link Label           Statement
hi link Exception       Statement
hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc
hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type
hi link Tag             Special
hi link SpecialChar     Special
hi link SpecialComment  Special
hi link Debug           Special


" Special for Ruby
hi rubyRegexp                  guifg=#AF8700      guibg=NONE      gui=NONE      ctermfg=136          ctermbg=NONE      cterm=NONE
hi rubyRegexpDelimiter         guifg=#FF8700      guibg=NONE      gui=NONE      ctermfg=208          ctermbg=NONE      cterm=NONE
hi rubyEscape                  guifg=white        guibg=NONE      gui=NONE      ctermfg=cyan           ctermbg=NONE      cterm=NONE
hi rubyInterpolationDelimiter  guifg=#00AFFF      guibg=NONE      gui=NONE      ctermfg=39           ctermbg=NONE      cterm=NONE
hi rubyControl                 guifg=#5FAFD7      guibg=NONE      gui=NONE      ctermfg=74           ctermbg=NONE      cterm=NONE
hi rubyGlobalVariable          guifg=#FFD7D7      guibg=NONE      gui=NONE      ctermfg=224      ctermbg=NONE      cterm=NONE
hi rubyStringDelimiter         guifg=#008700      guibg=NONE      gui=NONE      ctermfg=28     ctermbg=NONE      cterm=NONE
hi rubyInclude                 guifg=#FF5F5F      guibg=NONE      gui=NONE        ctermfg=203        ctermbg=NONE    cterm=NONE
hi rubySharpBang               guifg=#AF87AF      guibg=NONE     gui=NONE        ctermfg=139    ctermbg=NONE    cterm=NONE
"rubyAccess
"rubyPredefinedVariable
hi rubyBoolean                 guifg=#FF5F5F      guibg=NONE      gui=NONE        ctermfg=203        ctermbg=NONE    cterm=NONE

"rubyBeginEnd
"rubyRepeatModifier
hi link rubyArrayDelimiter    Special  " [ , , ]
hi link rubyCurlyBlock        Special  " { , , }

hi link rubyClass             Keyword 
hi link rubyModule            Special 
hi link rubyKeyword           Keyword 
hi link rubyOperator          Operator
hi link rubyIdentifier        Identifier
hi link rubyInstanceVariable  Identifier
hi link rubyGlobalVariable    Identifier
hi link rubyClassVariable     rubyInclude
hi link rubyConstant          Type  


" Special for Java
" hi link javaClassDecl    Type
hi link javaScopeDecl         Identifier 
hi link javaCommentTitle      javaDocSeeTag 
hi link javaDocTags           javaDocSeeTag 
hi link javaDocParam          javaDocSeeTag 
hi link javaDocSeeTagParam    javaDocSeeTag 

hi javaDocSeeTag              guifg=#CCCCCC     guibg=NONE        gui=NONE      ctermfg=darkgray    ctermbg=NONE        cterm=NONE
hi javaDocSeeTag              guifg=#CCCCCC     guibg=NONE        gui=NONE      ctermfg=darkgray    ctermbg=NONE        cterm=NONE
"hi javaClassDecl              guifg=#CCFFCC     guibg=NONE        gui=NONE      ctermfg=white       ctermbg=NONE        cterm=NONE


" Special for XML
hi link xmlTag          Keyword 
hi link xmlTagName      Conditional 
hi link xmlEndTag       Identifier 


" Special for HTML
hi link htmlTag         Keyword 
hi link htmlTagName     Conditional 
hi link htmlEndTag      Identifier 


" Special for Javascript
hi link javaScriptNumber      Number 


" Special for Python
hi  link pythonEscape         Keyword      
let python_highlight_all = 1

" Special for CSharp
hi  link csXmlTag             Keyword      


" Special for PHP
hi link phpfunctions Function
hi StorageClass guifg=#c59f6f ctermfg=223

" Diff
 
hi link diffRemoved Constant
hi link diffAdded String
 
" VimDiff
 
hi DiffAdd guibg=#032218 ctermbg=233
hi DiffChange guibg=#100920 ctermbg=232
hi DiffDelete guibg=#220000 ctermbg=232
hi DiffText guibg=#000940 ctermbg=232
 
" Tag list
hi link TagListFileName Directory
