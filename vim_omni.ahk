#SingleInstance, force

!k::
    fname := GetNewFileName()
    x := clipboardall
    Send, ^a^c
    FileAppend, %clipboard%, %fname%
    RunWait C:\Program Files (x86)\vim\vim74\gvim.exe "+$|startinsert!" "%fname%"
    FileRead, clipboard, %fname%
    Send, ^v
    clipboard := x
return

GetNewFileName() {
    FormatTime, time, , yyMMdd-HHmmss
    return TEMP . "\mm_vim_aw" . time
}
