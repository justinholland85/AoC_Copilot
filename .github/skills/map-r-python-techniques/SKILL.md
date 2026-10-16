---
name: map-r-python-techniques
description: Analyse all locally available paired Advent of Code R and Python solutions to build and maintain a cumulative reference mapping R techniques to Python, NumPy and pandas alternatives.
---

# Map R–Python Techniques

## Objective

Build and maintain a cumulative, practical reference for implementing programming techniques in Python based on my own Advent of Code solutions.

My R solutions reflect my established programming style. My Python solutions are translations of those solutions, developed with AI assistance as I learn Python.

The goal is to understand how techniques I already use in R can be implemented in Python, including alternative approaches using NumPy and pandas.

Focus on conceptual and methodological equivalence, not merely syntax translation. Explain the underlying ideas, important behavioural differences, and practical trade-offs.

## Scope and constraints

### Source material

Use **local project files only**.

- Do not access GitHub or retrieve material from the remote repository.
- Do not use GitHub MCP or other tools to retrieve remote files.
- Do not retrieve puzzle descriptions, inputs, or solutions from the internet.
- Do not assume access to any material that is not present locally.
- Do not modify the original R or Python solution files.

The paired solution files are the authoritative source for identifying the techniques used in my implementations.

You may draw on your knowledge of R, Python, NumPy and pandas to explain the techniques and provide alternatives. Clearly distinguish techniques demonstrated in my code from additional illustrative alternatives.

### File naming convention

Solution files follow this naming convention:

- `AoC_<Year>_<Day>_Code_R`
- `AoC_<Year>_<Day>_Code_Py`

The actual filenames include their respective file extensions.

Use this convention to identify matching R and Python solutions. Do not impose alternative naming conventions or assume that other files are part of the analysis.

### Coverage

Analyse **every available R/Python pair** in the local project for which both files exist.

Do not restrict the analysis to a single year or day unless explicitly instructed to do so.

If one member of a pair is missing, exclude that incomplete pair from the technique analysis and report it separately. Do not invent or reconstruct missing solution code.

## Procedure

### 1. Discover the available solutions

Scan the local project for files matching the naming convention.

- Identify the year and day associated with each file.
- Match the R and Python files for the same year and day.
- Identify complete pairs and incomplete pairs.
- Record the actual filenames of all discovered files.

Use the project's existing instructions to determine its root directory. Do not search remote repositories.

### 2. Analyse the R solutions

For every complete pair, examine the R solution to identify its important techniques, idioms and programming patterns.

Consider, where relevant:

- Input parsing and string manipulation.
- Vectorised operations and indexing.
- Tables, arrays, matrices and data frames.
- Counting, grouping and frequency calculations.
- Matching, lookup operations and joins.
- Sorting, searching, filtering and deduplication.
- Set operations and membership tests.
- Logical conditions and missing values.
- Iteration, recursion and state updates.
- Numerical calculations and transformations.
- Algorithms, data structures and computational complexity.

This list is illustrative, not exhaustive. Record techniques that are genuinely useful for future programming rather than cataloguing every trivial expression.

For each technique, distinguish between:
- The underlying problem or algorithm.
- The R operation or idiom used to implement it.
- Any assumptions or language-specific behaviour that matter for correctness.

### 3. Analyse the Python translations

For each corresponding Python solution, identify how the same problem and techniques are implemented.

Recognise the use of:
- Standard Python syntax, built-in functions and data structures.
- NumPy arrays and vectorised operations.
- pandas Series and DataFrames.
- Other libraries where they are actually used.

Determine whether the Python implementation preserves the original R approach, changes the method, or uses a substantially different algorithm.

Do not assume that the existing Python translation is necessarily the best or only way to implement the technique.

### 4. Build reusable technique mappings

For each useful, reusable technique, document the following where applicable.

