@echo off
setlocal
set "ROOT=%~dp0"
set "JAVA_HOME=C:\Program Files\Java\jdk-25"
if not exist "%JAVA_HOME%\bin\java.exe" (
  echo [ERROR] JDK 25 not found at "%JAVA_HOME%". > "test-outputs\CppModuleFullTests.txt"
  exit /b 1
)
set "PATH=%JAVA_HOME%\bin;%PATH%"
cd /d "%ROOT%"
call mvn -f "pom.xml" -pl "PADL Creator C++ (Eclipse)" -am -Dmaven.plugin.validation=NONE -DforkCount=1 -DreuseForks=false -Dsurefire.rerunFailingTestsCount=1 test > "test-outputs\CppModuleFullTests.txt" 2>&1
exit /b %errorlevel%
