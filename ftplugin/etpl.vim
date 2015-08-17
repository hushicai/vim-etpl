
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

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
