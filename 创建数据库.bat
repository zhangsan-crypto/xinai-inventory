@echo off
chcp 936 >nul
title XinAi - DB Init
color 0A

echo ==================================================
echo   XinAi Inventory - Database Initialization
echo ==================================================
echo.

where mysql >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] MySQL not found. Please install MySQL and add to PATH.
    pause
    exit /b 1
)
echo [OK] MySQL found.

set SCRIPT_DIR=%~dp0
if not exist "%SCRIPT_DIR%init.sql" (
    echo [ERROR] init.sql not found.
    pause
    exit /b 1
)
echo [OK] init.sql found.
echo.
echo Initializing database xinai_inventory ...
echo.

echo Please enter MySQL root password (or press Enter if no password):
echo.
mysql -u root -p --default-character-set=utf8mb4 -e "source %SCRIPT_DIR%init.sql"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Database initialization failed.
    echo Possible causes:
    echo   1. MySQL service not running
    echo   2. Wrong root password
    echo   3. No permission to create database
    pause
    exit /b 1
)
echo.
echo ==================================================
echo   [SUCCESS] Database initialized!
echo ==================================================
echo.
echo  Database: xinai_inventory
echo  Test accounts:
echo    YH040401 / 123456  (admin)
echo    YH010101 / 123456  (purchase)
echo    YH020201 / 123456  (sale)
echo    YH030301 / 123456  (warehouse)
echo.
pause
