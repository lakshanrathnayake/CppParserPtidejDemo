@echo off
setlocal
set "ROOT=%~dp0"
set "JAVA_HOME=C:\Program Files\Java\jdk-25"
if not exist "%JAVA_HOME%\bin\java.exe" (
  echo [ERROR] JDK 25 not found at "%JAVA_HOME%".
  exit /b 1
)
set "PATH=%JAVA_HOME%\bin;%PATH%"
cd /d "%ROOT%"
call mvn -f "POM\pom.xml" -Dtest=pom.test.cppfile.general.QMOODMetricsTest -Dsurefire.failIfNoSpecifiedTests=false test
exit /b %errorlevel%
