---
name: code-my-way-r
description: Solve an Advent of Code problem in Justin's established R coding style, using his personal R style guide and library reference.
---

# Code My Way — R

## Purpose

Develop a complete Advent of Code solution in R that follows Justin's established coding style and makes appropriate use of his personal R function library.

The objective is not to impose generic R best practices or redesign the solution unnecessarily. The objective is to produce code that Justin can readily understand, run, compare with his own solutions, and maintain.

## 1. Read the reference documents

Before writing code, read the following documents from the Advent of Code project root:

- `Justin_R_Style_Guide.md`
- `Justin_R_Library_Reference.md`

These documents are the primary references for coding style and personal-library usage.

Apply the style guide's observed conventions, including naming, formatting, assignment, data structures, control flow, comments, and other patterns actually identified in Justin's existing code.

Use the library reference to identify suitable `Lib.` functions and understand their actual behaviour.

If either document is missing, report this and proceed cautiously using the available reference. Do not silently invent its contents or claim to have followed guidance that was unavailable.

## 2. Inspect the problem and available files

Read the relevant problem instructions and inspect the example input, expected example output, and actual input.

Use the locally available files first. Follow the project's existing instructions for obtaining missing problem files from the read-only Advent of Code source repository, if necessary.

Do not inspect or reuse existing solution files as a substitute for solving the problem independently.

Identify:
- What the problem asks for in Parts 1 and 2.
- The input format and relevant constraints.
- What the examples demonstrate.
- Any important differences between the two parts.
- Whether input size or other constraints warrant particular algorithmic or performance considerations.

## 3. Develop the solution

Work through the problem systematically:

1. Understand the problem and identify a suitable algorithm.
2. Develop the solution against the example input.
3. Check the result against the expected example output.
4. Apply the solution to the actual input.
5. Check the results for plausibility and consistency with the problem.

Do not merely hard-code example answers or assume a solution works because it runs without an error.

Where the problem permits multiple approaches, prefer an approach that is clear, consistent with Justin's established style, and reasonably efficient for the actual input size. Do not introduce unnecessary complexity or optimisation.

## 4. Follow Justin's R coding style

Use `Justin_R_Style_Guide.md` as the authority for style decisions.

In particular:

- Follow the naming conventions and formatting patterns supported by the guide.
- Preserve the distinctions between naming conventions where the guide identifies contextual differences.
- Prefer familiar, straightforward base R approaches when consistent with the observed code.
- Use the same general coding patterns as Justin's existing AoC solutions where appropriate.
- Avoid imposing tidyverse, functional-programming, object-oriented, or other conventions merely because they are common elsewhere.
- Keep comments useful and consistent with Justin's observed practice.
- Avoid unnecessary abstractions, helper functions, or elaborate architecture.

Where the style guide does not resolve a choice, use the closest relevant examples in Justin's existing AoC code. If the evidence remains inconclusive, make a conservative choice and record it as a judgement call in the final report.

Do not change the style guide or library reference as part of solving an individual problem.

## 5. Use Justin's personal R library appropriately

Use `Justin_R_Library_Reference.md` to decide which `Lib.` functions are appropriate.

Distinguish between:

1. **Established functions:** functions already used in Justin's AoC solutions, whose behaviour is documented in the reference.
2. **Related alternatives:** functions in his library that appear relevant but have not yet been observed in his AoC solutions.
3. **Unrelated or unfamiliar functions:** functions with no clear benefit for the problem.

Prefer established functions when they fit the task. Consider related alternatives when they provide a clear advantage and their behaviour is sufficiently understood. Do not introduce unrelated functions just to demonstrate that the library exists.

Before using a function, ensure that its documented arguments, return value, and edge-case behaviour are appropriate for the task. Do not infer its behaviour from its name alone.

If a relevant function is not adequately documented, inspect its definition using the configured GitHub MCP tools and the read-only `https://github.com/justinholland85/RLibrary` repository, following the project's instructions.

Do not modify the personal library or commit changes to it.

Avoid replacing a straightforward base R operation with a library function unless the function is appropriate and consistent with Justin's established practice.

Whether or not the library is used, it should be sourced using the fixed local path: source("C:/Users/justi/OneDrive/Documents/GitHub/RLibrary/Start.R")

## 6. Produce a single interactive R script

Create the solution in the appropriate local AoC project directory, following the existing directory structure and naming conventions.

The solution must be a single script named:

`AoC_<year>_<day>_Copilot_R_SG.R`

Follow the project's instructions for constructing paths and accessing input files. Use the established hard-coded project root where required.

The script must be designed to open and run interactively in Positron. Justin commonly executes individual lines or sections, so the code must not depend on being run as a complete command-line program.

In particular:

- Do not use `commandArgs()`, `sys.frames()`, `--file=`, or other mechanisms to discover the script's location.
- Do not require execution through `Rscript`.
- Do not introduce command-line argument handling unless explicitly requested.
- Make the input-loading approach consistent with the existing project.

