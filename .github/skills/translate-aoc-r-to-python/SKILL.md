# Translate Advent of Code R Solution to Python

Translate the user's existing R solution for an Advent of Code problem into Python.

The purpose is to preserve the algorithm and problem-solving approach of the R solution while expressing it naturally in Python.

## Procedure

1. Identify the requested year and day.

2. Locate the user's existing R solution in the original `justinholland85/AoC` repository using the GitHub MCP server.

3. Retrieve the R solution from the original repository.

4. Do not use or inspect the Copilot R solution or the independently generated Python solution when developing the translation.

5. If the R solution refers to a `Lib.` function, use the GitHub MCP server to inspect the corresponding function in the user's `justinholland85/RLibrary` repository.

6. Identify the main algorithm and data transformations used by the R solution before translating the code.

7. Translate the R solution into Python while preserving the original algorithm and overall approach.

8. Use Python idioms where appropriate, but do not replace the original algorithm with a substantially different algorithm merely because it may be shorter or more efficient.

9. Create the Python translation in the corresponding problem directory in the current `AoC_Copilot` repository.

10. Name the script `AoC_<year>_<day>_R_to_Python.py`, for example `AoC_2025_03_R_to_Python.py`.

## Validation

11. Use the existing local problem instructions and input files where available.

12. Test the translated Python solution using the example input.

13. Verify that it produces the expected example output.

14. Apply the translated solution to the actual input.

15. Verify that the Python solution produces the same result as the original R solution.

16. If the results differ, investigate the difference rather than silently changing the Python solution.

17. Leave the original AoC repository and RLibrary unchanged.