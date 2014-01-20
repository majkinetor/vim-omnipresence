#SingleInstance, ignore     ;strange: if you change this to force, RunWait gvim doesn't return ever...
    SetParams()
    TryInstall()

    Hotkey, %g_HotKey%, Launch_vim

    Menu, Tray, Icon, vim.ico
    Menu, Tray, Tip, Vim hotkey launcher (press %g_HotKey%).`nInstalled by vim plugin vim-omnipresence.
return

Launch_vim:
    fname := GetNewFileName()
    x := clipboardall
    Send, ^a^c
    ClipWait, 1
    FileAppend, %clipboard%, %fname%
    RunWait %g_path% %g_vimoptions% -- "%fname%"
    FileRead, clipboard, %fname%
    Send, ^v
    clipboard := x
    FileDelete, %fname%
return

SetParams() {
   local config, pf 

    config := A_ScriptDir . "\..\..\config.ini"

    g_vimoptions := "+$|startinsert!"
    g_hotkey     := "F12"
    g_path       := A_ProgramFiles "\vim\vim74\gvim.exe"

    IniRead, g_hotkey,     %config%, config, hotkey,     %g_hotkey%
    IniRead, g_vimoptions, %config%, config, vimoptions, %g_vimoptions%
    IniRead, g_path,       %config%, config, path,       %g_path%
}

GetNewFileName() {
    FormatTime, time, , yyMMdd-HHmmss
    return TEMP . "\mm_vim_aw" . time
}

TryInstall() {
    lnk = %A_Startup%\%A_ScriptName%.lnk
    if !FileExist(lnk)
        FileCreateShortcut, %A_ScriptFullPath%, %lnk% , %A_ScriptDir%
}


;exe "Open " . expand('%')
