let s:save_cpo = &cpo | set cpo&vim
if exists('g:loaded_omnipresence') | finish | en

let s:RootDir   = expand('<sfile>:p:h:h')
let s:Ahk       = shellescape(s:RootDir . '/os/windows/AutoHotKey.exe')
let s:AhkScript = shellescape(s:RootDir . '/os/windows/vim_omni.ahk')
let s:config    = s:RootDir . '/Config.ini'

fu! s:run_ahk()
    sil exe  "!start " . s:Ahk . ' ' . s:AhkScript 
endf

fu! s:config_update()
    let cfg = s:config_createlist()
    if !s:config_shouldUpdate(cfg) | retu | en
    call writefile(cfg, s:config)
endfu

fu! s:config_createlist()
    let lines = ['[Config]']
    let lines += [ 'path=' . $VIMRUNTIME . '/gvim.exe']
    if exists('g:omnipresence_hotkey')     | let lines += [ 'hotkey=' . g:omnipresence_hotkey ]         | en
    if exists('g:omnipresence_vimoptions') | let lines += [ 'vimoptions=' . g:omnipresence_vimoptions ] | en
    return lines
endfu

fu! s:config_shouldUpdate(cfg)
    if !filereadable(s:config) | retu 1| en
    let lines = readfile(s:config)

    let a = join(lines, '\n')
    let b = join(a:cfg, '\n')

    return a!=b
endfu


fu! omnipresence#ensure_running()
    call s:config_update()

    if has('win32')
        call s:run_ahk()
    en
endfu

let &cpo = s:save_cpo | unlet s:save_cpo
let g:loaded_omnipresence = 1
