" etpl syntax

if exists('b:current_syntax')
    finish
endif

ru! syntax/html.vim
ru! after/syntax/html.vim

syntax case ignore

" eg: <!-- target: test -->
syntax match etplDefStart /<!--\s*[[:alnum:]]\+\s*:[^:]\+\s*-->/
    \ contains=etplMarkerStart,etplMarkerEnd,etplCommandStart,etplFunction,etplExpression,
            \ etplSingleString,etplDoubleString,etplNumber,etplVariable
" eg: <!-- /target -->
syntax match etplDefEnd /<!--\s*\/[[:alnum:]]\+\s*-->/ contains=etplMarkerStart,etplMarkerEnd,etplCommandEnd

" etpl marker
syntax match etplMarkerStart /<!--/ contained nextgroup=etplCommandStart,etplCommandEnd
syntax match etplMarkerEnd /-->/ contained

" eg: <!-- target: test -->
syntax match etplCommandStart /\w\+\s*:/me=e-1 contained nextgroup=etplMarkerEnd
" eg: <!-- /target -->
syntax match etplCommandEnd /\/\w\+/ms=s+1 contained nextgroup=etplMarkerEnd

" eg: ${person.name}
syntax match etplExpression /\${\s*\*\=\s*.\{-}\s*}/ contains=etplExpressionInside
syntax region etplExpressionInside start='{'ms=s+1 end='}'me=e-1 contained 
    \ contains=etplOperator,etplPipeline,etplFunction

syntax match etplPipeline "\s*|\s*" contained
" syntax match etplPropertyAccess "\." contained
syntax match etplOperator /[\.+*\/()\[\]-]/ contained

syntax match etplFunction /[[:alnum:]_-]\+(.\{-})/ contained
    \ contains=etplFunctionName,etplParameter,etplExpression,etplSingleString,etplDoubleString,etplNumber,etplParameterInside
syntax match etplFunctionName /[[:alnum:]_-]\+\s*(/me=e-1 contained nextgroup=etplParameter
syntax match etplParameterInside /[[:alnum:]_-]\+\s*=/me=e-1 contained
syntax match etplNumber /[[:digit:]]\+/ contained
" syntax match etplString /\(['"]\).\{-}\1/ contained
syntax region etplSingleString start=/'/ms=s+1 skip=/\\'/ end=/'/me=e-1 contained oneline
syntax region etplDoubleString start=/"/ms=s+1 skip=/\\"/ end=/"/me=e-1 contained oneline
syntax match etplVariable /[[:alnum:]_-]\+\s*=/me=e-1 contained

syntax match etplComment /<!--\s*\/\/\s*.\{-}\s*-->/ contains=etplCommentText
syntax region etplCommentText matchgroup=etplCommentText start=/\/\//ms=s+2 end=/-->/me=e-3 contained

hi def link etplMarkerStart Underlined
hi def link etplMarkerEnd Underlined
hi def link etplExpression Underlined
hi def link etplPipeline Underlined
hi def link etplExpressionInside Statement
hi def link etplVariable Statement
hi def link etplCommand Type
hi def link etplCommandStart Type
hi def link etplCommandEnd Type
hi def link etplFunctionName Special
hi def link etplParameterInside Constant
hi def link etplNumber Constant
hi def link etplSingleString Constant
hi def link etplDoubleString Constant
hi def link etplComment Comment
hi def link etplCommentText Todo

let b:current_syntax='etpl'
