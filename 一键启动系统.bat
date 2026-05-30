@echo off
chcp 936 >nul
title XinAi Inventory System - Starting
color 0B

set PROJECT_DIR=%~dp0
set TOMCAT_DIR=%PROJECT_DIR%tomcat

echo ==================================================
echo   XinAi Inventory Management System
echo   Starting...
echo ==================================================
echo.

:: Check Java
echo [1/4] Checking Java...
where java >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [FAIL] Java not found. Please install JDK 8+ from https://adoptium.net/
    pause
    exit /b 1
)
echo [OK] Java found.

:: Check Maven
echo [2/4] Checking Maven...
where mvn >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [WARN] Maven not found, checking pre-built WAR...
    if exist "%PROJECT_DIR%target\xinai-inventory.war" (
        echo [OK] Found pre-built WAR, skip build.
        goto SKIP_BUILD
    )
    echo [FAIL] No Maven and no pre-built WAR found.
    pause
    exit /b 1
)
echo [OK] Maven found.

:: Build
echo [3/4] Building project...
cd /d "%PROJECT_DIR%"
mvn clean package -DskipTests -q
if %ERRORLEVEL% NEQ 0 (
    echo [FAIL] Build failed.
    pause
    exit /b 1
)
echo [OK] Build success.

:SKIP_BUILD

:: Deploy
echo [4/4] Deploying to Tomcat...
if exist "%TOMCAT_DIR%\webapps\ROOT" rmdir /s /q "%TOMCAT_DIR%\webapps\ROOT" >nul 2>nul
copy /y "%PROJECT_DIR%target\xinai-inventory.war" "%TOMCAT_DIR%\webapps\ROOT.war" >nul
if %ERRORLEVEL% NEQ 0 (
    echo [FAIL] Deploy failed.
    pause
    exit /b 1
)
echo [OK] Deployed.
echo.

:: Clean temp
if exist "%TOMCAT_DIR%\work\Catalina" rmdir /s /q "%TOMCAT_DIR%\work\Catalina" >nul 2>nul

:: Start Tomcat
echo Starting Tomcat server...

:: Set CATALINA_HOME to our local Tomcat (override any system-wide CATALINA_HOME)
set CATALINA_HOME=%TOMCAT_DIR%
set CATALINA_BASE=%TOMCAT_DIR%
set CATALINA_OPTS=

start "Tomcat-XinAi" "%TOMCAT_DIR%\bin\catalina.bat" run

:: Wait for startup
echo Waiting for server to start...
set WAIT_COUNT=0
:WAIT_LOOP
set /a WAIT_COUNT+=1
timeout /t 2 /nobreak >nul
>nul 2>nul curl -s http://localhost:8080/ && goto STARTED
if %WAIT_COUNT% LSS 25 goto WAIT_LOOP

echo [WARN] Server may still be starting. Please refresh http://localhost:8080 manually.
goto OPEN_BROWSER

:STARTED
echo [OK] Tomcat is running.

:OPEN_BROWSER
echo.
echo ==================================================
echo  System ready!
echo  URL: http://localhost:8080
echo.
echo  Login Accounts:
echo    YH040401 / 123456  (Admin)
echo    YH010101 / 123456  (Purchase)
echo    YH020201 / 123456  (Sales)
echo    YH030301 / 123456  (Warehouse)
echo.
echo  To stop: run stop.bat
echo ==================================================
echo.

start http://localhost:8080

echo Press any key to stop the server...
pause >nul

echo Stopping Tomcat...
set CATALINA_HOME=%TOMCAT_DIR%
set CATALINA_BASE=%TOMCAT_DIR%
call "%TOMCAT_DIR%\bin\shutdown.bat" >nul 2>nul
timeout /t 3 /nobreak >nul
echo Server stopped.
pause
