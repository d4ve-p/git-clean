@echo off
setlocal

rem Check if sh is directly in PATH
where sh >nul 2>nul
if not errorlevel 1 (
    sh "%~dp0git-clean" %*
    goto :end
)

rem Check standard Git for Windows installation paths
if exist "%ProgramFiles%\Git\bin\sh.exe" (
    "%ProgramFiles%\Git\bin\sh.exe" "%~dp0git-clean" %*
    goto :end
)

if exist "%ProgramFiles(x86)%\Git\bin\sh.exe" (
    "%ProgramFiles(x86)%\Git\bin\sh.exe" "%~dp0git-clean" %*
    goto :end
)

if exist "%LOCALAPPDATA%\Programs\Git\bin\sh.exe" (
    "%LOCALAPPDATA%\Programs\Git\bin\sh.exe" "%~dp0git-clean" %*
    goto :end
)

echo [git-clean] Error: Git for Windows (sh.exe) was not found in PATH or standard directories. >&2
echo Please make sure Git for Windows is installed. >&2
exit /b 1

:end
exit /b %errorlevel%
