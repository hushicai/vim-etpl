" etpl syntax

if exists('b:current_syntax')
    finish
endif

ru! syntax/html.vim
ru! after/syntax/html.vim

syntax case ignore

" eg: <!-- target: test -->
exec 'syntax match etplDefStart /' . g:etpl_command_open . '\s*[[:alnum:]]\+\s*:[^:]\+\s*' . g:etpl_command_close . '/ '
    \ . 'contains=etplMarkerStart,etplMarkerEnd,etplCommandStart,etplFunction,etplExpression,'
    \ . 'etplSingleString,etplDoubleString,etplNumber,etplVariable'
" eg: <!-- /target -->
exec 'syntax match etplDefEnd /\(' . g:etpl_command_open . '\)\s*\/[[:alnum:]]\+\s*\(' . g:etpl_command_close . '\)/ '
    \ . 'contains=etplMarkerStart,etplMarkerEnd,etplCommandEnd'

" etpl marker
exec 'syntax match etplMarkerStart /\(' . g:etpl_command_open . '\)/ contained nextgroup=etplCommandStart,etplCommandEnd'
exec 'syntax match etplMarkerEnd /\(' . g:etpl_command_close . '\)/ contained'

" eg: <!-- target: test -->
syntax match etplCommandStart /[[:alnum:]]\+\s*:/me=e-1 contained nextgroup=etplMarkerEnd
" eg: <!-- /target -->
syntax match etplCommandEnd /\/[[:alnum:]]\+/ms=s+1 contained nextgroup=etplMarkerEnd

" eg: ${person.name}
exec 'syntax match etplExpression /\(' . g:etpl_variable_open . '\)\s*\*\=\s*.\{-}\s*\(' . g:etpl_variable_close . '\)/ contains=etplExpressionInside'
exec 'syntax region etplExpressionInside start=/\(' . g:etpl_variable_open . '\)\@<=/ end=/\(' . g:etpl_variable_close . '\)\@=/ contained '
            \ . 'contains=etplOperator,etplPipeline,etplFunction'

syntax match etplPipeline "\s*|\s*" contained
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

exec 'syntax match etplComment /\(' .g:etpl_command_open . '\)\s*\/\/\s*.\{-}\s*' . g:etpl_command_close . '/ contains=etplCommentText'
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
