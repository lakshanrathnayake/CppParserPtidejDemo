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
call mvn -U -f "PADL JNI Tests\pom.xml" ^
  -Dtest=padl.creator.cppfile.eclipse.test.big.PadlModelJNI ^
  -Dsurefire.failIfNoSpecifiedTests=false ^
  -DforkedProcessTimeoutInSeconds=600 ^
  test
exit /b %errorlevel%