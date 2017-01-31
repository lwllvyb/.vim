syn keyword nilConstValue nil
syn keyword nilStatement ret break continue for if while let
syn keyword nilDefine    fun
syn keyword nilOperator and or not
syn keyword nilKeyword to in
syn keyword Boolean		true false

syn region nilString start=/'/ end=/'/ skip=/\\'/
syn region nilString start=/"/ end=/"/ skip=/\\"/

syn match Label /\s\/\w\+/ms=s+1
syn match Number /\W\d\+/ms=s+1
syn match nilOperator	/=\|+\|\.\.\|-\|\*\|\//
syn match nilDefine /->/
syn match Comment /#.*$/
syn match Keyword /?/
hi link nilStatement Statement
hi link nilOperator Operator
hi link nilString String
hi link nilDefine Define
hi link nilKeyword Keyword

let b:current_syntax = "nil"
