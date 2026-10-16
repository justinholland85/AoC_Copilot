# AoC 2020 Day 1 Summary

This summary covers only [AoC_2020_01_Copilot.R](./AoC_2020_01_Copilot.R).

## Key algorithmic idea

Both parts use complement lookup against the target sum of 2020. Part 1 searches for `2020 - value` among values already seen. Part 2 searches for `2020 - (first + second)` among all input values, after excluding complements equal to either selected value so a single entry cannot be reused.

## Major steps

1. Build paths to the example and actual input files, and read each as integer expenses.
2. For Part 1, scan the expenses once, checking each complement in a hash-like R environment of earlier values. Return the product at the first match; throw an error if no pair is found.
3. For Part 2, first store all expense values in an R environment, then check each index pair with `j > i`. Look up the remaining complement and return the three-value product when found; throw an error if no valid triple is found.
4. Run both algorithms on the example input and validate the known products with `stopifnot` before computing and printing the actual-input results.
5. Record `proc.time()` before the work and evaluate the elapsed process-time difference at the end.

## Notable performance considerations

- Part 1 takes expected O(n) time and O(n) auxiliary space using environment lookups rather than comparing every pair.
- Part 2 takes O(n^2) time in the worst case, with O(n) space for the lookup environment. It avoids allocating the O(n^2)-sized Cartesian product grid used by the original R solution.
- Both searches return immediately when a match is found. For this puzzle’s input size, the straightforward complement method is efficient while keeping the checks clear.
