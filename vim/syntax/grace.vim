" Vim syntax file

" if exists("b:current_syntax")
"   finish
" endif

syntax keyword basicLanguageKeywords class method
syntax keyword basicLanguageKeywords true false

syntax keyword graceKeyword class method true false

hi def link graceKeyword Identifier
