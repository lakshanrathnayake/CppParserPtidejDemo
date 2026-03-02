@echo off
setlocal
set "ROOT=%~dp0"
set "JAVA_HOME=C:\Program Files\Java\jdk-25"
if not exist "%JAVA_HOME%\bin\java.exe" (
  echo [ERROR] JDK 25 not found at "%JAVA_HOME%".
  exit /b 1
)
set "PATH=%JAVA_HOME%\bin;C:\apache-maven-3.9.11\bin;%PATH%"
cd /d "%ROOT%"
call mvn -U -f "PADL Creator C++ (Eclipse)\pom.xml" ^
  -Dmaven.plugin.validation=NONE ^
  -Dtest=padl.creator.cppfile.eclipse.test.simple.Simple1Test ^
  -DforkedProcessTimeoutInSeconds=600 ^
  surefire:test
exit /b %errorlevel%