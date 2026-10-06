# Solve Advent of Code Problem in Python

Solve an Advent of Code problem in the current `AoC_Copilot` repository using Python.

## Procedure

1. Identify the requested year and day.

2. Check whether the problem instructions and input files are already present in the current repository.

3. If they are not present, use the GitHub MCP server to locate the corresponding problem in the user's existing AoC repository.

4. Retrieve:
   - the problem instructions;
   - the example input;
   - the actual input.

5. If the required files are already present locally, use the existing local files instead of retrieving them again.

6. Do not retrieve, inspect, or use the existing solution from the original AoC repository.

7. Create the corresponding problem directory in the current repository, preserving the existing directory structure.

8. Make local copies of the instructions and both input files when they are not already present.

9. Create a single Python solution script in the problem directory.

10. Name the script `AoC_<year>_<day>_Copilot.py`, for example `AoC_2025_03_Copilot.py`.

## Problem-solving workflow

11. Read the supplied problem instructions carefully.

12. Inspect the example input and expected example output.

13. Develop the solution using the example input.

14. Test the solution against the example and verify that it produces the expected output.

15. Only after the example succeeds, apply the solution to the actual input.

16. Verify that the solution produces a plausible result for the actual input.

17. Leave the original AoC repository unchanged.

## Python environment

- Solutions should be designed to be opened and run interactively in VS Code or Positron.
- Do not use command-line argument handling unless specifically required by the puzzle.
- Do not require the script to be run through a command-line wrapper.
- Do not use mechanisms to determine the script's location.
- Use straightforward file paths that work when the script is run interactively.
- Prefer standard Python libraries unless a third-party package provides a clear and useful benefit.
- Keep the solution readable and straightforward.
- Do not optimise prematurely; first produce a correct and understandable solution.