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

echo [STEP 1] Installing local CDT JARs into Maven repo...
call mvn -f "PADL Creator C++ (Eclipse)\pom.xml" validate
if %errorlevel% neq 0 (
  echo [ERROR] Failed to install CDT JARs.
  exit /b %errorlevel%
)

echo [STEP 2] Building and testing PADL Creator C++ (Eclipse)...
call mvn -U -f "pom.xml" -pl "PADL Creator C++ (Eclipse)" -am ^
  -Dtest=padl.creator.cppfile.eclipse.test.simple.Simple1Test ^
  -Dsurefire.failIfNoSpecifiedTests=false ^
  -DforkedProcessTimeoutInSeconds=600 ^
  clean test
exit /b %errorlevel%