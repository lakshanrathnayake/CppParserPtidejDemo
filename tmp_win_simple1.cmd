@echo off
set "JAVA_HOME=C:\Progra~1\Java\jdk-25"
set "PATH=%JAVA_HOME%\bin;%PATH%"
cd /d H:\PROJECTS\Fiverr\CppParserPtidejDemo
call C:\apache-maven-3.9.8\bin\mvn.cmd -f "H:\PROJECTS\Fiverr\CppParserPtidejDemo\PADL Creator C++ (Eclipse)\pom.xml" -Dmaven.plugin.validation=NONE -Dtest=padl.creator.cppfile.eclipse.test.simple.Simple1Test surefire:test
exit /b %errorlevel%
