@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "JAVA_HOME=C:\Progra~1\Java\jdk-25"
set "PATH=%JAVA_HOME%\bin;C:\apache-maven-3.9.8\bin;%PATH%"

for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd-HHmmss"') do set "TS=%%i"
set "ROOT=%~dp0"
set "OUT_DIR=%ROOT%test-outputs\runs\%TS%"
mkdir "%OUT_DIR%" >nul 2>&1

cd /d "%ROOT%"
call mvn -f "pom.xml" -pl "PADL Creator C++ (Eclipse)" -am -Dsurefire.rerunFailingTestsCount=2 -DforkedProcessTimeoutInSeconds=900 test > "%OUT_DIR%\full_module_cpp_tests.log" 2>&1
set "RC=!errorlevel!"

if not "!RC!"=="0" (
  call mvn -f "pom.xml" -pl "PADL Creator C++ (Eclipse)" -am -Dsurefire.rerunFailingTestsCount=2 -DforkedProcessTimeoutInSeconds=900 test > "%OUT_DIR%\full_module_cpp_tests_retry.log" 2>&1
  set "RC=!errorlevel!"
)

echo Timestamp: %TS%> "%OUT_DIR%\FULL_MODULE_SUMMARY.md"
echo Exit code: !RC!>> "%OUT_DIR%\FULL_MODULE_SUMMARY.md"
echo Log file: full_module_cpp_tests.log>> "%OUT_DIR%\FULL_MODULE_SUMMARY.md"
echo Retry log file: full_module_cpp_tests_retry.log (only if retry happened)>> "%OUT_DIR%\FULL_MODULE_SUMMARY.md"

if not "!RC!"=="0" (
  echo Full module tests failed. See "%OUT_DIR%\FULL_MODULE_SUMMARY.md"
  exit /b !RC!
)

echo Full module tests passed. See "%OUT_DIR%\FULL_MODULE_SUMMARY.md"
exit /b 0
