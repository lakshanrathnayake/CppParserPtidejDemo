@echo off
set "JAVA_HOME=C:\Progra~1\Java\jdk-25"
set "PATH=%JAVA_HOME%\bin;C:\apache-maven-3.9.8\bin;%PATH%"
cd /d "C:\Users\H P\Desktop\latestchange\CppParserPtidejDemo"
mvn -f "PADL JNI Tests\pom.xml" -Dtest=padl.creator.cppfile.eclipse.test.big.JNINativeMethod -Dsurefire.failIfNoSpecifiedTests=false test
