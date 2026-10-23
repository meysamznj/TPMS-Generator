@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo ========================================================
echo   TPMS CAD Generator - Launching Studio
echo ========================================================
echo.

:: 1. Verify Python is installed and accessible in PATH
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Python was not found in your system PATH!
    echo Please install Python 3.9+ from https://www.python.org/
    echo Make sure to check "Add Python to PATH" during installation.
    echo.
    pause
    exit /b 1
)

:: 2. Check if required libraries are installed
python -c "import PyQt6, numpy, scipy, skimage, trimesh, manifold3d, pyvista, pyvistaqt" >nul 2>nul
if %errorlevel% neq 0 (
    echo [SETUP] Required libraries missing or incomplete.
    echo [SETUP] Automatically installing dependencies from requirements.txt...
    echo.
    python -m pip install --upgrade pip
    python -m pip install -r requirements.txt
    if %errorlevel% neq 0 (
        echo.
        echo [ERROR] Dependency installation failed!
        echo Please ensure you have internet access and run:
        echo   pip install -r requirements.txt
        echo.
        pause
        exit /b 1
    )
    echo.
    echo [SETUP] All dependencies successfully installed!
    echo.
)

:: 3. Launch Desktop CAD Studio
echo Starting TPMS Generator...
python app.py
if %errorlevel% neq 0 (
    echo.
    echo ========================================================
    echo [ERROR] Application exited with error code %errorlevel%
    if exist crash_log.txt (
        echo --- CRASH LOG ---
        type crash_log.txt
        echo -----------------
    )
    echo ========================================================
    pause
)
