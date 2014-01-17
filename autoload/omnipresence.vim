let s:RootDir = expand( '<sfile>:p:h:h')

if exists('g:loaded_omnipresence') | finish | en

let s:save_cpo = &cpo | set cpo&vim

fu! omnipresence#ensure_running()
    let ahkScript = s:RootDir . '\bin\vim_omni.exe'
    if !filereadable( ahkScript ) | retu | en

    let cmd = 'cmd.exe /c "start ^"^" ^"' . ahkScript . '^"'
    call system( cmd )
endfu

let &cpo = s:save_cpo | unlet s:save_cpo
let g:loaded_omnipresence = 1
