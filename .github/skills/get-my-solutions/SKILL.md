Get My Solutions

Objective

Synchronise my Advent of Code R and Python solution files from my original source repository into my local AoC_Copilot project.

The source repository is the authoritative source for these files. The local project is the destination where I work with the solutions and use my agent harness.

This skill retrieves existing solutions. It does not analyse, translate, rewrite or modify their contents.

Project context

Source repository: https://github.com/justinholland85/AoC

Destination project: C:/Users/justi/OneDrive/Documents/GitHub/AoC_Copilot/

File naming convention:

AoC_<Year>_<Day>_Code_R

AoC_<Year>_<Day>_Code_Py

The filenames include their appropriate file extensions.

Use the configured GitHub MCP tools to access the source repository. Do not assume that the source files are all in one directory; inspect the repository's directory structure.

Procedure

1. Inspect the source repository

Use GitHub MCP to inspect the repository and discover the relevant directory structure.

Search through the repository for files matching the solution naming convention.

Identify the year and day associated with each file, and group files into matching R/Python pairs.

Do not rely on a hard-coded list of years, days or source directories.

2. Identify complete pairs

A day is eligible for copying only when both of the following are available in the source repository:

The R solution, AoC_<Year>_<Day>_Code_R

The Python solution, AoC_<Year>_<Day>_Code_Py

Use the actual filenames, including extensions, and match files by year and day.

If only one file is available, classify the day as an incomplete pair and do not copy either file for that day.

Do not retrieve unrelated files or other versions of the solutions.

3. Map source paths to destination paths

For every complete pair, preserve the source directory structure relative to the repository root.

For example, if a source file is located at:

2024/Day_01/AoC_2024_01_Code_R.R

its destination should be:

C:/Users/justi/OneDrive/Documents/GitHub/AoC_Copilot/2024/Day_01/AoC_2024_01_Code_R.R

This example illustrates the mapping; use the actual paths discovered in the repository.

Do not flatten the directory structure or invent a different directory layout.

4. Copy the files

For each complete pair:

Ensure the corresponding destination directory exists, creating it if necessary.

Copy the R solution from the source repository to the mapped destination.

Copy the Python solution to the mapped destination.

If either destination file already exists, replace it with the source version.

Preserve the source filenames and file contents exactly.

Use GitHub MCP to retrieve the source files and appropriate local filesystem tools to write them into the destination project.

If a file cannot be retrieved or written successfully, report the failure. Do not claim that the pair was synchronised successfully unless both files were copied successfully.

5. Protect the source and destination

Never modify, rename or delete files in the source repository.

Never modify the contents of a solution during copying.

Never delete destination files simply because they do not have a matching source file.

Do not overwrite unrelated files.

Only replace destination files corresponding to complete source pairs.

Do not create missing R or Python solutions.

6. Verify the results

After copying, verify that both files in every successfully processed pair exist at their intended destination paths.

Where practical, compare source and destination file contents or hashes to confirm that copying preserved the files exactly.

Distinguish between:

Newly copied files.

Existing files that were replaced.

Pairs that were already present and identical.

Incomplete source pairs that were skipped.

Pairs that failed to copy or verify.

7. Report the results

Provide a concise summary containing:

The number of complete pairs discovered in the source repository.

The number of pairs copied successfully.

The number of existing pairs updated or replaced.

The number of pairs already identical at the destination.

Incomplete pairs skipped, with their year/day and available filenames.

Any copying or verification failures.

The destination directories and files affected.

Do not claim success for operations that failed or could not be verified.