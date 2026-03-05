@echo off
set "JAVA_HOME=C:\Progra~1\Java\jdk-25"
set "PATH=%JAVA_HOME%\bin;%PATH%"
cd /d H:\PROJECTS\Fiverr\CppParserPtidejDemo
call C:\apache-maven-3.9.8\bin\mvn.cmd -f "H:\PROJECTS\Fiverr\CppParserPtidejDemo\PADL Creator C++ (Eclipse)\pom.xml" -e -Dmaven.plugin.validation=NONE -Dmaven.test.skip=true compile
exit /b %errorlevel%
