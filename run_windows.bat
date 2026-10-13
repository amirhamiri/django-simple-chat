@echo off
setlocal
cd /d "%~dp0"
where py >nul 2>nul
if %errorlevel%==0 (
    set "PYTHON=py"
) else (
    set "PYTHON=python"
)
if not exist ".venv\Scripts\python.exe" (
    %PYTHON% -m venv .venv
    if errorlevel 1 goto error
)
call ".venv\Scripts\activate.bat"
python -m pip install --upgrade pip
if errorlevel 1 goto error
pip install -r requirements.txt
if errorlevel 1 goto error
python manage.py migrate
if errorlevel 1 goto error
start "" http://127.0.0.1:8000/
python manage.py runserver
goto end
:error
echo.
echo Something went wrong. Check that Python is installed and internet is available.
pause
:end
endlocal
