" Vim color file
" Maintainer:	Piotr Husiatyński <phusiatynski@gmail.com>

set background=dark
set t_Co=88
let g:colors_name="grayvim"

let python_highlight_all = 1
let c_gnu = 1


hi Normal	    ctermfg=White       ctermbg=None       cterm=None
hi Cursor       ctermfg=Red         ctermbg=None       cterm=Bold
hi SpecialKey	ctermfg=LightBlue   ctermbg=None       cterm=None
hi Directory	ctermfg=Green       ctermbg=None       cterm=None
hi ErrorMsg     ctermfg=DarkRed     ctermbg=White      cterm=None
hi PreProc	    ctermfg=LightBlue   ctermbg=None       cterm=Bold
hi Search	    ctermfg=Red         ctermbg=None       cterm=Bold,Italic
hi Type		    ctermfg=Blue        ctermbg=None       cterm=Bold
hi Statement	ctermfg=LightBlue   ctermbg=None       cterm=Italic
hi Comment	    ctermfg=DarkGray    ctermbg=None       cterm=Italic
hi LineNr	    ctermfg=Gray        ctermbg=DarkGray   cterm=Bold
hi NonText	    ctermfg=Blue        ctermbg=None       cterm=Bold
hi StatusLineNC ctermfg=Black       ctermbg=DarkGray       cterm=Bold,Italic
hi StatusLine   ctermfg=Black       ctermbg=DarkGray       cterm=None
hi VertSplit    ctermfg=DarkGray    ctermbg=DarkGray   cterm=Bold
hi DiffText	    ctermfg=Red         ctermbg=White      cterm=None
hi Constant	    ctermfg=Gray        ctermbg=None       cterm=Italic
hi Todo         ctermfg=Magenta     ctermbg=None       cterm=Bold,Italic
hi Identifier	ctermfg=LightCyan   ctermbg=None       cterm=Bold
hi Error	    ctermfg=Black       ctermbg=Red        cterm=Bold
hi Special	    ctermfg=DarkRed     ctermbg=None       cterm=Bold
hi FoldColumn	ctermfg=DarkGray    ctermbg=None       cterm=Bold
hi Ignore       ctermfg=Yellow      ctermbg=None       cterm=Bold
hi Underline    ctermfg=DarkGray    ctermbg=None       cterm=Italic

hi Pmenu        ctermfg=White       ctermbg=DarkGray    cterm=None
hi PmenuSel     ctermfg=None        ctermbg=Gray        cterm=Bold
hi PmenuSbar    ctermfg=DarkGray    ctermbg=DarkGray    cterm=None
hi PmenuThumb   ctermfg=Gray        ctermbg=Gray        cterm=None

"vim: sw=4
