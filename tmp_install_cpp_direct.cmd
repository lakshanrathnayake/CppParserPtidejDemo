@echo off
setlocal
set "JAVA_HOME=C:\Program Files\Java\jdk-25"
if not exist "%JAVA_HOME%\bin\javac.exe" (
  echo [ERROR] javac not found under "%JAVA_HOME%"
  exit /b 1
)
set "PATH=%JAVA_HOME%\bin;%PATH%"
cd /d "%~dp0"
call mvn -f "PADL Creator C++ (Eclipse)\pom.xml" -DskipTests install
exit /b %errorlevel%
