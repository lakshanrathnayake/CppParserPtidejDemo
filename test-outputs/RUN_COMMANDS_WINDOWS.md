# Windows Run Commands (Maven 3.9.11 Compatible)

These commands assume:
- You run from repo root (`CppParserPtidejDemo`)
- `mvn` is available in `PATH` (3.9.11 is fine)
- Java is installed (JDK 22/25)

## 1) Required Suites (targeted)

1. `TestCreatorCPPFileUsingEclipse`
```bat
cmd.exe /c tmp_run_cpp_suite_reactor_win.cmd
```

2. `TestPADLJNI`
```bat
cmd.exe /c tmp_run_padljni_rerun.cmd
```

3. `QMOODMetricsTest`
```bat
cmd.exe /c tmp_run_qmood_rerun.cmd
```

## 2) Same Runs with Log Files

1. Headless C++ suite log:
```bat
cmd.exe /c tmp_run_cpp_suite_reactor_win.cmd > test-outputs\TestCreatorCPPFileUsingEclipse.txt 2>&1
```

2. PADL JNI suite log:
```bat
cmd.exe /c tmp_run_padljni_rerun.cmd > test-outputs\TestPADLJNI.txt 2>&1
```

3. QMOOD suite log:
```bat
cmd.exe /c tmp_run_qmood_rerun.cmd > test-outputs\QMOODMetricsTest.txt 2>&1
```

## 3) Full C++ Module Tests

```bat
cmd.exe /c tmp_run_cpp_module_full_tests.cmd
```

This script now enforces:
- JDK 25
- `clean test`
- single Surefire fork (`-DforkCount=1 -DreuseForks=false`)
- one automatic rerun of flaky failures (`-Dsurefire.rerunFailingTestsCount=1`)

With log file:
```bat
cmd.exe /c tmp_run_cpp_module_full_tests_log.cmd
```

Log output:
- `test-outputs\CppModuleFullTests.txt`

## 4) Full Project Build (All Modules)

```bat
mvn -f "pom.xml" install
```

Note: this runs every module test and can fail for unrelated suites outside the C++ headless path.

## 5) Build and Launch DeMIMA Swing UI

```bat
run_demima_ui.cmd
```

What it does:
- Builds `DeMIMA UI Viewer Standalone Swing` with dependencies (`package`, tests skipped)
- Launches:
`DeMIMA UI Viewer Standalone Swing\\target\\demima-ui-viewer-swing-1.0.0-jar-with-dependencies.jar`

## 6) Quick Diagnostics if a Command Fails

1. Check Maven is found:
```bat
where mvn
mvn -v
```

2. Check Java:
```bat
where java
java -version
```

3. Check failed tests report folder:
- `PADL Creator C++ (Eclipse)\target\surefire-reports`
- `PADL JNI Tests\target\surefire-reports`
- `POM\target\surefire-reports`
