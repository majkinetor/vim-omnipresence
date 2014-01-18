let s:RootDir = expand( '<sfile>:p:h:h')
let s:AhkScriptName = 'vim_omni.exe'

if exists('g:loaded_omnipresence') | finish | en

let s:save_cpo = &cpo | set cpo&vim

fu! omnipresence#create_config()
    let config = s:RootDir . '/Config.ini'

    if filereadable(config) | retu | en
    let lines = ['[Config]']
    let lines += [ 'path=' . $VIMRUNTIME . '/gvim.exe']
    if exists('g:omnipresence_hotkey')     | let lines += [ 'hotkey=' . g:omnipresence_hotkey ]         | en
    if exists('g:omnipresence_vimoptions') | let lines += [ 'vimoptions=' . g:omnipresence_vimoptions ] | en
    call writefile(lines, config)
endfu

fu! omnipresence#ensure_running()
    call omnipresence#create_config()

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
