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
if exist "PADL Creator C++ (Eclipse) Helper\Runtime Libraries\configuration\org.eclipse.osgi" (
  rmdir /s /q "PADL Creator C++ (Eclipse) Helper\Runtime Libraries\configuration\org.eclipse.osgi"
)
call mvn -f "pom.xml" -pl "PADL Creator C++ (Eclipse)" -am -Dmaven.plugin.validation=NONE -Dtest=padl.creator.cppfile.eclipse.test.TestCreatorCPPFileUsingEclipse -Dsurefire.failIfNoSpecifiedTests=false -DforkCount=1 -DreuseForks=false -Dsurefire.rerunFailingTestsCount=1 clean test
if not "%errorlevel%"=="0" (
  call mvn -f "pom.xml" -pl "PADL Creator C++ (Eclipse)" -am -Dmaven.plugin.validation=NONE -Dtest=padl.creator.cppfile.eclipse.test.TestCreatorCPPFileUsingEclipse -Dsurefire.failIfNoSpecifiedTests=false -DforkCount=1 -DreuseForks=false clean test
)
exit /b %errorlevel%
