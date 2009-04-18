" Vim color file
" Maintainer:   Shirk <shirk@gmx.net>
" Last Change:  19 September 2005 - 0.2
" URL: trinity.gentoofreaks.org

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark     "or light
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="impact"


        hi Normal       ctermfg=LightGray 
        hi NonText      ctermfg=DarkGray

        hi Statement    ctermfg=Blue      ctermbg=none
        hi Comment      ctermfg=DarkGray  ctermbg=none cterm=bold term=bold
        hi Constant     ctermfg=DarkCyan  ctermbg=none
        hi Identifier   ctermfg=Cyan      ctermbg=none
        hi Type         ctermfg=DarkGreen ctermbg=none
        hi Folded       ctermfg=DarkGreen ctermbg=none cterm=underline term=none
        hi Special      ctermfg=Blue      ctermbg=none
        hi PreProc      ctermfg=LightGray ctermbg=none cterm=bold term=bold
        hi Scrollbar    ctermfg=Blue      ctermbg=none
        hi Cursor       ctermfg=white     ctermbg=none
        hi ErrorMsg     ctermfg=Red       ctermbg=none cterm=bold term=bold
        hi WarningMsg   ctermfg=Yellow    ctermbg=none
        hi VertSplit    ctermfg=White     ctermbg=none
        hi Directory    ctermfg=Cyan      ctermbg=DarkBlue
        hi Visual       ctermfg=White     ctermbg=DarkGray cterm=underline term=none
        hi Title        ctermfg=White     ctermbg=DarkBlue

        hi StatusLine   term=bold cterm=bold ctermfg=White ctermbg=Black
        hi StatusLineNC term=bold cterm=bold ctermfg=Gray  ctermbg=Black
        hi LineNr       term=bold cterm=bold ctermfg=White 

