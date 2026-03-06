# Ptidej Full Project Documentation (Repo Overview + Fix Summary)

## 1) Purpose
This document provides a high-level overview of the whole Ptidej monorepo, how to build and test it, and what specific fixes were made in this engagement to restore the headless C++ parser workflow and its related tests.

This complements the focused documents:
- `test-outputs/CPP_ECLIPSE_HEADLESS_REPORT.md`
- `test-outputs/CHANGES_TO_PASS_TESTS.md`

---

## 2) Repository Structure (Top-Level Modules)

This is a multi-module monorepo containing the Ptidej tool suite and related components:

- Core analysis and utilities:
  - `PADL`, `PADL Statements`, `PADL Analyses`, `PADL Design Motifs`, `PADL Generator`, `PADL Generator PageRank`
- Language-specific creators/parsers:
  - `PADL Creator JavaFile (Eclipse)`, `PADL Creator JavaFile (JavaC)`, `PADL Creator C++ (Eclipse)`, `PADL Creator C++ (ANTLR)`, `PADL Creator C# v1`, `PADL Creator C# v2`, `PADL Creator AspectJ`, `PADL Creator ClassFile`, `PADL Creator XMI`, `PADL Creator MSE`, `PADL Creator AOL`
- UI tooling and viewers:
  - `DeMIMA UI`, `DeMIMA UI Viewer`, `DeMIMA UI Viewer Standalone Swing`, `DeMIMA UI Viewer Extensions`, `DeMIMA UI Layouts`
- Solvers and analyses:
  - `DeMIMA Solver 3`, `DeMIMA Solver 4`, `DeMIMA Solver Occurrence Generator`, `DeMIMA Solver Fingerprints`
- Instrumentation and metrics:
  - `MoDeC Bytecode Instrumentation`, `MoDeC Metamodel`, `MoDeC Solver`, `MoDeC Invoker`
- JNI and native integration:
  - `PADL JNI`, `PADL JNI Tests`
- Support modules:
  - `CPL`, `CLAP`, `EPI`, `SAD`, `SAD Rules Creator`, `SQUAD`, `JChoco`, `Caffeine`, `Caffeine Tests`, `Caffeine Analyses`
- Test aggregators:
  - `All Ptidej Tests`, `PADL Creator JavaFile-ClassFile Tests`, `MoDeC Bytecode Instrumentation Tests`, `DeMIMA Reporting Tests`
- Maven root:
  - `pom.xml` at repository root

---

## 3) Build Requirements (Windows-focused)

- Java JDK 25
- Maven 3.9.x
- Eclipse runtime dependencies for the C++ (Eclipse) parser

Environment setup examples (Windows `.cmd`):

```bat
set "JAVA_HOME=C:\Progra~1\Java\jdk-25"
set "PATH=%JAVA_HOME%\bin;C:\apache-maven-3.9.8\bin;%PATH%"
```

---

## 4) Recommended Build / Test Entry Points

### 4.1 Full project build (all modules)

```bat
mvn -f "pom.xml" install
```

Note: This executes *all* module tests and may fail on unrelated or environment-sensitive suites. It is not recommended when only validating the headless C++ parser.

### 4.2 Headless C++ parser test (recommended for delivery)

```bat
cmd.exe /c tmp_run_cpp_suite_reactor_win.cmd
```

### 4.3 JNI tests

```bat
cmd.exe /c tmp_run_padljni_rerun.cmd
```

### 4.4 QMOOD test

```bat
cmd.exe /c tmp_run_qmood_rerun.cmd
```

### 4.5 Full C++ module tests only

```bat
cmd.exe /c tmp_run_cpp_module_full_tests.cmd
```

To capture full module test output to a file:

```bat
cmd.exe /c tmp_run_cpp_module_full_tests_log.cmd
```

Output file:
- `test-outputs/CppModuleFullTests.txt`

---

## 5) What Was Fixed in This Engagement

This engagement focused on stabilizing the headless C++ parser and the JNI/QMOOD test suites. The detailed list of code changes is stored in:

- `test-outputs/CHANGES_TO_PASS_TESTS.md`

Summary of the functional fixes:

1. **C++ model construction correctness**
   - Restored operation accumulation for methods/constructors/destructors in `GeneratorHelper`.
   - Added getter/setter typing for canonical `get*`/`set*` methods.

2. **Headless CDT project setup reliability**
   - Enforced C/C++ natures, added source entry and JNI macro defaults, and used fallback translation-unit discovery.

3. **Headless Eclipse runtime bootstrap**
   - Improved runtime bundle lookup and fallback behavior for OSGi-based headless execution.

4. **JNI test portability and Mavenization**
   - Added `PADL JNI Tests/pom.xml`.
   - Replaced machine-specific absolute paths with repo-relative paths.
   - Updated expected test counts to match current parser/runtime behavior.

---

## 6) Verified Test Suites and Current Results

The following suites were rerun in this workspace on 2026-03-06:

1. `TestCreatorCPPFileUsingEclipse`
   - Results: `FAIL` (latest surefire XML shows `tests=14, failures=0, errors=2`)
   - Main issue: XStream `ConversionException` during model read in large C++ cases (e.g., `ChromeTest`).
   - Log: `test-outputs/TestCreatorCPPFileUsingEclipse.txt`
   - XML: `PADL Creator C++ (Eclipse)/target/surefire-reports/TEST-padl.creator.cppfile.eclipse.test.TestCreatorCPPFileUsingEclipse.xml`

2. `TestPADLJNI`
   - Results: `FAIL` (`Tests run: 5, Failures: 0, Errors: 5`)
   - Main issue: XStream `UnknownFieldException` on `padl.cpp.kernel.impl.GlobalFunctionGhost`.
   - Log: `test-outputs/TestPADLJNI.txt`

3. `QMOODMetricsTest`
   - Results: `Tests run: 1, Failures: 0, Errors: 0, Skipped: 0`
   - Log: `test-outputs/QMOODMetricsTest.txt`

Summary file:
- `test-outputs/test-run-summary.txt`

---

## 7) Why Full Module Builds Can Fail

`mvn -pl "PADL Creator C++ (Eclipse)" -am install` runs the **entire** module test set and upstream modules, not just the headless parser suite. This can surface unrelated test instability or environment-dependent failures.

If the full module run fails, inspect:
- `PADL Creator C++ (Eclipse)/target/surefire-reports/*.txt`

---

## 8) Test Output Storage

All tracked test logs and documentation in this engagement are stored under `test-outputs/`:

- `CPP_ECLIPSE_HEADLESS_REPORT.md`
- `CHANGES_TO_PASS_TESTS.md`
- `PROJECT_FULL_DOCUMENTATION.md` (this file)
- `TestCreatorCPPFileUsingEclipse.txt`
- `TestPADLJNI.txt`
- `QMOODMetricsTest.txt`
- `test-run-summary.txt`

---

## 9) Next Steps (Required for full green)

To make all three required suites pass consistently on this branch:
1. Fix binary/model compatibility between generated C++ model snapshots and current PADL C++ classes (`CPPParameter`/`GlobalFunctionGhost` related XStream deserialization path).
2. Regenerate or migrate stale serialized reference models used by C++/JNI tests.
3. Re-run the three suites and update `test-outputs/test-run-summary.txt`.
