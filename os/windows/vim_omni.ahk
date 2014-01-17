#SingleInstance, force
    SetParams()
    Install()
    Hotkey, %gHotKey%, Launch_vim
return

Launch_vim:
    fname := GetNewFileName()
    x := clipboardall
    Send, ^a^c
    ClipWait, 1
    FileAppend, %clipboard%, %fname%
    RunWait %gVimPath% %gVimOptions% -- "%fname%"
    FileRead, clipboard, %fname%
    Send, ^v
    clipboard := x
    FileDelete, %fname%
return

SetParams() {
    global

    gHotKey       := "F11"
    gRunOnStartup := true
    gVimOptions   := "+$|set ff=dos|startinsert!"


    RegRead, gVimPath, HKEY_CURRENT_USER, Software\Classes\vim_auto_file\shell\open\command
    if ErrorLevel
         gVimPath := "C:\Program Files (x86)\vim\vim74\gvim.exe"
    else gVimPath := SubStr(gVimPath, 2, InStr(gVimPath, ".exe")+2)
}

GetNewFileName() {
    FormatTime, time, , yyMMdd-HHmmss
    return TEMP . "\mm_vim_aw" . time
}

Install() {
    lnk = %A_Startup%\%A_ScriptName%.lnk
    if !FileExist(lnk)
        FileCreateShortcut, %A_ScriptFullPath%, %lnk% , %A_ScriptDir%
   ;Filedelete, %A_Startup%\%A_ScriptName%.lnk
}


;exe "Open " . expand('%')
