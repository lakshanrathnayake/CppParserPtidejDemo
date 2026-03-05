@echo off
setlocal
if not defined JAVA_HOME (
  if exist "C:\Program Files\Java\jdk-25\bin\java.exe" set "JAVA_HOME=C:\Program Files\Java\jdk-25"
  if not defined JAVA_HOME if exist "C:\Program Files\Java\jdk-22\bin\java.exe" set "JAVA_HOME=C:\Program Files\Java\jdk-22"
)
if defined JAVA_HOME set "PATH=%JAVA_HOME%\bin;%PATH%"

cd /d "%~dp0"
call mvn -f "pom.xml" -pl "PADL Creator C++ (Eclipse)" -am -DforkedProcessTimeoutInSeconds=900 test
if not "%errorlevel%"=="0" (
  call mvn -f "pom.xml" -pl "PADL Creator C++ (Eclipse)" -am -Dsurefire.rerunFailingTestsCount=2 -DforkedProcessTimeoutInSeconds=900 test
)
exit /b %errorlevel%
