
fun! textobj#lastpat#n()
    return s:select(0)
endf

fun! textobj#lastpat#N()
    return s:select(1)
endf

fun! s:select(opposite_p)
  let forward_p = (v:searchforward && !a:opposite_p) || (!v:searchforward && a:opposite_p)

  if search(@/, 'ce' . (forward_p ? '' : 'b')) == 0
    return 0
  endif
  let end_position = getpos('.')

  if search(@/, 'bc') == 0
    return 0
  endif
  let start_position = getpos('.')

  return ['v', start_position, end_position]
endf
