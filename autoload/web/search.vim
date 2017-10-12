
fun! web#search#by(url, keyword)
    call netrw#BrowseX(a:url . a:keyword, 0)
endf

fun! web#search#by_baidu(keyword)
    return web#search#by('https://www.baidu.com/s?wd=', a:keyword)
endf

fun! web#search#by_sougou(keyword)
    return web#search#by('https://www.baidu.com/s?wd=', a:keyword)
endf

fun! web#search#by_youdao(keyword)
    return web#search#by('http://dict.youdao.com/w/eng/', a:keyword)
endf
