@echo off
setlocal EnableExtensions

set "ROOT=%~dp0"
set "JAVA_HOME=C:\Program Files\Java\jdk-25"
if not exist "%JAVA_HOME%\bin\java.exe" (
  echo [ERROR] JDK 25 not found at "%JAVA_HOME%".
  exit /b 1
)
set "PATH=%JAVA_HOME%\bin;%PATH%"

cd /d "%ROOT%"

call mvn -f "pom.xml" -pl "DeMIMA UI Viewer Standalone Swing" -am -DskipTests package
if not "%errorlevel%"=="0" (
  echo [ERROR] Maven build failed for DeMIMA UI Viewer Standalone Swing.
  exit /b %errorlevel%
)

set "JAR=DeMIMA UI Viewer Standalone Swing\target\demima-ui-viewer-swing-1.0.0-jar-with-dependencies.jar"
if not exist "%JAR%" (
  echo [ERROR] Expected jar not found: "%JAR%"
  exit /b 1
)

start "" java -jar "%JAR%"
exit /b 0
