@echo off
set "JAVA_HOME=C:\Progra~1\Java\jdk-25"
set "PATH=%JAVA_HOME%\bin;C:\apache-maven-3.9.8\bin;%PATH%"
cd /d H:\PROJECTS\Fiverr\CppParserPtidejDemo
call mvn -f "POM\pom.xml" -Dtest=pom.test.cppfile.general.QMOODMetricsTest -Dsurefire.failIfNoSpecifiedTests=false test
exit /b %errorlevel%