1. **Purpose** — the problem being solved.
2. **R approach** — the relevant operation or idiom, with a reference to the solution where it appears.
3. **Python with NumPy** — an equivalent implementation where appropriate.
4. **Python with pandas** — an equivalent implementation where appropriate.
5. **Standard Python alternative** — include when a built-in function, data structure or standard-library tool provides a useful alternative.
6. **Important differences** — explain relevant differences in indexing, types, missing values, ordering, dimensions, broadcasting, mutation or other behaviour.
7. **Practical guidance** — explain when each approach is useful and any meaningful trade-offs.

Use small, runnable code examples where they aid understanding.

Prefer examples taken from my actual solutions. Clearly label simplified examples and additional alternatives.

Do not force every technique into NumPy, pandas and standard Python implementations. Include alternatives when they are useful, and explain when an alternative is unnatural or unnecessary.

Where two approaches appear superficially equivalent but can produce different results, explain the distinction explicitly.

### 5. Identify recurring patterns across solutions

Compare techniques across all complete pairs, including solutions from different years.

- Consolidate repeated techniques into a single reusable entry.
- Record multiple implementations when they provide genuinely useful alternatives.
- Identify patterns that recur across several puzzles.
- Distinguish a new algorithmic idea from a different syntax for an existing idea.
- Identify cases where the Python translation changes the original method.
- Preserve references to the year and day for each relevant example.

Do not create a separate entry for every occurrence of the same technique. The purpose is to build a coherent reference, not a chronological catalogue of solutions.

### 6. Maintain the cumulative cheat sheet

Create or update the following document in the project root:

`AoC_R_Python_Techniques.md`

Organise the document primarily by technique or task, rather than by puzzle chronology.

Suggested categories include:

- Input parsing and strings
- Vectors, arrays and indexing
- Counting and frequency tables
- Matching, lookup and joins
- Sorting, filtering and unique values
- Sets and membership
- Matrices and multidimensional data
- Iteration and state
- Algorithms and problem-solving patterns

Adapt these categories as the collection grows.

For each technique, include the relevant R pattern, Python alternatives, important behavioural differences, practical guidance and references to the solutions that demonstrate it.

Maintain a consistent structure, avoid unnecessary repetition, and use cross-references where appropriate.

When updating the document:

- Read and preserve existing useful content.
- Integrate new findings into the existing structure.
- Update entries when new solutions provide useful refinements or alternatives.
- Consolidate duplicates rather than accumulating redundant explanations.
- Keep the document focused on practical learning for an R programmer developing Python skills.

### 7. Maintain the source-file inventory

At the bottom of the cheat sheet, maintain a section titled **Source files analysed**.

Include a table listing every complete R/Python pair included in the current analysis, with:

- Year.
- Day.
- Exact R filename.
- Exact Python filename.

Use the actual filenames, including extensions.

The inventory must reflect the files actually analysed in the current run. Rebuild or reconcile it against the current local files rather than blindly appending entries. Do not list a file as analysed merely because it exists.

If incomplete pairs are found, include a separate **Incomplete solution pairs** subsection that identifies the available file and the missing counterpart.

Do not silently remove historical technique explanations merely because a source file is no longer present. The inventory records current coverage; existing useful documentation should be preserved unless it is demonstrably incorrect or the user requests its removal.

### 8. Quality checks

Before finishing:

- Verify that the technique mappings accurately reflect the source code.
- Check that code examples use valid syntax and the appropriate library APIs.
- Distinguish demonstrated implementations from additional alternatives.
- Verify important claims about language and library behaviour where feasible.
- Highlight semantic differences that could silently change results.
- Ensure solution files have not been modified.
- Ensure the source inventory matches the complete pairs actually analysed.
- Preserve existing useful cheat-sheet content.

## Final report

After updating the cheat sheet, report:

- The number of complete R/Python pairs analysed.
- The year/day range covered.
- Any incomplete pairs and why they were excluded.
- The main techniques added, refined or consolidated.
- The location of the updated cheat sheet.
- Any unresolved issues or limitations.

Do not claim that a file was analysed or updated unless the operation was actually completed.
