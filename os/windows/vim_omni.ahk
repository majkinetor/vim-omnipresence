#SingleInstance, force
    SetParams()
    TryInstall()

    Hotkey, %gHotKey%, Launch_vim

    Menu, Tray, Icon, vim.ico
    Menu, Tray, Tip, Vim hotkey launcher (press %gHotKey%).`nInstalled by vim plugin vim-omnipresence.
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

    gHotKey       := "F12"
    gRunOnStartup := true
    gVimOptions   := "+$|startinsert!"
    gVimPath := "C:\Program Files (x86)\vim\vim74\gvim.exe"
}

GetNewFileName() {
    FormatTime, time, , yyMMdd-HHmmss
    return TEMP . "\mm_vim_aw" . time
}

TryInstall() {
    lnk = %A_Startup%\%A_ScriptName%.lnk
    if !FileExist(lnk)
        FileCreateShortcut, %A_ScriptFullPath%, %lnk% , %A_ScriptDir%
   
   ;Filedelete, %A_Startup%\%A_ScriptName%.lnk
}


;exe "Open " . expand('%')
