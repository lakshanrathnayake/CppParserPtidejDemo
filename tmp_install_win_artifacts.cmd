@echo off
set "JAVA_HOME=C:\Progra~1\Java\jdk-25"
set "PATH=%JAVA_HOME%\bin;%PATH%"
cd /d H:\PROJECTS\Fiverr\CppParserPtidejDemo
set MVN=C:\apache-maven-3.9.8\bin\mvn.cmd

call %MVN% -N install:install-file -Dfile="H:\PROJECTS\Fiverr\CppParserPtidejDemo\CPL\src\main\resources\cfparse.jar" -DgroupId=com.ibm.toad -DartifactId=cfparse -Dversion=1.0 -Dpackaging=jar
if errorlevel 1 exit /b 1

call %MVN% -N install:install-file -Dfile="H:\PROJECTS\Fiverr\CppParserPtidejDemo\PADL Creator C++ (Eclipse)\libs\org.eclipse.osgi_3.15.jar" -DgroupId=padl-creator-cpp-eclipse-org-eclipse -DartifactId=osgi -Dversion=3.15 -Dpackaging=jar
if errorlevel 1 exit /b 1
call %MVN% -N install:install-file -Dfile="H:\PROJECTS\Fiverr\CppParserPtidejDemo\PADL Creator C++ (Eclipse)\libs\org.eclipse.osgi.services_3.8.jar" -DgroupId=padl-creator-cpp-eclipse-org-eclipse-osgi -DartifactId=services -Dversion=3.8 -Dpackaging=jar
if errorlevel 1 exit /b 1
call %MVN% -N install:install-file -Dfile="H:\PROJECTS\Fiverr\CppParserPtidejDemo\PADL Creator C++ (Eclipse)\libs\org.eclipse.cdt.core_5.4.jar" -DgroupId=padl-creator-cpp-eclipse-org-eclipse-cdt -DartifactId=core -Dversion=5.4 -Dpackaging=jar
if errorlevel 1 exit /b 1
call %MVN% -N install:install-file -Dfile="H:\PROJECTS\Fiverr\CppParserPtidejDemo\PADL Creator C++ (Eclipse)\libs\org.eclipse.cdt.core.win32_5.3.jar" -DgroupId=padl-creator-cpp-eclipse-org-eclipse-cdt-core -DartifactId=win32 -Dversion=5.3 -Dpackaging=jar
if errorlevel 1 exit /b 1
call %MVN% -N install:install-file -Dfile="H:\PROJECTS\Fiverr\CppParserPtidejDemo\PADL Creator C++ (Eclipse)\libs\org.eclipse.cdt.make.core_7.2.jar" -DgroupId=padl-creator-cpp-eclipse-org-eclipse-cdt-make -DartifactId=core -Dversion=7.2 -Dpackaging=jar
if errorlevel 1 exit /b 1
call %MVN% -N install:install-file -Dfile="H:\PROJECTS\Fiverr\CppParserPtidejDemo\PADL Creator C++ (Eclipse)\libs\org.eclipse.cdt.managedbuilder.core_8.1.jar" -DgroupId=padl-creator-cpp-eclipse-org-eclipse-cdt-managedbuilder -DartifactId=core -Dversion=8.1 -Dpackaging=jar
if errorlevel 1 exit /b 1
call %MVN% -N install:install-file -Dfile="H:\PROJECTS\Fiverr\CppParserPtidejDemo\PADL Creator C++ (Eclipse)\libs\org.eclipse.cdt.managedbuilder.gnu.ui_8.1.jar" -DgroupId=padl-creator-cpp-eclipse-org-eclipse-cdt-managedbuilder-gnu -DartifactId=ui -Dversion=8.1 -Dpackaging=jar
if errorlevel 1 exit /b 1
call %MVN% -N install:install-file -Dfile="H:\PROJECTS\Fiverr\CppParserPtidejDemo\PADL Creator C++ (Eclipse)\libs\org.eclipse.core.jobs_3.5.200.v20120511-1333.jar" -DgroupId=padl-creator-cpp-eclipse-org-eclipse-core -DartifactId=jobs -Dversion=3.5.200.v20120511-1333 -Dpackaging=jar
if errorlevel 1 exit /b 1
call %MVN% -N install:install-file -Dfile="H:\PROJECTS\Fiverr\CppParserPtidejDemo\PADL Creator C++ (Eclipse)\libs\org.eclipse.core.resources_3.8.jar" -DgroupId=padl-creator-cpp-eclipse-org-eclipse-core -DartifactId=resources -Dversion=3.8 -Dpackaging=jar
if errorlevel 1 exit /b 1
call %MVN% -N install:install-file -Dfile="H:\PROJECTS\Fiverr\CppParserPtidejDemo\PADL Creator C++ (Eclipse)\libs\org.eclipse.core.runtime_3.8.jar" -DgroupId=padl-creator-cpp-eclipse-org-eclipse-core -DartifactId=runtime -Dversion=3.8 -Dpackaging=jar
if errorlevel 1 exit /b 1
call %MVN% -N install:install-file -Dfile="H:\PROJECTS\Fiverr\CppParserPtidejDemo\PADL Creator C++ (Eclipse)\libs\org.eclipse.equinox.app_1.3.jar" -DgroupId=padl-creator-cpp-eclipse-org-eclipse-equinox -DartifactId=app -Dversion=1.3 -Dpackaging=jar
if errorlevel 1 exit /b 1
call %MVN% -N install:install-file -Dfile="H:\PROJECTS\Fiverr\CppParserPtidejDemo\PADL Creator C++ (Eclipse)\libs\org.eclipse.equinox.common_3.6.jar" -DgroupId=padl-creator-cpp-eclipse-org-eclipse-equinox -DartifactId=common -Dversion=3.6 -Dpackaging=jar
if errorlevel 1 exit /b 1
call %MVN% -N install:install-file -Dfile="H:\PROJECTS\Fiverr\CppParserPtidejDemo\PADL Creator C++ (Eclipse)\libs\org.eclipse.equinox.simpleconfigurator_1.3.jar" -DgroupId=padl-creator-cpp-eclipse-org-eclipse-equinox -DartifactId=simpleconfigurator -Dversion=1.3 -Dpackaging=jar
if errorlevel 1 exit /b 1

echo INSTALLED_WIN_ARTIFACTS_OK
exit /b 0
