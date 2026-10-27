---
name: map-r-python-techniques
description: Build and maintain a cumulative, example-driven reference mapping the R expressions and coding patterns I actually use to copyable Python, NumPy and pandas equivalents.
---

# Map R–Python Techniques

## Objective

Build and maintain a cumulative, practical reference that helps me translate my existing R programming knowledge into Python.

My R solutions reflect my established programming style. My Python solutions are translations of those solutions, developed with AI assistance as I learn Python.

**The primary goal is to help me recognise an R expression I already use and find Python code that I can copy, paste and adapt.**

The reference must therefore be example-driven, not merely descriptive. Actual code from my solutions is the starting point for each entry. Explanations provide context for understanding and adapting that code.

For example, if I frequently use `strsplit()` in R, I should be able to find `strsplit()` as a recognisable entry, see how I actually use it, and find the corresponding Python expression. It must not disappear into a general discussion of string manipulation.

The reference should also explain important differences between R and Python, NumPy and pandas, but these explanations support the practical code examples rather than replace them.

## Scope and constraints

### Source material

Use **local project files only**.

- Do not access GitHub or retrieve material from remote repositories.
- Do not use GitHub MCP or other tools to retrieve remote files.
- Do not retrieve puzzle descriptions, inputs or solutions from the internet.
- Do not assume access to material that is not present locally.
- Do not modify the original R or Python solution files.

The paired solution files are the authoritative source for identifying the techniques and coding patterns I use.

You may use your knowledge of R, Python, NumPy and pandas to explain behaviour and provide alternatives. Clearly distinguish actual implementations from additional illustrative alternatives.

### File naming convention

Solution files follow this convention, including their respective file extensions:

- `AoC_<Year>_<Day>_Code_R`
- `AoC_<Year>_<Day>_Code_Py`

Use these patterns to identify matching solutions. Do not impose alternative naming conventions.

### Coverage

Analyse every available R/Python pair in the local project for which both files exist.

- Do not restrict the analysis to a particular year or day unless explicitly instructed.
- If one member of a pair is missing, exclude that incomplete pair from the technique analysis and report it separately.
- Do not invent or reconstruct missing solution code.

## Procedure

### 1. Discover the available solutions

Scan the local project using the established project instructions.

- Identify all R and Python solution files matching the naming convention.
- Match each R file to its corresponding Python file.
- Record complete and incomplete pairs.
- Record the exact filenames of the files discovered.

### 2. Extract recognisable R expressions and patterns

Read the complete source code of every R solution in each complete pair.

Identify the actual expressions, functions and coding patterns that are useful to recognise and reuse when programming in Python.

**Do not identify only broad conceptual techniques. Identify the concrete R syntax that implements them.**

For example, consider each of these separately when they occur in the source material:

- `strsplit()`
- `paste()` and `paste0()`
- `do.call()`
- `unlist()`
- `as.numeric()`
- `as.character()`
- `data.frame()`
- `table()`
- `match()`
- `unique()`
- `sort()`
- `order()`
- `which()`
- `seq()` and `seq_len()`
- `rbind()` and `cbind()`
- `matrix()`
- `apply()` and related functions
- Logical indexing and vectorised conditions
- Arithmetic and logical operations on vectors
- The use of `NA` and handling missing values
- Loops, functions, indexing and state updates

This list is illustrative, not exhaustive. The presence of a function in this list does not establish that I use it; verify every entry against the actual source code.

Include combinations of operations when they form a useful reusable pattern. For example, splitting strings, converting the results to numeric values and assembling them into a matrix may warrant both individual entries and a combined example.

### 3. Build an entry for each useful mapping

Each entry must be concrete enough that I can recognise the R code and use the Python equivalent with minimal adjustment.

Use the following structure wherever applicable.

#### A. Recognise it in R

Show the exact R expression or a representative code block copied from one of my actual solutions.

For example, if the source contains:

```r
DF <- data.frame(do.call(rbind, strsplit(Data, "  ")))
DF <- lapply(DF, as.numeric)
```

show this actual pattern rather than replacing it with an abstract description such as “split strings and convert values to numbers”.

Include the source reference: year, day and filename.

If the expression occurs in several solutions, prefer a representative example and list other relevant occurrences.

#### B. Copy and adapt it in Python

Show the corresponding Python expression or code block.

Prioritise the implementation from my existing Python translation, provided it correctly implements the same operation or task.

The Python example must be sufficiently complete to copy and adapt. Include the necessary variable definitions, conversions or imports when they are essential to understanding or running the example.

Use meaningful variable names and preserve the original data flow where practical.

If the existing Python translation uses a different method, explain the difference and show how the corresponding operation can be implemented.

#### C. What changes?

Explain only the differences that matter for using or adapting the code, such as:

- R vectors versus Python lists or NumPy arrays.
- R's one-based indexing versus Python's zero-based indexing.
- How splitting functions return their results.
- Data types and explicit conversions.
- Array dimensions and shapes.
- Missing values.
- Indexing, matching and membership behaviour.
- Mutation, copies and assignment.
- Differences in ordering or duplicate handling.

Avoid lengthy conceptual explanations where a short practical note is sufficient.

#### D. Adaptation example

Where useful, show a small variation of the actual pattern, demonstrating how to adjust it for a different input or task.

Label this clearly as an adaptation rather than code copied from an existing solution.

Do not create an adaptation example merely to fill a template. Prioritise patterns that are likely to be useful in future programming.

#### E. Alternatives

Include NumPy, pandas or standard Python alternatives when they are genuinely useful.

Keep the main translation clearly identifiable. Do not overwhelm the entry with several competing solutions when one straightforward equivalent is sufficient.

### 4. Prioritise actual code over general descriptions

