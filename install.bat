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

IF EXIST "C:\ProgramData\fwdns" (
    echo ERROR: fwdns already installed, run remove.bat before install
	pause
	exit /b
)

echo Creating folder C:\ProgramData\fwdns
mkdir C:\ProgramData\fwdns

echo Copying fwdns files
copy %~dp0\install.bat C:\ProgramData\fwdns\install.bat
copy %~dp0\remove.bat C:\ProgramData\fwdns\remove.bat
copy %~dp0\fwdns.ps1 C:\ProgramData\fwdns\fwdns.ps1
copy %~dp0\fwdns-task.xml C:\ProgramData\fwdns\fwdns-task.xml

echo Register fwdns scheduler task
schtasks /create /tn "fwdns" /xml "C:\ProgramData\fwdns\fwdns-task.xml"

echo Run fwdns once
schtasks /run /tn "fwdns"

echo Ended
pause