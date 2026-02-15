@echo off
set "JAVA_HOME=C:\Progra~1\Java\jdk-25"
set "PATH=%JAVA_HOME%\bin;C:\apache-maven-3.9.8\bin;%PATH%"
cd /d H:\PROJECTS\Fiverr\CppParserPtidejDemo
call mvn -U -f "PADL JNI Tests\pom.xml" -Dtest=padl.creator.cppfile.eclipse.test.big.TestPADLJNI -Dsurefire.failIfNoSpecifiedTests=false -DforkedProcessTimeoutInSeconds=600 test
exit /b %errorlevel%
