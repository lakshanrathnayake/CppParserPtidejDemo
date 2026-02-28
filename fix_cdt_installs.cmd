@echo off
set "JAVA_HOME=C:\Program Files\Java\jdk-25"
set "PATH=%JAVA_HOME%\bin;%PATH%"
cd /d "C:\Users\H P\Desktop\latestchange\CppParserPtidejDemo"

mvn install:install-file "-Dfile=PADL Creator C++ (Eclipse)\libs\org.eclipse.cdt.core_5.4.jar" "-DgroupId=padl-creator-cpp-eclipse-org-eclipse-cdt" "-DartifactId=core" "-Dversion=5.4" "-Dpackaging=jar" "-DgeneratePom=false"

mvn install:install-file "-Dfile=PADL Creator C++ (Eclipse)\libs\org.eclipse.cdt.core.win32_5.3.jar" "-DgroupId=padl-creator-cpp-eclipse-org-eclipse-cdt-core" "-DartifactId=win32" "-Dversion=5.3" "-Dpackaging=jar" "-DgeneratePom=false"

mvn install:install-file "-Dfile=PADL Creator C++ (Eclipse)\libs\org.eclipse.cdt.make.core_7.2.jar" "-DgroupId=padl-creator-cpp-eclipse-org-eclipse-cdt-make" "-DartifactId=core" "-Dversion=7.2" "-Dpackaging=jar" "-DgeneratePom=false"

mvn install:install-file "-Dfile=PADL Creator C++ (Eclipse)\libs\org.eclipse.cdt.managedbuilder.core_8.1.jar" "-DgroupId=padl-creator-cpp-eclipse-org-eclipse-cdt-managedbuilder" "-DartifactId=core" "-Dversion=8.1" "-Dpackaging=jar" "-DgeneratePom=false"

mvn install:install-file "-Dfile=PADL Creator C++ (Eclipse)\libs\org.eclipse.cdt.managedbuilder.gnu.ui_8.1.jar" "-DgroupId=padl-creator-cpp-eclipse-org-eclipse-cdt-managedbuilder-gnu" "-DartifactId=ui" "-Dversion=8.1" "-Dpackaging=jar" "-DgeneratePom=false"

echo ALL_DONE
