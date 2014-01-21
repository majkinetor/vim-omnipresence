#SingleInstance, ignore     ;strange: if you change this to force, RunWait gvim doesn't return ever...
    SetParams()
    TryInstall()

    Hotkey, %g_HotKey%, Launch_vim

    Menu, Tray, Icon, vim.ico
    Menu, Tray, Tip, Vim hotkey launcher (press %g_HotKey%).`nInstalled by vim plugin vim-omnipresence.

    SetTimer, CheckConfig, 5000
return

CheckConfig:
    FileGetTime, _, %g_config%, M
    if ( _ == g_cfgTime)
        return
    Reload
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
    FileDelete, %fname%     ;delete for now, maybe save later
return

SetParams() {
    global

    g_config     := A_ScriptDir . "\..\..\config.ini"
    g_vimoptions  = "+set ff=dos" "+$|startinsert!"
    g_hotkey     := "F12"
    g_path       := A_ProgramFiles "\vim\vim74\gvim.exe"

    IniRead, g_hotkey,     %g_config%, config, hotkey,     %g_hotkey%
    IniRead, g_vimoptions, %g_config%, config, vimoptions, %g_vimoptions%
    IniRead, g_path,       %g_config%, config, path,       %g_path%

    FileGetTime, g_cfgTime, %g_config%, M
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