The reference is intended to be used while writing code, not just read as a tutorial.

Apply these rules:

- Put the recognisable R expression prominently in the entry title or opening.
- Show actual R code before discussing its general concept.
- Show the corresponding Python code immediately afterwards.
- Prefer complete expressions and short, runnable blocks over isolated fragments.
- Preserve enough of the surrounding code to make the example understandable.
- Include the original variable names when they help me recognise the pattern.
- Avoid replacing actual expressions with pseudocode or generic descriptions.
- Do not omit a frequently used function merely because it appears as part of a larger expression.
- Do not merge distinct functions into one broad entry if doing so makes them harder to find.
- Do not create an entry for every trivial occurrence. Prioritise reusable operations and combinations that are likely to recur.

**The reference should be searchable by the R function or expression I remember, as well as by the programming task I want to perform.**

For example, a reader looking for `strsplit()` should find it directly without needing to guess that it is covered under “input parsing”.

### 5. Distinguish actual translations from recommended alternatives

The Python code in my existing solutions is valuable evidence of how I have translated my R code, but it is not automatically the best or only implementation.

Clearly label examples as appropriate:

- **Existing R code** — taken from my actual R solution.
- **Existing Python translation** — taken from my actual Python solution.
- **Recommended equivalent** — a suggested implementation where the existing translation is absent, unnecessarily complicated or not semantically equivalent.
- **Alternative** — another useful implementation using NumPy, pandas or standard Python.
- **Illustrative adaptation** — a modified example intended to demonstrate how to reuse the pattern.

Never present generated or modified code as though it came from one of my files.

If the Python translation uses a substantially different algorithm, explain that rather than implying a direct function-to-function translation.

### 6. Check semantic equivalence

For each mapping, verify that the R and Python examples perform the same task.

Pay particular attention to differences that can silently change results, including:

- String splitting and delimiters.
- Scalar, vector and array behaviour.
- Missing values and absent matches.
- Type coercion.
- Indexing and array dimensions.
- Duplicate values and ordering.
- Logical conditions and operator precedence.
- Integer and floating-point behaviour.
- Whether a function returns positions, values, counts or a transformed object.

If the examples are not equivalent, explain the distinction and provide a corrected equivalent where possible.

Do not claim equivalence simply because two expressions look similar.

### 7. Identify recurring patterns across solutions

Compare the complete pairs across years.

- Consolidate repeated mappings into a single reusable entry.
- Retain multiple actual implementations where they reveal useful alternatives.
- List the source references for all relevant examples.
- Distinguish a new technique from a different syntax for an existing technique.
- Identify recurring R expressions that deserve their own searchable entries.
- Identify where the Python translation changes the algorithm or combines several R operations into one Python operation.

Do not organise the reference primarily as a chronological catalogue of puzzles.

### 8. Maintain the cumulative cheat sheet

Create or update the following document in the project root:

`AoC_R_Python_Techniques.md`

Organise the document by technique and recognisable R expression, with a structure that supports both browsing and searching.

Suggested organisation:

1. Input parsing and string manipulation.
2. Conversion and type handling.
3. Vectors, arrays and indexing.
4. Data frames and matrices.
5. Counting and frequency tables.
6. Matching, lookup and joins.
7. Sorting, filtering and unique values.
8. Sets and membership.
9. Logical operations and missing values.
10. Iteration, functions and state.
11. Common combinations and reusable coding patterns.
12. Algorithms and problem-solving patterns.

Adapt the organisation as the collection grows. Include an index or cross-references where useful, particularly for individual R functions that also belong to a broader technique.

Within each category, make individual functions and expressions easy to locate.

When updating the document:

- Read and preserve existing useful content.
- Integrate new findings into existing entries.
- Add newly observed expressions and patterns.
- Update mappings when additional examples reveal a better or more accurate translation.
- Consolidate duplicates without losing useful examples or source references.
- Preserve the distinction between actual code and illustrative alternatives.
- Avoid turning the document into a lengthy theoretical explanation.
- Keep the primary focus on helping an R programmer write Python.

### 9. Maintain the source-file inventory

At the bottom of the cheat sheet, maintain a section titled **Source files analysed**.

Include a table listing every complete R/Python pair actually analysed, with:

- Year.
- Day.
- Exact R filename.
- Exact Python filename.

Rebuild or reconcile this inventory against the current local files on every run. Do not list files as analysed merely because they exist.

If incomplete pairs are found, include a separate **Incomplete solution pairs** subsection identifying the available file and its missing counterpart.

Do not silently remove historical technique explanations merely because a source file is no longer present. The inventory records current coverage; preserve existing useful documentation unless it is demonstrably incorrect or removal is requested.

### 10. Quality checks

Before finishing:

- Confirm that the R examples genuinely occur in the cited source files.
- Confirm that the Python examples genuinely occur in the cited files when labelled as existing translations.
- Check that each important R expression has an identifiable Python equivalent or an explicit explanation of why no direct equivalent is appropriate.
- Check that the examples are copyable and use correct syntax.
- Verify important behavioural differences where feasible.
- Ensure that additional alternatives are clearly labelled.
- Ensure the inventory reflects the files actually analysed.
- Preserve existing useful content.
- Ensure the original solution files have not been modified.

## Final report

After updating the cheat sheet, report:

- The number of complete R/Python pairs analysed.
- The year/day range covered.
- Any incomplete pairs.
- The main expressions and mappings added or improved.
- The location of the updated cheat sheet.
- Any unresolved issues or limitations.

Keep the report concise and factual.

## Core principle

**Show me what I actually write in R, then show me Python code I can copy and adjust.**

Conceptual explanations, alternatives and performance considerations are valuable, but they must support that practical goal rather than replace it.