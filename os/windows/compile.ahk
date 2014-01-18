scriptName := "vim_omni"
SplitPath, A_AhkPath, ,ahk_dir

RunWait, taskkill /IM %scriptName%.exe
RunWait, %ahk_dir%\Compiler\Ahk2Exe.exe /in %scriptName%.ahk /icon vim.ico

if (!FileExist(scriptName ".exe"))
     MsgBox Compilation failed!
else MsgBox Exe created!
