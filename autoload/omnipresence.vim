let s:RootDir = expand( '<sfile>:p:h:h')
let s:AhkScriptName = 'vim_omni.exe'

if exists('g:loaded_omnipresence') | finish | en

let s:save_cpo = &cpo | set cpo&vim

fu! omnipresence#ensure_running()
    if has('win32')
        let ahkScriptPath = s:RootDir . '\os\windows\' . s:AhkScriptName
        if !filereadable( ahkScriptPath ) | retu | en

        let cmd = printf('tasklist /FI "IMAGENAME eq %s" /FO csv /NH', s:AhkScriptName)
        let r = system(cmd)
        if r =~ '^INFO: No tasks'
            let cmd = 'cmd.exe /c "start ^"^" ^"' . ahkScriptPath . '^"'
            call system( cmd )
        en
    en
endfu

let &cpo = s:save_cpo | unlet s:save_cpo
let g:loaded_omnipresence = 1
