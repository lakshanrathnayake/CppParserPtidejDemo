@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "ROOT=%~dp0"
set "JAVA_HOME=C:\Program Files\Java\jdk-25"
if not exist "%JAVA_HOME%\bin\java.exe" (
  echo [ERROR] JDK 25 not found at "%JAVA_HOME%".
  exit /b 1
)
set "PATH=%JAVA_HOME%\bin;%PATH%"

set "OUT=%ROOT%test-outputs"
if not exist "%OUT%" mkdir "%OUT%"

cd /d "%ROOT%"

echo Running TestCreatorCPPFileUsingEclipse...
call tmp_run_cpp_suite_reactor_win.cmd > "%OUT%\TestCreatorCPPFileUsingEclipse.txt" 2>&1
set "RC1=!errorlevel!"

echo Running TestPADLJNI...
call tmp_run_padljni_rerun.cmd > "%OUT%\TestPADLJNI.txt" 2>&1
set "RC2=!errorlevel!"

echo Running QMOODMetricsTest...
call tmp_run_qmood_rerun.cmd > "%OUT%\QMOODMetricsTest.txt" 2>&1
set "RC3=!errorlevel!"

(
  echo Test rerun summary generated on %date% %time%
  echo.
  echo File: test-outputs\TestCreatorCPPFileUsingEclipse.txt
  echo Exit code: !RC1!
  if "!RC1!"=="0" (echo Status: PASS) else (echo Status: FAIL)
  echo.
  echo File: test-outputs\TestPADLJNI.txt
  echo Exit code: !RC2!
  if "!RC2!"=="0" (echo Status: PASS) else (echo Status: FAIL)
  echo.
  echo File: test-outputs\QMOODMetricsTest.txt
  echo Exit code: !RC3!
  if "!RC3!"=="0" (echo Status: PASS) else (echo Status: FAIL)
) > "%OUT%\test-run-summary.txt"

if not "!RC1!"=="0" exit /b 1
if not "!RC2!"=="0" exit /b 1
if not "!RC3!"=="0" exit /b 1
exit /b 0
