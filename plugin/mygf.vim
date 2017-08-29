
fun! GotoFile(file)
    let file = a:file
    let path = ''
    if file =~ '^\.'
        let path = expand('%:p:h') . '/' . file
    else
        for p in split(&path, ',')
            let path = p . '/' . a:file
            if filereadable(path)
                break
            endif
        endfo
    endif
    exe 'conf' 'e' path
endf

nnoremap gf :call GotoFile(expand('<cfile>'))<cr>
