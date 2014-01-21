#Singleinstance, ignore     ;strange: if you change this to force, RunWait gvim doesn't return ever...
    GetParams()
    if (g_uninstall = 1)
         Uninstall()
    else Install()

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
    SendInput, ^v
    clipboard := x
    FileDelete, %fname%     ;delete for now, maybe save later
return

GetParams() {
    local cfgSection, i, k

    ; Default values
    g_config     := A_ScriptDir . "\..\..\config.ini"
    g_vimoptions  = "+set ff=dos" "+$|startinsert!"
    g_hotkey     := "F12"
    g_path       := A_ProgramFiles "\vim\vim74\gvim.exe"

    ; Parse config
    IniRead, cfgSection, %g_config%, Config
    Loop, parse, cfgSection, `n, `r
        i := InStr(A_LoopField,"="), k := SubStr(A_LoopField, 1, i-1), g_%k% := SubStr(A_LoopField, i+1)

    FileGetTime, g_cfgTime, %g_config%, M
}

GetNewFileName() {
    FormatTime, time, , yyMMdd-HHmmss
    return TEMP . "\mm_vim_aw" . time
}

Install() {
    lnk = %A_Startup%\%A_ScriptName%.lnk
    if !FileExist(lnk)
        FileCreateShortcut, %A_ScriptDir%\AutoHotkey.exe, %lnk% , %A_ScriptDir%, %A_ScriptFullPath%
}

Uninstall() {

    lnk = %A_Startup%\%A_ScriptName%.lnk
    if FileExist(lnk)
    {
        Msgbox Vim-omnipresence is going to be uninstalled.
        FileDelete, %lnk%
    }
    else Msgbox Vim-omnipresence is uninstalled.`n`nTo enable it delete 'Config.ini' file and enable vim plugin in your .vimrc .
    Exit
}
