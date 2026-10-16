---
name: get-aoc-instructions
description: Find local Advent of Code R solution scripts and synchronise their corresponding Instructions.txt and Input_1.txt files from the original GitHub source repository, preserving directory structure and replacing existing destination copies.
---

# Get AoC Instructions and Inputs

## Objective

Synchronise Advent of Code puzzle instructions and input files from my original source repository into my local `AoC_Copilot` project.

The purpose is to ensure that every locally available R solution has its corresponding puzzle instructions and actual input available locally for analysis by other skills.

## Project context

- **Source repository:** `https://github.com/justinholland85/AoC`
- **Destination project:** `C:/Users/justi/OneDrive/Documents/GitHub/AoC_Copilot/`
- **R solution filename:** `AoC_<Year>_<Day>_Code_R.R`
- **Instructions filename:** `AoC_<Year>_<Day>_Instructions.txt`
- **Input filename:** `AoC_<Year>_<Day>_Input_1.txt`

Use the configured GitHub MCP tools to access the source repository and appropriate local filesystem tools to write files into the destination project.

## Scope and constraints

### 1. Determine the scope from local R solutions

Scan the local `AoC_Copilot` project for every R solution matching:

`AoC_<Year>_<Day>_Code_R.R`

For each matching R solution, attempt to locate both associated files in the source repository:

- `AoC_<Year>_<Day>_Instructions.txt`
- `AoC_<Year>_<Day>_Input_1.txt`

**A matching Python solution is not required.**

The existence of a local R solution determines whether a day is in scope, regardless of whether a Python solution exists.

### 2. Retrieve files from the source repository

For each qualifying R solution:

1. Identify the year and day from its filename.
2. Search the source repository's directory structure for the corresponding instructions and input files.
3. Retrieve each file that exists in the source repository.
4. Do not assume that all files are located in one directory.
5. Do not retrieve unrelated files for days that have no qualifying local R solution.

Use only the designated GitHub source repository for remote retrieval. Do not use web search or other online sources to obtain missing files.

If one of the two files is unavailable, continue with the other file and report the missing file.

### 3. Preserve the destination structure

Map each source file's path relative to the repository root to the corresponding path under the local `AoC_Copilot` project.

Preserve the source directory structure. Do not flatten directories or invent a different layout.

Create destination directories as necessary.

### 4. Copy and replace

For each qualifying day, copy the available instructions and input files to their mapped destination paths.

- Replace existing destination files with the corresponding source versions.
- Preserve filenames and file contents exactly.
- Do not modify the R solution scripts.
- Do not copy Python solutions.
- Do not delete destination files merely because they are not part of the current synchronisation scope.
- Do not modify or delete files in the source repository.

If copying either file fails, report the failure and continue processing the remaining files.

### 5. Verify the results

After copying, verify that each successfully processed file exists at the intended destination path.

Where practical, compare source and destination contents or hashes to confirm that copying preserved the files exactly.

Distinguish between:

- Files newly copied.
- Existing files replaced.
- Files already identical at the destination.
- Instructions files missing from the source.
- Input files missing from the source.
- Copying or verification failures.

Do not claim that a file was synchronised successfully unless the operation was completed and verified.

### 6. Final report

Summarise:

- The number of local R solution scripts discovered.
- The number of days processed.
- The