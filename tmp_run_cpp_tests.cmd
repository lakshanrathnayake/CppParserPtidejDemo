@echo off
set "JAVA_HOME=C:\Progra~1\Java\jdk-25"
set "PATH=%JAVA_HOME%\bin;%PATH%"
cd /d "C:\Users\H P\Desktop\latestchange\CppParserPtidejDemo"
call "C:\Program Files\apache-maven-3.9.11\bin\mvn.cmd" -Dmaven.plugin.validation=NONE -Dmaven.compiler.useIncrementalCompilation=false -Dmaven.test.skip=true -pl "PADL Creator C++ (Eclipse)" -am install
if errorlevel 1 exit /b 1
call "C:\Program Files\apache-maven-3.9.11\bin\mvn.cmd" -f "C:\Users\H P\Desktop\latestchange\CppParserPtidejDemo\PADL Creator C++ (Eclipse)\pom.xml" -Dmaven.plugin.validation=NONE -Dtest=padl.creator.cppfile.eclipse.test.TestCreatorCPPFileUsingEclipse surefire:test
exit /b %errorlevel%
