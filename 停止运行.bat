@echo off
chcp 936 >nul
title XinAi - Stopping
color 0C

echo Stopping XinAi Inventory System...
echo.

set TOMCAT_DIR=%~dp0tomcat

:: Override system CATALINA_HOME to use our local Tomcat
set CATALINA_HOME=%TOMCAT_DIR%
set CATALINA_BASE=%TOMCAT_DIR%

if exist "%TOMCAT_DIR%\bin\shutdown.bat" (
    echo Shutting down Tomcat...
    call "%TOMCAT_DIR%\bin\shutdown.bat" >nul 2>nul
)

:: Kill any remaining Java Tomcat processes
echo Cleaning up remaining processes...
for /f "tokens=2" %%p in ('tasklist ^| findstr /i "java.exe" ^| findstr /i "catalina"') do (
    taskkill /F /PID %%p >nul 2>nul
)

timeout /t 2 /nobreak >nul

echo.
echo ==================================================
echo  Server stopped successfully.
echo ==================================================
echo.
pause