Clearly separate the solutions for **Part 1** and **Part 2**, so each can be understood and run independently where practical.

Include the appropriate problem input and example-testing workflow in the script, consistent with Justin's existing conventions. Avoid unnecessary changes to unrelated files.

## 7. Validate and report

Before declaring the task complete, check that:

- The example result for Part 1 matches the expected output.
- The example result for Part 2 matches the expected output, where an example result is supplied.
- The actual input has been processed.
- The script follows the required filename, directory, and interactive-execution conventions.
- Library functions have been selected based on their documented behaviour.
- No original solution files or library files have been modified.

If a result cannot be verified, explain exactly what remains unverified. Never claim to have run or tested code when you have not.

## 8. Final report

After creating the script, provide a concise report containing:

### Solution
- The path and filename of the generated R script.
- The algorithm used for each part.
- The example and actual-input results, where available.

### Style decisions
- The principal conventions followed from `Justin_R_Style_Guide.md`.
- Any significant decisions where the guide did not provide a definitive answer.

### Library decisions
- Each `Lib.` function used and why it was appropriate.
- Whether each function was established in previous AoC code or was a related alternative.
- Any relevant alternatives considered but not selected, where this helps explain the approach.

### Validation and limitations
- What was tested and the results.
- Any assumptions, unresolved issues, or unverified behaviour.

Keep the report factual and concise. The purpose is to make the implementation and the agent's decisions transparent so Justin can compare the result with his own approach.

## Core principle

**Reproduce Justin's demonstrated coding style, rather than an imagined ideal version of it.**

Use the reference documents as evidence, solve the problem independently, select library functions deliberately, and make the resulting R script straightforward to run and inspect in Positron.

## Required script structure

Follow Justin's established AoC R script structure. The structure and order of the major sections are requirements, not suggestions.

### Avoid unnecessary defensive programming and test scaffolding

The purpose is to produce an Advent of Code solution in Justin's established R style, not to build production software or a reusable package.

- **Do not add input-validation checks, custom error messages, or defensive programming by default.** AoC puzzle inputs can generally be assumed to follow the stated specification.
- **Do not add `stopifnot()`, assertion blocks, or automated test scaffolding by default.** Justin's normal workflow is interactive: run the function on the example and real input, inspect the results, and investigate discrepancies when they arise.
- Do not create intermediate answer variables merely to label or test outputs when a direct function call is sufficient.
- Prefer the straightforward code patterns established in Justin's existing solutions and personal library.
- Add validation, error handling, or tests only when explicitly requested or when there is a concrete, task-specific reason they materially improve the solution. If such a reason exists, keep the addition proportionate and explain it briefly.
- Do not confuse code that could handle arbitrary malformed inputs with code that appropriately solves the stated puzzle.

The default should be **solve the problem simply, in Justin's style, and let the interactive workflow do its job**.

### 1. Header and setup

Begin with the established decorative header, including the AoC problem identifier.

Follow it with:

- The standard `source()` statement for the personal R library startup script.
- Definitions of `Root`, `Year` and `Day`.
- Construction of `Ref`, `Dir`, `Name.Data.0` and `Name.Data.1`.
- A clearly marked `Data` section.
- The working-directory setup and loading of `Data.0` and `Data.1`.

Follow the existing conventions for assignment alignment, spacing, naming and decorative separators.

### 2. Part 1 section

Create a dedicated, clearly marked `F.Part.1` section.

Within this section, in order:

1. Include the established section header.
2. Include the optional commented-out `Data <- Data.0` and `Data <- Data.1` lines used for interactive development, where appropriate.
3. Define `F.Part.1` and place the implementation inside that function.
4. Include a clearly marked `Execute` subsection.
5. Execute `F.Part.1(Data.0)` and `F.Part.1(Data.1)`.

Keep the implementation for Part 1 within this section. Define any additional helper functions in this section if they are specific to Part 1.

### 3. Part 2 section

After the complete Part 1 section, create a separate, clearly marked `F.Part.2` section.

Follow the same pattern:

1. Section header.
2. Optional commented-out data-selection lines for interactive development.
3. Definition of `F.Part.2`.
4. Clearly marked `Execute` subsection.
5. Execution against `Data.0` and `Data.1`.

Keep the implementation for Part 2 within this section. Define any additional helper functions here if they are specific to Part 2.

### 4. General rules

- Preserve the order: setup, complete Part 1 section, complete Part 2 section.
- Do not collect all function definitions at the top and move both parts' execution blocks to the bottom.
- Keep each part's implementation and execution together.
- Use the established decorative comment patterns to distinguish major sections and subsections.
- Preserve the interactive workflow: the user should be able to select and run a part's function and its execution lines independently.
- Use the actual example and input filenames and any additional data required by the problem, while retaining the overall structure.
- Adapt the implementation to the problem, but do not redesign the structure without a concrete reason.

The style guide remains the authority for details of naming, spacing and other conventions not explicitly specified here.