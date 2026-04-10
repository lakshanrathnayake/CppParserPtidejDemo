# C++ Parser Final Scope Report

Date: 2026-04-10

## Client requirement addressed

The requested scope was:

- keep changes limited to the 2-3 projects directly connected to the C++ parser
- revert unrelated `.classpath` changes
- keep PADL JNI reintegrated
- consider `PADL Generator PageRank` because it uses the C++ parser dependency path
- restore test resource paths to the relative `../...` form so Eclipse runs from `All Ptidej Tests` do not break

## What was verified and corrected

### 1. Relative test path was restored

The broken shortened path form such as:

`ring-daemon-master/src/`

was not kept.

The parser test now uses the project-relative form:

`../PADL Creator C++ (Eclipse)/target/test-classes/ring-daemon-master/src/`

File:

- `PADL Creator C++ (Eclipse)/src/test/java/padl/creator/cppfile/eclipse/test/big/RingDaemonTest.java`

This is the required form for runs launched from the Eclipse project `All Ptidej Tests`, because the working directory is different there.

### 2. Unrelated `.classpath` churn was removed

I restored the `.classpath` files that did not need to stay changed.

I also restored these files back to `HEAD` content because they only differed by formatting / line-ending churn:

- `PADL Creator C++ (Eclipse)/.classpath`
- `PADL JNI/.classpath`
- `PADL JNI Tests/.classpath`
- `PADL Generator PageRank/.classpath`

### 3. `PADL Generator PageRank` was checked

`PADL Generator PageRank/pom.xml` already contains the `padl-creator-cpp-eclipse` dependency in `HEAD`.

So there was no missing reintegration to add there. Any working-tree noise on that file was reverted.

### 4. PADL JNI status

The JNI-side files that were suspected earlier were checked against `HEAD`.

These files are currently unchanged relative to `HEAD`:

- `PADL JNI Tests/src/padl/creator/cppfile/eclipse/test/big/JNIGlobalFunction.java`
- `PADL JNI Tests/src/padl/creator/cppfile/eclipse/test/big/JNIMethodMissed.java`
- `PADL JNI Tests/src/padl/creator/cppfile/eclipse/test/big/JNIModel.java`
- `PADL JNI Tests/src/padl/creator/cppfile/eclipse/test/big/JNINativeMethod.java`
- `PADL JNI Tests/src/padl/creator/cppfile/eclipse/test/big/JNINativeMethodMissed.java`
- `PADL JNI/src/padl/creator/cppfile/eclipse/test/big/PadlModelJNI.java`

## Final remaining changed files in scope

After the cleanup pass, the remaining source-level modifications relevant to this requirement are:

- `PADL Creator C++ (Eclipse)/src/test/java/padl/creator/cppfile/eclipse/test/big/RingDaemonTest.java`
- `PADL Creator C++ (Eclipse)/src/test/java/padl/creator/cppfile/eclipse/test/TestCreatorCPPFileUsingEclipse.java`

This report file was also added:

- `test-outputs/CPP_PARSER_FINAL_SCOPE_REPORT.md`

## Why GitHub may show fewer files than expected

Much of this cleanup was revert work.

When a file is restored to its original content, it disappears from the final diff. That is why GitHub may show only one or two visible source changes even though several cleanup actions were performed locally.

## Why Eclipse may appear inconsistent

If Eclipse was launched on a different branch, stale workspace metadata, or a run configuration using the wrong working directory, the visible changed-file list and script behavior can differ from the cleaned branch state.

The specific error:

`tmp_run_padljni_rerun.cmd is not recognized`

is a launch-path / working-directory issue, not evidence that the parser path fix is missing.
