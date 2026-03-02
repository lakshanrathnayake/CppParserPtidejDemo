@echo off
set "JAVA_HOME=C:\Progra~1\Java\jdk-25"
set "PATH=%JAVA_HOME%\bin;%PATH%"
cd /d "C:\Users\H P\Desktop\latestchange\CppParserPtidejDemo"
call "C:\Program Files\apache-maven-3.9.11\bin\mvn.cmd" -f "C:\Users\H P\Desktop\latestchange\CppParserPtidejDemo\pom.xml" -pl "PADL Creator C++ (Eclipse)" -am -Dmaven.plugin.validation=NONE -Dtest=padl.creator.cppfile.eclipse.test.simple.Simple1Test -Dsurefire.failIfNoSpecifiedTests=false test
exit /b %errorlevel%
