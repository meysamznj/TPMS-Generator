@echo off
title Build Standalone Executable - TPMS Generator
echo ========================================================
echo   Building Standalone Windows Executable (.exe)
echo   Tool: PyInstaller (Single File, Embedded Icon, Windowed)
echo ========================================================
echo.

cd /d "%~dp0"

where python >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Python was not found in your system PATH!
    echo Please install Python 3.9+ and add it to PATH.
    pause
    exit /b 1
)

echo [1/3] Ensuring required packages and PyInstaller are installed...
python -m pip install --upgrade pip
python -m pip install -r requirements.txt pyinstaller

echo.
echo [2/3] Compiling TPMS_Generator.exe...
python -m PyInstaller ^
    --noconsole ^
    --onefile ^
    --icon=icon.ico ^
    --add-data "icon.ico;." ^
    --add-data "icon.png;." ^
    --add-data "icon.svg;." ^
    --hidden-import "vtkmodules" ^
    --hidden-import "vtkmodules.qt.QVTKOpenGLNativeWidget" ^
    --hidden-import "vtkmodules.all" ^
    --collect-all "pyvista" ^
    --collect-all "pyvistaqt" ^
    --collect-all "manifold3d" ^
    --name "TPMS_Generator" ^
    --clean ^
    app.py

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Build failed! Please review PyInstaller logs above.
    pause
    exit /b 1
)

echo.
echo ========================================================
echo [3/3] Build Succeeded!
echo Standalone executable created at:
echo   dist\TPMS_Generator.exe
echo.
echo You can now use this .exe directly.
echo ========================================================
pause
