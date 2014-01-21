let s:save_cpo = &cpo | set cpo&vim
if exists('g:loaded_omnipresence') | finish | en

let s:RootDir   = expand('<sfile>:p:h:h')
let s:Ahk       = shellescape(s:RootDir . '/os/windows/AutoHotKey.exe')
let s:AhkScript = shellescape(s:RootDir . '/os/windows/vim_omni.ahk')

let s:config    = s:RootDir . '/Config.ini'
let s:cfg_lines = filereadable(s:config) ? readfile(s:config) : []
let s:disabled  = index(s:cfg_lines, 'disabled=1') != -1
let s:uninstall = index(s:cfg_lines, 'uninstall=1') != -1


fu! s:run_ahk()
    sil exe  '!start ' . s:Ahk . ' ' . s:AhkScript
endf

fu! s:config_update()
    let cfg = s:config_createlist()
    if !s:config_shouldUpdate(cfg) | retu | en
    call writefile(cfg, s:config)
endfu

fu! s:config_createlist()
    let lines = ['[Config]']
    let lines += [ 'path=' . $VIMRUNTIME . '/gvim.exe']

    let vars = [ 'hotkey', 'vimoptions', 'uninstall', 'disabled' ]
    for var in vars
        let g_var = 'g:omnipresence_' . var
        let s_var = 's:' . var
        if exists(g_var) | let lines += [ printf('%s=%s', var, eval(g_var)) ] | en
        if exists(s_var) | let lines += [ printf('%s=%s', var, eval(s_var)) ] | en
    endfor
    retu lines
endfu

fu! s:config_shouldUpdate(cfg)
    if !filereadable(s:config) | retu 1| en
    let lines = readfile(s:config)

    let a = join(lines, '\n')
    let b = join(a:cfg, '\n')

    retu a!=b
endfu


fu! omnipresence#ensure_running()
    if s:uninstall | retu | en

    call s:config_update()
    if has('win32')
        call s:run_ahk()
    en
endfu

fu! omnipresence#toggle()
   let s:disabled = !s:disabled
   call s:config_update()
endfu

fu! omnipresence#uninstall()
    let s:uninstall=1
    call s:config_update()
endfu

let &cpo = s:save_cpo | unlet s:save_cpo
let g:loaded_omnipresence = 1
