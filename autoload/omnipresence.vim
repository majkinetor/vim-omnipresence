if exists('g:loaded_omnipresence') | finish | en
let s:save_cpo = &cpo | set cpo&vim

fu! omnipresence#ensure_installed()
    let ahkScript = expand( '%:p:h:h') . '\vim_omni.ahk'
    let cmd = 'cmd.exe /c "start ^"^" ^"' . ahkScript . '^"'
    call system( cmd )
endfu

let &cpo = s:save_cpo | unlet s:save_cpo
let g:loaded_omnipresence = 1
