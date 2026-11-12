@echo off
setlocal EnableExtensions
title 卸载 - 复制文件夹结构到剪贴板

:: 检查管理员权限
net session >nul 2>&1
if errorlevel 1 (
    echo [错误] 请右键以管理员身份运行此脚本。
    pause
    exit /b 1
)

set "TARGET_DIR=%LOCALAPPDATA%\CopyFolderTree"
set "REG_KEY=HKEY_CLASSES_ROOT\Directory\shell\CopyFolderTree"

echo 正在删除右键菜单...
reg delete "%REG_KEY%" /f >nul 2>&1
if errorlevel 1 (
    echo [提示] 未找到注册表项，可能已经卸载过了。
) else (
    echo 右键菜单已删除。
)

echo 正在删除本地脚本文件...
if exist "%TARGET_DIR%" (
    rd /s /q "%TARGET_DIR%" >nul 2>&1
    echo 本地脚本目录已删除。
) else (
    echo [提示] 本地脚本目录不存在。
)

echo.
echo ========================================
echo  卸载完成。
echo ========================================
echo.
pause
exit /b 0