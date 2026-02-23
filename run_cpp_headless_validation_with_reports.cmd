@echo off
setlocal EnableExtensions EnableDelayedExpansion

if not defined JAVA_HOME (
  if exist "C:\Program Files\Java\jdk-25\bin\java.exe" set "JAVA_HOME=C:\Program Files\Java\jdk-25"
  if not defined JAVA_HOME if exist "C:\Program Files\Java\jdk-22\bin\java.exe" set "JAVA_HOME=C:\Program Files\Java\jdk-22"
)
if defined JAVA_HOME set "PATH=%JAVA_HOME%\bin;%PATH%"

for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd-HHmmss"') do set "TS=%%i"
set "ROOT=%~dp0"
set "OUT_DIR=%ROOT%test-outputs\runs\%TS%"
mkdir "%OUT_DIR%" >nul 2>&1

echo Timestamp: %TS%> "%OUT_DIR%\RUN_SUMMARY.md"
echo Java home: %JAVA_HOME%>> "%OUT_DIR%\RUN_SUMMARY.md"
echo Workspace: %ROOT%>> "%OUT_DIR%\RUN_SUMMARY.md"
echo.>> "%OUT_DIR%\RUN_SUMMARY.md"

cd /d "%ROOT%"

echo Running headless C++ suite...
call mvn -f "pom.xml" -pl "PADL Creator C++ (Eclipse)" -am -Dtest=padl.creator.cppfile.eclipse.test.TestCreatorCPPFileUsingEclipse -Dsurefire.failIfNoSpecifiedTests=false -DforkedProcessTimeoutInSeconds=900 test > "%OUT_DIR%\01_headless_cpp_suite.log" 2>&1
set "RC1=!errorlevel!"

echo Running PADL JNI suite...
call mvn -f "PADL JNI Tests\pom.xml" -Dtest=padl.creator.cppfile.eclipse.test.big.TestPADLJNI -Dsurefire.failIfNoSpecifiedTests=false -DforkedProcessTimeoutInSeconds=900 test > "%OUT_DIR%\02_padl_jni_suite.log" 2>&1
set "RC2=!errorlevel!"

echo Running QMOOD suite...
call mvn -f "POM\pom.xml" -Dtest=pom.test.cppfile.general.QMOODMetricsTest -Dsurefire.failIfNoSpecifiedTests=false test > "%OUT_DIR%\03_qmood_suite.log" 2>&1
set "RC3=!errorlevel!"

if not "!RC1!"=="0" (
  echo Retrying headless C++ suite once...
  call mvn -f "pom.xml" -pl "PADL Creator C++ (Eclipse)" -am -Dtest=padl.creator.cppfile.eclipse.test.TestCreatorCPPFileUsingEclipse -Dsurefire.failIfNoSpecifiedTests=false -Dsurefire.rerunFailingTestsCount=1 -DforkedProcessTimeoutInSeconds=900 test > "%OUT_DIR%\01_headless_cpp_suite_retry.log" 2>&1
  set "RC1=!errorlevel!"
)

echo ## Result Summary>> "%OUT_DIR%\RUN_SUMMARY.md"
echo 1. Headless CPP suite exit code: !RC1!>> "%OUT_DIR%\RUN_SUMMARY.md"
echo 2. PADL JNI suite exit code: !RC2!>> "%OUT_DIR%\RUN_SUMMARY.md"
echo 3. QMOOD suite exit code: !RC3!>> "%OUT_DIR%\RUN_SUMMARY.md"
echo.>> "%OUT_DIR%\RUN_SUMMARY.md"
echo ## Log Files>> "%OUT_DIR%\RUN_SUMMARY.md"
echo 1. 01_headless_cpp_suite.log>> "%OUT_DIR%\RUN_SUMMARY.md"
echo 2. 01_headless_cpp_suite_retry.log (only if retry was needed)>> "%OUT_DIR%\RUN_SUMMARY.md"
echo 3. 02_padl_jni_suite.log>> "%OUT_DIR%\RUN_SUMMARY.md"
echo 4. 03_qmood_suite.log>> "%OUT_DIR%\RUN_SUMMARY.md"

if not "!RC1!"=="0" (
  echo.
  echo One or more suites failed. See "%OUT_DIR%\RUN_SUMMARY.md"
  exit /b 1
)
if not "!RC2!"=="0" (
  echo.
  echo One or more suites failed. See "%OUT_DIR%\RUN_SUMMARY.md"
  exit /b 1
)
if not "!RC3!"=="0" (
  echo.
  echo One or more suites failed. See "%OUT_DIR%\RUN_SUMMARY.md"
  exit /b 1
)

echo.
echo All requested suites passed. See "%OUT_DIR%\RUN_SUMMARY.md"
exit /b 0
