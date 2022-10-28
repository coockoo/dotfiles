let g:colors_name = 'custom'
set background=dark

" Global highlights
hi ColorColumn  ctermfg=NONE ctermbg=7    cterm=NONE
hi Comment      ctermfg=8    ctermbg=NONE cterm=NONE
hi Constant     ctermfg=1    ctermbg=NONE cterm=NONE
hi Conceal      ctermfg=7    ctermbg=NONE cterm=NONE
hi DiffAdd      ctermfg=2    ctermbg=NONE cterm=NONE
hi DiffChange   ctermfg=11   ctermbg=NONE cterm=NONE
hi DiffDelete   ctermfg=1    ctermbg=NONE cterm=NONE
hi Directory    ctermfg=4    ctermbg=NONE cterm=NONE
hi Error        ctermfg=0    ctermbg=1    cterm=NONE term=NONE
hi Folded       ctermfg=15   ctermbg=67   cterm=NONE
hi FoldColumn   ctermfg=15   ctermbg=NONE cterm=NONE
hi Identifier   ctermfg=14   ctermbg=NONE cterm=NONE
hi LineNr       ctermfg=130  ctermbg=NONE cterm=NONE
hi Pmenu        ctermfg=0    ctermbg=255  cterm=NONE
hi PreProc      ctermfg=1    ctermbg=NONE cterm=NONE
hi SignColumn   ctermfg=NONE ctermbg=NONE cterm=NONE
hi Special      ctermfg=5    ctermbg=NONE cterm=NONE
hi Statement    ctermfg=130  ctermbg=NONE cterm=NONE
hi Title        ctermfg=5    ctermbg=NONE cterm=NONE
hi Todo         ctermfg=8    ctermbg=NONE cterm=BOLD
hi Type         ctermfg=2    ctermbg=NONE cterm=NONE
hi Underlined   ctermfg=11   ctermbg=NONE cterm=UNDERLINE

" js
hi def link jsArrowFunction  Noise
hi def link jsOperator       Noise
hi def link jsVariableDef    Identifier
hi def link jsFuncCall       Identifier

hi jsIfElseBraces        ctermfg=3   ctermbg=NONE
hi jsRepeatBraces        ctermfg=3   ctermbg=NONE
hi jsTryCatchBraces      ctermfg=3   ctermbg=NONE
hi jsClassBraces         ctermfg=3   ctermbg=NONE
hi jsClassProperty       ctermfg=3   ctermbg=NONE

hi jsStorageClass        ctermfg=5   ctermbg=NONE
hi jsClassKeyword        ctermfg=5   ctermbg=NONE
hi jsExtendsKeyword      ctermfg=5   ctermbg=NONE
hi jsFunction            ctermfg=5   ctermbg=NONE
hi jsExportDefault       ctermfg=5   ctermbg=NONE
hi jsAsyncKeyword        ctermfg=5   ctermbg=NONE
hi jsOperatorKeyword     ctermfg=5   ctermbg=NONE cterm=NONE

hi jsRestOperator        ctermfg=14  ctermbg=NONE
hi jsSpreadOperator      ctermfg=14  ctermbg=NONE
hi jsTernaryIfOperator   ctermfg=14  ctermbg=NONE

hi cssClassName          ctermfg=1   ctermbg=NONE
hi cssClassNameDot       ctermfg=1   ctermbg=NONE
hi lessClass             ctermfg=1   ctermbg=NONE
hi lessMixinChar         ctermfg=1   ctermbg=NONE

hi cssTagName            ctermfg=4   ctermbg=NONE
hi cssBraces             ctermfg=3   ctermbg=NONE
hi cssColor              ctermfg=5   ctermbg=NONE
hi cssUnitDecorators     ctermfg=5   ctermbg=NONE

hi tsVariableType        ctermfg=5   ctermbg=NONE
hi tsImport              ctermfg=5   ctermbg=NONE
hi tsExport              ctermfg=5   ctermbg=NONE
hi tsFunction            ctermfg=5   ctermbg=NONE
hi tsArrowFunction       ctermfg=14  ctermbg=NONE
hi tsInterface           ctermfg=5   ctermbg=NONE
hi tsFunctionBraces      ctermfg=3   ctermbg=NONE
hi tsReturn              ctermfg=1   ctermbg=NONE

hi typescriptReserved       ctermfg=5   ctermbg=NONE
hi typescriptVariable       ctermfg=5   ctermbg=NONE
hi typescriptFuncKeyword    ctermfg=5   ctermbg=NONE
hi typescriptStorageClass   ctermfg=5   ctermbg=NONE
hi typescriptArrowFunc      ctermfg=14  ctermbg=NONE
hi typescriptFuncTypeArrow  ctermfg=2   ctermbg=NONE
hi typescriptTypeAnnotation ctermfg=2   ctermbg=NONE
hi typescriptIdentifier     ctermfg=5   ctermbg=NONE
hi typescriptPredefinedType ctermfg=2   ctermbg=NONE
hi typescriptBraces         ctermfg=14  ctermbg=NONE
hi typescriptParens         ctermfg=14  ctermbg=NONE
hi typescriptLogicSymbols   ctermfg=14  ctermbg=NONE
hi typescriptEndColons      ctermfg=15  ctermbg=NONE
hi typescriptFuncComma      ctermfg=15  ctermbg=NONE
hi typescriptFuncName       ctermfg=3   ctermbg=NONE
hi typescriptGlobal         ctermfg=1   ctermbg=NONE
hi typescriptGlobalMethod   ctermfg=1   ctermbg=NONE
hi typescriptNodeGlobal     ctermfg=1   ctermbg=NONE
hi typescriptTemplate       ctermfg=1   ctermbg=NONE
hi typescriptTemplateSB     ctermfg=15  ctermbg=NONE
hi typescriptObjectLabel    ctermfg=15  ctermbg=NONE
hi tsxTag                   ctermfg=6   ctermbg=NONE
hi tsxCloseTag              ctermfg=6   ctermbg=NONE
hi tsxIntrinsicTagName      ctermfg=6   ctermbg=NONE

" ALE
hi ALEErrorSign   ctermfg=16 ctermbg=1  cterm=bold
hi ALEWarningSign ctermfg=16 ctermbg=11 cterm=bold

hi jsxComponentName ctermfg=6   ctermbg=NONE
hi jsxTagName       ctermfg=6   ctermbg=NONE
hi jsxPunct         ctermfg=6   ctermbg=NONE
hi jsxCloseString   ctermfg=6   ctermbg=NONE

" Coc
hi CocErrorSign   ctermfg=1    ctermbg=NONE
hi CocWarningSign ctermfg=0    ctermbg=255
hi CocInfoSign    ctermfg=4    ctermbg=NONE
hi CocHintSign    ctermfg=12   ctermbg=NONE
hi CocFadeOut                               cterm=underline

hi def link FgCocWarningFloatBgCocFloating  CocWarningSign

" Custom StatusLine colors
hi StatusLineDefault ctermbg=15 ctermfg=16
hi StatusLineMode ctermbg=2 ctermfg=15 cterm=bold
hi StatusLineGitBranch ctermbg=6 ctermfg=15 cterm=bold

" Markdown
hi markdownCode          ctermfg=1    ctermbg=NONE
hi markdownCodeDelimiter ctermfg=1    ctermbg=NONE

" HTML
hi htmlItalic ctermfg=14 ctermbg=NONE cterm=NONE term=NONE
