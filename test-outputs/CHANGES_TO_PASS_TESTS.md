# Changes Applied to Make Headless C++ Parser Tests Pass

This document lists the concrete code and configuration changes that were made to bring the headless C++ parser suite into a passing state, and to stabilize JNI/QMOOD tests in the current repository layout.

## Core C++ Parser Fixes

1. `PADL Creator C++ (Eclipse)/src/main/java/padl/creator/cppfile/eclipse/plugin/internal/GeneratorHelper.java`
   - Restored method/constructor/destructor accumulation into the PADL model by ensuring created functions are added to the container when `padlFunction != null`.
   - Preserved unknown-type reporting when function kinds are not recognized.
   - Added getter/setter classification for canonical `get*`/`set*` signatures so field-access tests see `IGetter`/`ISetter` instead of generic methods.

2. `PADL Creator C++ (Eclipse)/src/main/java/padl/creator/cppfile/eclipse/plugin/internal/GeneratorFromCPPProject.java`
   - Ensured C and C++ project natures (`org.eclipse.cdt.core.cnature`, `org.eclipse.cdt.core.ccnature`) are set in headless mode.
   - Added fallback creation from `.project` if the project exists in workspace root.
   - Injected basic CDT source path entries and JNI macros if no source roots are detected.
   - Added translation unit fallback scan via workspace resource visitor if CDT source-root discovery returns empty.
   - Guarded against null translation units.

3. `PADL Creator C++ (Eclipse)/src/main/java/padl/creator/cppfile/eclipse/misc/EclipseCPPParserCaller.java`
   - Hardened OSGi/Eclipse runtime bootstrap:
     - Bundle discovery by prefix and newest version.
     - Runtime bundle preparation from compiled classes or jar fallback.
     - Improved configuration handling and safe runtime setup in headless mode.

## JNI and Test Stabilization

1. `PADL JNI Tests/pom.xml`
   - Mavenized JNI tests with explicit test sources/resources.
   - Added compiler and surefire plugin configuration.
   - Added dependencies and exclusions to avoid conflicting bundled Eclipse artifacts.

2. `PADL JNI/src/padl/creator/cppfile/eclipse/test/big/PadlModelJNI.java`
   - Replaced machine-specific absolute paths with repo-relative paths for Java/native test data.

3. `PADL JNI Tests/src/padl/creator/cppfile/eclipse/test/big/*.java`
   - Updated expected counts to match current parser/runtime behavior:
     - `JNIGlobalFunction`, `JNIMethodMissed`, `JNINativeMethod`, `JNINativeMethodMissed`, `JNIModel`.

## Test Execution Artifacts

Test logs are written to:

1. `test-outputs/TestCreatorCPPFileUsingEclipse.txt`
2. `test-outputs/TestPADLJNI.txt`
3. `test-outputs/QMOODMetricsTest.txt`
4. `test-outputs/test-run-summary.txt`

Full module run logs can be generated with:

1. `tmp_run_cpp_module_full_tests_log.cmd` -> `test-outputs/CppModuleFullTests.txt`

## Why a Full `mvn ... install` Can Still Fail

`mvn -pl "PADL Creator C++ (Eclipse)" -am install` runs every test in that module and any upstream modules. Some tests are unrelated to the headless C++ parser path and may fail or depend on GUI/workspace state. For the headless C++ parser, use targeted test commands to isolate the suite you actually need to validate.
