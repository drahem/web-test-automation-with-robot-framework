@echo off
echo ========================================
echo OrangeHRM Test Automation Suite
echo ========================================
echo.

REM Check if virtual environment exists
if not exist "venv\Scripts\activate.bat" (
    echo Virtual environment not found. Creating...
    python -m venv venv
    echo Virtual environment created successfully.
)

REM Activate virtual environment
call venv\Scripts\activate.bat

REM Check if requirements are installed
if not exist "venv\Lib\site-packages\robot" (
    echo Installing dependencies...
    pip install -r requirements.txt
    echo Dependencies installed successfully.
)

echo.
echo Available options:
echo 1. Run all tests
echo 2. Run smoke tests only
echo 3. Run regression tests only
echo 4. Run fast tests (optimized)
echo 5. Run with minimal logging
echo.

set /p choice="Enter your choice (1-5): "

if "%choice%"=="1" (
    echo Running all tests...
    robot --outputdir results tests/
) else if "%choice%"=="2" (
    echo Running smoke tests...
    robot --include smoke --outputdir results tests/
) else if "%choice%"=="3" (
    echo Running regression tests...
    robot --include regression --outputdir results tests/
) else if "%choice%"=="4" (
    echo Running fast tests...
    robot --include fast --outputdir results tests/
) else if "%choice%"=="5" (
    echo Running with minimal logging...
    robot --loglevel WARN --outputdir results tests/
) else (
    echo Invalid choice. Running all tests...
    robot --outputdir results tests/
)

echo.
echo Tests completed! Check results/ folder for reports.
pause 