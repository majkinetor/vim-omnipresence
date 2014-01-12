#SingleInstance, force
    SetParams()
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
return

SetParams() {
    global

    gHotKey       := "F12"
    gRunOnStartup := true
    gVimPath     := "C:\Program Files (x86)\vim\vim74\gvim.exe"
    gVimOptions   := "+$|startinsert!"
}

GetNewFileName() {
    FormatTime, time, , yyMMdd-HHmmss
    return TEMP . "\mm_vim_aw" . time
}
