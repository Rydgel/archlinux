" Vim color file
" Maintainer:   A. Sinan Unur
" Last Change:  2001/10/04

" Dark color scheme

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="asu1dark"

" Console Color Scheme
hi Normal       term=NONE cterm=NONE ctermfg=LightGray   
hi NonText      term=NONE cterm=NONE ctermfg=Brown       
hi Function     term=NONE cterm=NONE ctermfg=DarkCyan    
hi Statement    term=BOLD cterm=BOLD ctermfg=DarkBlue    
hi Special      term=NONE cterm=NONE ctermfg=DarkGreen   
hi SpecialChar  term=NONE cterm=NONE ctermfg=Cyan        
hi Constant     term=NONE cterm=NONE ctermfg=Blue        
hi Comment      term=NONE cterm=NONE ctermfg=DarkGray    
hi Preproc      term=NONE cterm=NONE ctermfg=DarkGreen   
hi Type         term=NONE cterm=NONE ctermfg=DarkMagenta 
hi Identifier   term=NONE cterm=NONE ctermfg=Cyan        
hi StatusLine   term=BOLD cterm=NONE ctermfg=Yellow      
hi StatusLineNC term=NONE cterm=NONE ctermfg=Black       
hi Visual       term=NONE cterm=NONE ctermfg=White       
hi Search       term=NONE cterm=NONE ctermbg=Yellow      
hi VertSplit    term=NONE cterm=NONE ctermfg=Black       
hi Directory    term=NONE cterm=NONE ctermfg=Green       
hi WarningMsg   term=NONE cterm=NONE ctermfg=Blue        
hi Error        term=NONE cterm=NONE ctermfg=DarkRed     
hi Cursor                            ctermfg=Black       
hi LineNr       term=NONE cterm=NONE ctermfg=Red         

" GUI Color Scheme
hi Normal       gui=NONE     guifg=White   guibg=#110022
hi NonText      gui=NONE     guifg=#ff9999 guibg=#444444
hi Function     gui=NONE     guifg=#7788ff guibg=#110022
hi Statement    gui=BOLD     guifg=Yellow  guibg=#110022
hi Special      gui=NONE     guifg=Cyan    guibg=#110022
hi Constant     gui=NONE     guifg=#ff9900 guibg=#110022
hi Comment      gui=NONE     guifg=#99cc99 guibg=#110022
hi Preproc      gui=NONE     guifg=#33ff66 guibg=#110022
hi Type         gui=NONE     guifg=#ff5577 guibg=#110022
hi Identifier   gui=NONE     guifg=Cyan    guibg=#110022
hi StatusLine   gui=BOLD     guifg=White   guibg=#336600
hi StatusLineNC gui=NONE     guifg=Black   guibg=#cccccc
hi Visual       gui=NONE     guifg=White   guibg=#00aa33
hi Search       gui=BOLD     guibg=Yellow  guifg=DarkBlue
hi VertSplit    gui=NONE     guifg=White   guibg=#666666
hi Directory    gui=NONE     guifg=Green   guibg=#110022
hi WarningMsg   gui=STANDOUT guifg=#0000cc guibg=Yellow
hi Error        gui=NONE     guifg=White   guibg=Red
hi Cursor                    guifg=White   guibg=#00ff33
hi LineNr       gui=NONE     guifg=#cccccc guibg=#334444
hi ModeMsg      gui=NONE     guifg=Blue    guibg=White
hi Question     gui=NONE     guifg=#66ff99 guibg=#110022
