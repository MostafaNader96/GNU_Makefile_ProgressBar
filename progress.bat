@echo off
SETLOCAL EnableDelayedExpansion
set /a x=0
IF NOT exist progress.txt (
echo 0 > progress.txt
)
for /F "tokens=1" %%i in (progress.txt) do (
 set  x=%%i
set /a x=!x!+1
echo !x! > progress.txt )

exit