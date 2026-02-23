@echo off
setlocal
set "ROOT=%~dp0"
if not defined JAVA_HOME (
  if exist "C:\Program Files\Java\jdk-25\bin\java.exe" set "JAVA_HOME=C:\Program Files\Java\jdk-25"
  if not defined JAVA_HOME if exist "C:\Program Files\Java\jdk-22\bin\java.exe" set "JAVA_HOME=C:\Program Files\Java\jdk-22"
)
if defined JAVA_HOME set "PATH=%JAVA_HOME%\bin;%PATH%"
cd /d "%ROOT%"
call mvn -f "pom.xml" -pl "PADL Creator C++ (Eclipse)" -am -Dmaven.plugin.validation=NONE test
exit /b %errorlevel%
