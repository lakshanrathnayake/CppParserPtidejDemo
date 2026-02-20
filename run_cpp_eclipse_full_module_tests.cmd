@echo off
setlocal
set "JAVA_HOME=C:\Progra~1\Java\jdk-25"
set "PATH=%JAVA_HOME%\bin;C:\apache-maven-3.9.8\bin;%PATH%"

cd /d "%~dp0"
call mvn -f "pom.xml" -pl "PADL Creator C++ (Eclipse)" -am -DforkedProcessTimeoutInSeconds=900 test
if not "%errorlevel%"=="0" (
  call mvn -f "pom.xml" -pl "PADL Creator C++ (Eclipse)" -am -Dsurefire.rerunFailingTestsCount=2 -DforkedProcessTimeoutInSeconds=900 test
)
exit /b %errorlevel%
