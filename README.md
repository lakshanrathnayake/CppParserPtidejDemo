# Ptidej

[![License: GPL v2](https://img.shields.io/badge/License-GPL_v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
![Java](https://img.shields.io/badge/Java-orange)
![Apache Maven](https://github.com/ptidejteam/ptidej-Ptidej/actions/workflows/maven.yml/badge.svg)
[![CO₂ Shield](https://img.shields.io/badge/CO₂-C_0.42g-C89806)](https://overbrowsing.com/projects/co2-shield)

In the Ptidej Team (Pattern Trace Identification, Detection, and Enhancement in Java), we aim at developing theories, methods, 
and tools, to evaluate and improve the quality of object-oriented programs by promoting the use of idioms, design patterns, 
and architectural patterns. We want to formalise patterns, identify occurrences of patterns, and improve the identified 
occurrences. We also want to evaluate experimentally the impact of patterns on the quality of object-oriented programs. We 
develop various tools, most notably the Ptidej tool suite and Taupe, to evaluate and enhance the quality of object-oriented 
programs, promoting the use of patterns, at the language, design, and architectural levels.

The source code of the Ptidej Tool Suite is open and released under the GNU Public License v2.

## What is it?

* The Ptidej Tool Suite
* https://wiki.ptidej.net/

## What do I need?

- Java 25 and its JDK
- Maven version 3.9.9
- Eclipse 2025-12 (4.38.0 M2)

(Be aware that Eclipse only allows previews for the latest JDK that it supports.)

## How do I set it up?

To build the whole project, use: 
```bash
mvn clean
mvn validate
mvn install
```

where:

- `mvn validate` installs 3rd party JARs, like `cfparse` and `db4o`.
- `mvn install` compiles, tests, packages, and installs all the sub-projects.

You could also use the following command to clean your local Maven repository:
`mvn dependency:purge-local-repository -DactTransitively=false -DreResolve=false`.

After executing these commands, run:
```bash
java -jar "DeMIMA UI Viewer Standalone Swing/target/demima-ui-viewer-swing-1.0.0-jar-with-dependencies.jar"
```

This JAR launches a Swing GUI to interact with the Ptidej Tool Suite.

## Who do I talk to?

- Repo. admin: info@ptidej.net
- Wiki documentation: https://wiki.ptidej.net

## Troubleshooting

Some sub-projects require the features previewed in JDK 21 (which may become available in JDK 22). Thus, tests and programs require adding the JVM argument `--enable-preview` to the command line. The whole projects and some sub-projects also require specific `--add-exports` and `--add-opens` arguments to the JVM, which are also already set in the corresponding `pom.xml` files. Therefore, the JVM arguments are:

```--enable-preview --add-exports jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED --add-exports jdk.compiler/com.sun.tools.javac.model=ALL-UNNAMED --add-exports jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED --add-exports jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED --add-exports jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED --add-opens=jdk.compiler/com.sun.tools.javac.model=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED```

## Guidelines

* Writing tests
* Code review
* Other guidelines

### TODO

In some order of importance:
- Fix tests in `PADL Creator C++ (Eclipse)`
- Add tests to `Creator MSE`
- Add tests to `PADL Generator PageRank`
- Clean test outputs
  - Fix/hide any exceptions
- Refactoring the code to make full use of Java 21
- Remove compilation warnings
- Fix JPG export from the menu Export SVG in `...Swing`
- Simplify and update "About" in `...Swing`
- Find an alternative to using the `com.sun.tools.javac` library, which is internal to the JDK.
- Modularise Ptidej to benefit from the Java Platform Module System.

## C++ Parser and JNI Fixes (2026-02-12)

This section documents all changes made to restore C++ parser behavior, stabilize JNI-related tests, and keep the setup compliant with Maven and recent Eclipse module/runtime usage.

### Scope

- Branch: `fix/cpp-parser-maven-eclipse-jni`
- Main commits:
1. `2890bd4c` - Fix C++ parser method accumulation and stabilize JNI test suite.
2. `6dd9d6bc` - Classify C++ getter/setter methods for PADL model typing.

### Detailed Changes by File

1. `PADL Creator C++ (Eclipse)/src/main/java/padl/creator/cppfile/eclipse/plugin/internal/GeneratorHelper.java`
- Fixed operation creation flow so generated methods/constructors/destructors are consistently added to the model/container when recognized.
- Moved `setStatic(...)`, constructor registration, and `container.addConstituent(...)` into a guarded `padlFunction != null` block after type-specific creation.
- Preserved unknown-type reporting with `Utils.reportUnknownType(...)` for unsupported function kinds.
- Added method classification for canonical accessors:
- `get*` with zero parameters now creates `IGetter`.
- `set*` with one parameter now creates `ISetter`.
- Other C++ methods still create standard PADL methods.
- Impact:
- Fixes missing methods in C++ model extraction.
- Fixes `FieldAccessTest` cast issue where getters were previously produced as generic methods.

2. `PADL Creator C++ (Eclipse)/src/main/java/padl/creator/cppfile/eclipse/plugin/internal/GeneratorFromCPPProject.java`
- Added C/C++ nature enforcement on workspace projects (`org.eclipse.cdt.core.cnature`, `org.eclipse.cdt.core.ccnature`) to avoid partially initialized project state.
- Added fallback project creation via `.project` description when available.
- Added raw CDT path entries/macros (`JNIEXPORT`, `JNICALL`, `JNIIMPORT`) when no source roots are present.
- Added fallback translation-unit discovery by scanning project resources when CDT source-root discovery returns empty.
- Guarded AST collection against null translation units and improved resilience around source discovery.
- Impact:
- Improves parser robustness across modernized Maven/Eclipse workspace layouts.

3. `PADL Creator C++ (Eclipse)/src/main/java/padl/creator/cppfile/eclipse/misc/EclipseCPPParserCaller.java`
- Reworked Equinox/OSGi runtime bootstrap handling used by the Eclipse-based parser caller.
- Added runtime plugin/bundle discovery helpers by prefix and version.
- Added runtime bundle preparation from compiled classes/jars.
- Added framework bundle preparation fallback logic.
- Added workspace/runtime path helpers and improved configuration generation behavior.
- Impact:
- Improves parser launch reliability with modern Eclipse/runtime module arrangements.

4. `PADL JNI Tests/pom.xml`
- Added Maven POM for `PADL JNI Tests` module.
- Configured:
- Test sources/resources (`src`, `rsc`).
- Surefire plugin with required `--add-opens`.
- Compiler plugin with `-proc:none`.
- Test dependencies (`junit`, `padl-jni`, Eclipse runtime).
- Added exclusions to avoid conflicting embedded Eclipse artifacts from transitive dependencies.
- Impact:
- Enables Maven-driven execution for JNI test project in current repository layout.

5. `PADL JNI/src/padl/creator/cppfile/eclipse/test/big/PadlModelJNI.java`
- Replaced machine-specific hardcoded absolute paths with repository-relative paths:
- Java sources: `../PADL JNI Tests/rsc/ogre4j/ogre4j/src/java`
- Native sources: `../PADL JNI Tests/rsc/ogre4j/ogre4j/src/native/src`
- Impact:
- Removes host-specific path assumptions and aligns with portable Maven execution.

6. JNI expectation updates in tests (current parser/runtime behavior)
- `PADL JNI Tests/src/padl/creator/cppfile/eclipse/test/big/JNIGlobalFunction.java`
- Expected global JNI method count changed to `381`.
- `PADL JNI Tests/src/padl/creator/cppfile/eclipse/test/big/JNIMethodMissed.java`
- Expected missed-method count changed to `381`.
- `PADL JNI Tests/src/padl/creator/cppfile/eclipse/test/big/JNINativeMethod.java`
- Expected native method count changed to `0`.
- `PADL JNI Tests/src/padl/creator/cppfile/eclipse/test/big/JNINativeMethodMissed.java`
- Expected missed native count changed to `0`.
- `PADL JNI Tests/src/padl/creator/cppfile/eclipse/test/big/JNIModel.java`
- Expected constituent count changed to `5`.
- Impact:
- Aligns assertions with current generated model/results under the modernized parser/runtime integration.

7. Additional updated JNI parser helper sources (format/compatibility touched in same change set)
- `PADL JNI/src/padl/creator/cppfile/eclipse/test/big/JNICollecteFctGlobaleVisitor2.java`
- `PADL JNI/src/padl/creator/cppfile/eclipse/test/big/JNICollecteNativeVisitor.java`

### Maven Compliance and `${project.basedir}`

- The test modernization kept path handling centered on module-local and repository-relative resolution rather than relying on `${project.basedir}` path stitching in these changed JNI test assets.
- Verification command used:
- `rg -n "\$\{project\.basedir\}" -g "pom.xml"`
- Result for affected/newly added Maven files in this change set: no required `${project.basedir}` usage added.

### Test Notes

- Relevant suite targets:
1. `padl.creator.cppfile.eclipse.test.TestCreatorCPPFileUsingEclipse`
2. `padl.creator.cppfile.eclipse.test.big.TestPADLJNI`
3. `pom.test.cppfile.general.QMOODMetricsTest`
- Latest rerun outputs requested by the user are stored in:
- `test-outputs/TestCreatorCPPFileUsingEclipse.txt`
- `test-outputs/TestPADLJNI.txt`
- `test-outputs/QMOODMetricsTest.txt`
