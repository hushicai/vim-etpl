" etpl syntax

if exists('b:current_syntax')
    finish
endif

ru! syntax/html.vim
ru! after/syntax/html.vim

syntax case ignore

" eg: <!-- target: test -->
syntax match etplDefStart /<!--\s*[[:alnum:]]\+\s*:[^:]\+\s*-->/ contains=etplMarkerStart,etplMarkerEnd,etplCommandStart,etplFunction,etplVariable
" eg: <!-- /target -->
syntax match etplDefEnd /<!--\s*\/[[:alnum:]]\+\s*-->/ contains=etplMarkerStart,etplMarkerEnd,etplCommandEnd

" etpl marker
syntax match etplMarkerStart /<!--/ contained nextgroup=etplCommandStart,etplCommandEnd
syntax match etplMarkerEnd /-->/ contained

" etpl command
syntax match etplCommandStart /\w\+\s*:/me=e-1 contained nextgroup=etplMarkerEnd
syntax match etplCommandEnd /\/\w\+/ms=s+1 contained nextgroup=etplMarkerEnd


syntax match etplVariable /\${\s*\*\=\s*.\{-}\s*}/ contains=etplVariableInside
syntax region etplVariableInside start='{'ms=s+1 end='}'me=e-1 contained 
    \ contains=etplOperator,etplPipeline,etplFunction

syntax match etplPipeline "\s*|\s*" contained
" syntax match etplPropertyAccess "\." contained
syntax match etplOperator /[\.+*\/()\[\]-]/ contained

syntax match etplFunction /[[:alnum:]_-]\+(.\{-})/ contained
    \ contains=etplFunctionName,etplParameter,etplVariable,etplParameterString,etplParameterNumber,etplParameterInside
syntax match etplFunctionName /[[:alnum:]_-]\+\s*(/me=e-1 contained nextgroup=etplParameter
syntax match etplParameterInside /[[:alnum:]_-]\+=/me=e-1 contained
syntax match etplParameterString /\(['"]\).\{-}\1/ms=s+1,me=e-1 contained
syntax match etplParameterNumber /[[:digit:]]\+/ contained

syntax match etplComment /<!--\s*\/\/\s*.\{-}\s*-->/ contains=etplCommentText
syntax region etplCommentText matchgroup=etplCommentText start=/\/\//ms=s+2 end=/-->/me=e-3 contained

hi def link etplMarkerStart Underlined
hi def link etplMarkerEnd Underlined
hi def link etplVariable Underlined
hi def link etplPipeline Underlined
hi def link etplVariableInside Statement
hi def link etplCommand Type
hi def link etplCommandStart Type
hi def link etplCommandEnd Type
hi def link etplFunctionName Special
hi def link etplParameterInside Constant
hi def link etplParameterNumber Constant
hi def link etplParameterString Constant
hi def link etplComment Comment
hi def link etplCommentText Todo

let b:current_syntax='etpl'
