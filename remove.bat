; @echo off
chcp 1251 >nul

reg.exe query "HKU\S-1-5-19">nul 2>&1
if %errorlevel% equ 1 goto UACPrompt

goto Program 
exit /b

:UACPrompt
echo Getting admin rights...
mshta "vbscript:CreateObject("Shell.Application").ShellExecute("%~fs0", "", "", "runas", 1) & Close()"
exit /b


:Program

IF NOT EXIST "C:\ProgramData\fwdns" (
    echo ERROR: fwdns not installed
	pause
	exit /b
)

echo Unregister scheduler task fwdns
schtasks /delete /tn "fwdns" /f

echo Removing C:\ProgramData\fwdns
rmdir /s /q C:\ProgramData\fwdns

echo Ended
pause

