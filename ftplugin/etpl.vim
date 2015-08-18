
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

if !exists('g:etpl_command_open')
    let g:etpl_command_open='<!--'
endif

if !exists('g:etpl_command_close')
    let g:etpl_command_close='-->'
endif

if !exists('g:etpl_variable_open')
    let g:etpl_variable_open='${'
endif
" let g:etpl_variable_open=substitute(g:etpl_variable_open, '[\$]', '\\\0', 'g')

if !exists('g:etpl_variable_close')
    let g:etpl_variable_close='}'
endif

setlocal omnifunc=htmlcomplete#CompleteTags
setlocal comments=s:<!--,m:*,e:-->
setlocal commentstring=<!--%s-->


if exists("loaded_matchit")
  let b:match_words = '<:>,'
              \ . '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,'
              \ . '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,'
              \ . '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>,'
              \ . '\<if\>\s*\:\@=:\<elif\>:/\@<=\<if\>,'
              \ . '\(\<.*\>\)\s*\:\@=:/\@<=\1'
endif
