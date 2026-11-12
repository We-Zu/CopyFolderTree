@echo off
setlocal EnableExtensions
title 安装 - 复制文件夹结构到剪贴板

:: 检查管理员权限
net session >nul 2>&1
if errorlevel 1 (
    echo [错误] 请右键以管理员身份运行此脚本。
    pause
    exit /b 1
)

:: 当前 BAT 所在目录
set "BAT_DIR=%~dp0"
set "PS1_SOURCE=%BAT_DIR%Copy_folder_structure_to_clipboard.ps1"
set "TARGET_DIR=%LOCALAPPDATA%\CopyFolderTree"
set "PS1_TARGET=%TARGET_DIR%\CopyFolderTree.ps1"
set "REG_KEY=HKEY_CLASSES_ROOT\Directory\shell\CopyFolderTree"

:: 检查同目录下是否存在 ps1 文件
if not exist "%PS1_SOURCE%" (
    echo [错误] 未找到 PowerShell 脚本：
    echo        %PS1_SOURCE%
    echo.
    echo 请确保 “Copy_folder_structure_to_clipboard.ps1” 与当前 BAT 文件在同一个文件夹中。
    pause
    exit /b 1
)

:: 创建目标目录并复制脚本
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"
copy /Y "%PS1_SOURCE%" "%PS1_TARGET%" >nul
if errorlevel 1 (
    echo [错误] 复制 PowerShell 脚本失败，请检查权限。
    pause
    exit /b 1
)

:: 写入右键菜单
:: 菜单显示名称
reg add "%REG_KEY%" /ve /t REG_SZ /d "复制文件夹结构到剪贴板" /f >nul
:: 可选：设置图标（使用系统文件夹图标）
reg add "%REG_KEY%" /v Icon /t REG_SZ /d "imageres.dll,-3" /f >nul
:: 命令：调用 PowerShell 执行脚本，%%1 会原样写入注册表，代表右键点击的文件夹路径
reg add "%REG_KEY%\command" /ve /t REG_SZ /d "powershell.exe -NoProfile -ExecutionPolicy Bypass -File \"%PS1_TARGET%\" \"%%1\"" /f >nul
if errorlevel 1 (
    echo [错误] 写入注册表失败。
    pause
    exit /b 1
)

echo.
echo ========================================
echo  安装成功！
echo  现在你可以右键点击任意文件夹，
echo  选择「复制文件夹结构到剪贴板」。
echo ========================================
echo.
pause
exit /b 0