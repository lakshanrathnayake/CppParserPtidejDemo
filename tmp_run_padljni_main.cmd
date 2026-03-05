@echo off
setlocal
set JAVA_HOME=C:\Program Files\Java\jdk-25
set PATH=%JAVA_HOME%\bin;C:\apache-maven-3.9.8\bin;%PATH%
cd /d H:\PROJECTS\Fiverr\CppParserPtidejDemo
mvn -f "PADL JNI Tests\pom.xml" -DskipTests org.codehaus.mojo:exec-maven-plugin:3.5.0:java -Dexec.mainClass=padl.creator.cppfile.eclipse.test.big.PadlModelJNI -Dexec.classpathScope=test
endlocal
