if exists("b:current_syntax")
    finish
endif

set iskeyword=a-z,A-Z,-,*,_,!,@
" Language keywords
syntax keyword rslKeywords loop break continue if fn let
" Comments
syntax region rslCommentLine start="//" end="$"
" String literals
syntax region rslString start=/\v"/ end=/\v"/ 
" Number literals
syntax region rslNumber start=/\s\d/ skip=/\d/ end=/\s/

" Type names the compiler recognizes
highlight default link rslKeywords Keyword
highlight default link rslCommentLine Comment
highlight default link rslString String
highlight default link rslNumber Number
highlight default link rslEscapes SpecialChar

let b:current_syntax = "rsl"
