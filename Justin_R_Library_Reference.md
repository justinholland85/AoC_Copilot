# Justin's R Library Reference for Advent of Code

Focused notes on the functions from Justin's personal R library that are
actually called in the local AoC R solutions, plus a small number of verified
related alternatives. This is not a catalogue of the entire library. The AoC
examples establish usage; alternatives are identified from their definitions
and are not yet demonstrated in an AoC solution.

The repository README describes the library as personal, use-at-own-risk
functionality. Inspect a definition before relying on it, and use it only when
the project environment has loaded the library and the function suits the
problem.

## Established functions used in AoC solutions

### Naming and input indexing

#### `Lib.LeadingZeros`

- **Status:** Used in all nine inspected AoC R scripts.
- **Definition:** [`Lib_LeadingZeroes.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_LeadingZeroes.R)
- **Purpose and arguments:** Converts `X` to character, measures each value's
  width, and prepends zeroes to reach width `d`. If `d` is omitted, it uses
  the maximum width within `X`.
- **Return:** Character vector made with `paste0()`, preserving one output per
  input value.
- **AoC usage:** Each script constructs the puzzle identifier with
  `Lib.LeadingZeros(Day, 2)`, e.g. `AoC_2015_01`.
- **When to use:** Formatting numeric identifiers or labels to a fixed minimum
  width when character output is desired.
- **Limitations:** It does not validate `d`; a target width shorter than an
  input string can produce a negative repeat count in its internal padding
  logic. Its filename spells “Zeroes”, while the defined and called function
  is `Lib.LeadingZeros`.

#### `Lib.Take.Which`

- **Status:** Used in 2023 Day 01.
- **Definition:** [`Lib_ListTrivials.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_ListTrivials.R)
- **Purpose and arguments:** `Lib.Take.Which(A, B)` returns `A[B]`; it is a
  thin wrapper around ordinary R `[` indexing.
- **Return:** The selected element or elements, retaining base R indexing
  behavior.
- **AoC usage:** `lapply(Numbers, Lib.Take.Which, 1)` selects the first
  character of each line's digit vector; `mapply(Lib.Take.Which, Numbers,
  Count)` selects each vector's final character.
- **When to use:** Consider it when this library idiom is already in use or
  when passing an indexing function into `lapply()`/`mapply()` is convenient.
  Base `A[B]` is an equally direct option.
- **Limitations:** The wrapper adds no bounds checking or special handling for
  missing indices; selection follows base R indexing semantics.

### Missing-value handling and table names

#### `Lib.NA.To.Zero`

- **Status:** Used in 2022 Day 01 and 2024 Day 01.
- **Definition:** [`Lib_ListTrivials.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_ListTrivials.R)
- **Purpose and arguments:** For `X`, replaces positions selected by
  `which(is.na(X))` with numeric zero.
- **Return:** The modified `X`.
- **AoC usage:** In 2022, blank lines become missing values during numeric
  conversion; the script uses those positions to form group IDs, then changes
  missing calorie values to zero before `tapply(..., sum)`. In 2024, missing
  table lookups are turned into zero similarity multipliers.
- **When to use:** Only when `NA` means “contributes zero” in the problem's
  semantics, such as a missing frequency count.
- **Limitations:** It replaces all values for which `is.na()` is true,
  including `NaN` in R. Do not use when missingness should be preserved or
  distinguished. The function does not expose a configurable replacement
  value.

#### `Lib.NumericNames`

- **Status:** Used in 2024 Day 01.
- **Definition:** [`Lib_ListTrivials.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_ListTrivials.R)
- **Purpose and arguments:** Returns `as.numeric(names(X))`.
- **Return:** Numeric vector derived from the names of `X`.
- **AoC usage:** `table(DF$X2)` produces a frequency table with character
  names; the solution converts those names to numeric values before comparing
  them to the left-column IDs with `match()`.
- **When to use:** When a named object (for example, a `table`) has
  numeric-looking names that need numeric interpretation.
- **Limitations:** No checks are made for absent or non-numeric names; base
  `as.numeric()` conversion behavior, including resulting `NA`s, applies.

### Row lists and grouped occurrences

#### `Lib.RowsToList`

- **Status:** Used in 2016 Day 01.
- **Definition:** [`Lib_RowsToList.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_RowsToList.R)
- **Purpose and arguments:** Applies `list` across rows with
  `apply(X, 1, list)`, then `unlist()`s each row with `lapply()`.
- **Return:** A list with one flattened row vector per input row.
- **AoC usage:** Converts selected direction rows from the two-column
  `VectorMap` into a list so `rep(Vectors, Steps)` can expand each unit
  direction by its associated step count.
- **When to use:** When a matrix's rows need to become separate list elements
  for subsequent list operations.
- **Limitations:** It assumes row-oriented, matrix-like input. `apply()` can
  coerce mixed-type input to a common type, and the function does not validate
  dimensions or preserve arbitrary row classes.

#### `Lib.GroupOn`

- **Status:** Used in 2016 Day 01.
- **Definition:** [`Lib_SeqOn.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_SeqOn.R)
- **Purpose and arguments:** Accepts columns through `...`, or a data frame
  through `DF`; optionally accepts grouping `Names` and `FullOut`. It converts
  the input to `data.table`, calls `Lib.Tuple.Count()`, and returns the
  resulting `Index.Match` group ID for each original row by default.
- **Return:** A vector of group identifiers aligned to the input rows by
  default. `FullOut` is intended to request fuller output.
- **AoC usage:** `Lib.GroupOn(Position$x, Position$y)` assigns an ID to each
  unique coordinate tuple, so repeated visits to a coordinate share an ID.
- **When to use:** Consider it when several columns jointly define a group
  and an ID per original row is useful for subsequent processing.
- **Limitations:** The implementation requires `data.table` and the related
  tuple helpers. For a one-column input it adds a dummy column before grouping.
  The `FullOut == 1` branch assigns `Null` (capital N, lowercase ull), which
  is not R's built-in `NULL`; that branch can fail if no object named `Null`
  exists. The AoC example uses the default output, not this branch.

#### `Lib.SeqOn`

- **Status:** Used in 2016 Day 01 and 2018 Day 01.
- **Definition:** [`Lib_SeqOn.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_SeqOn.R)
- **Purpose and arguments:** Builds a `data.table` from `X`, groups by `X`,
  and calculates `seq_len(.N)` within each group.
- **Return:** An integer sequence number for each value's occurrence, in
  original row order: each distinct value's first occurrence is 1, second is
  2, and so on.
- **AoC usage:** In 2016, `Lib.SeqOn(Group)` identifies the second visit to a
  coordinate group. In 2018's initial repeated-frequency approach,
  `Lib.SeqOn(CumSum)` marks repeated cumulative frequencies; the script tests
  whether `max(Seq) > 1`.
- **When to use:** When the occurrence number within each value/group is
  useful, especially when the first repeat is the stopping condition.
- **Limitations:** Requires `data.table` to be available. Group identity and
  missing-value behavior follow `data.table` grouping semantics.

## Related library alternatives

The functions below were found by inspecting definitions related to the
established AoC calls. They are **not shown as used in the inspected AoC
solutions**.

### Configurable missing-value replacement

#### `Lib.NA.To.Val`

- **Definition:** [`Lib_ListTrivials.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_ListTrivials.R)
- **Relationship:** Same replacement pattern as `Lib.NA.To.Zero`, with an
  explicit `v` argument instead of fixed zero.
- **Arguments and return:** `Lib.NA.To.Val(X, v)` replaces positions where
  `is.na(X)` is true with `v`, then returns `X`.
- **AoC use case:** Replace missing costs, IDs, or counts with a problem-
  specific sentinel or default value when zero would have a different
  meaning.
- **Caveat:** It also matches `NaN` because it uses `is.na()`. Replacement
  compatibility and coercion follow base R assignment rules.

#### `Lib.NAN.To.Zero`

- **Definition:** [`Lib_ListTrivials.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_ListTrivials.R)
- **Relationship:** Replaces only `is.nan(X)` values, unlike
  `Lib.NA.To.Zero`, which replaces all `is.na()` positions, including
  `NaN`.
- **Arguments and return:** Accepts `X`, assigns zero at NaN positions, and
  returns `X`.
- **AoC use case:** Consider it only when undefined numeric calculations
  (`NaN`) should become zero but ordinary missing values (`NA`) must remain
  missing.
- **Caveat:** It does not replace ordinary `NA` values.

### Tuple grouping and aggregate results

#### `Lib.Tuple.Count`

- **Definition:** [`Lib_Tuple_Count.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_Tuple_Count.R)
- **Relationship:** `Lib.GroupOn()` uses this function internally. It also
  exposes group counts and the distinct tuple index rather than returning
  only an ID per input row.
- **Arguments and return:** Accepts columns via `...`, or a data frame via
  `DF`, with optional `Names`. Returns a list containing `Count` (count
  aligned to input rows), `Index` (distinct tuples ordered by grouping keys),
  `Index.Count` (one count per distinct tuple), and `Index.Match` (group ID
  aligned to input rows).
- **AoC use case:** Useful when a puzzle needs the number of occurrences per
  distinct one- or multi-column key, as well as the key table or row-to-group
  mapping.
- **Limitations:** Uses `data.table` and `Lib.Tuple.Match`; values are grouped
  by exact tuple columns, and output order of distinct tuples is sorted by the
  implementation.

#### `Lib.Tuple.Sum`

- **Definition:** [`Lib_Tuple_Count.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_Tuple_Count.R)
- **Relationship:** Parallel to `Lib.Tuple.Count`, but sums a supplied `Var`
  vector per tuple rather than counting rows.
- **Arguments and return:** Accepts key columns via `...` or `DF`, a `Var`
  vector to sum, and optional `Names`. Returns a list with `Sum` aligned to
  the joined input rows, `Index` of distinct keys, `Index.Sum` for those
  keys, and `Index.Match` mapping input rows to groups.
- **AoC use case:** Consider for grouped numeric totals when retaining both
  per-row group totals and a distinct-key summary is helpful.
- **Limitations:** Requires `data.table`; the input vectors must align by
  row. Compare with base `tapply()` or `aggregate()` before using it, as the
  richer return object may be unnecessary for a small puzzle.

#### `Lib.Tuple.Match`

- **Definition:** [`Lib_Tuple_Match.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_Tuple_Match.R)
- **Relationship:** Called internally by `Lib.Tuple.Count()` to map input rows
  to the distinct tuple index. It is not called directly in the inspected AoC
  solutions.
- **Arguments and return:** Accepts row tuples `X` and a tuple index
  `Index`. It gives both tables matching generated column names, joins them
  with `merge(..., sort = FALSE)`, and returns each input row's corresponding
  row index in `Index`.
- **AoC use case:** Consider when a state or coordinate consists of multiple
  fields and rows need to be mapped to a table of unique states.
- **Limitations:** Requires `data.table`. It assumes the tuple columns in
  `X` and `Index` correspond and that `Index` contains unique keys for
  unambiguous matches; no explicit validation or fallback is provided for a
  missing key, which can produce `NA`.

### Vector-to-list conversion

#### `Lib.VecToList`

- **Definition:** [`Lib_VecToList.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_VecToList.R)
- **Relationship:** Analogous to `Lib.RowsToList`, but makes one list element
  per vector element rather than one element per matrix row.
- **Arguments and return:** For vector `X`, constructs an index sequence and
  calls `tapply(X, Seq, identity, simplify = FALSE)`, returning a list with
  each element holding one original value.
- **AoC use case:** Consider when a downstream operation specifically
  requires a list of scalar elements.
- **Limitations:** This is not a row conversion and is usually unnecessary
  when ordinary vector indexing or `as.list(X)` expresses the operation more
  directly.

## Choosing a library helper

- Prefer a demonstrated helper when the new task has the same input shape and
  semantics as its AoC example.
- Read the function definition before use; the helpers are not uniformly
  validated or documented.
- Do not load the entire personal library merely to use one helper if the
  task environment does not already provide it. Follow the project setup and
  its declared dependencies.
- Prefer base R for a trivial equivalent when the helper adds no useful
  behavior. In particular, `Lib.Take.Which()` simply wraps `[`.
- The definitions inspected show that `Lib.GroupOn()`, `Lib.SeqOn()`, and
  tuple helpers rely on `data.table`; check availability before calling them.

## Source material analysed

Nine canonical local AoC R solutions were inspected for `Lib.*` calls. Their
function calls were identified from complete source files; the seven distinct
functions listed above were checked against the library definitions.

### AoC solutions inspected

| Year | Day | Solution file inspected |
|---|---:|---|
| 2015 | 01 | [AoC_2015_01_Code_R.R](2015/AoC_2015_01/AoC_2015_01_Code_R.R) |
| 2016 | 01 | [AoC_2016_01_Code_R.R](2016/AoC_2016_01/AoC_2016_01_Code_R.R) |
| 2017 | 01 | [AoC_2017_01_Code_R.R](2017/AoC_2017_01/AoC_2017_01_Code_R.R) |
| 2018 | 01 | [AoC_2018_01_Code_R.R](2018/AoC_2018_01/AoC_2018_01_Code_R.R) |
| 2019 | 01 | [AoC_2019_01_Code_R.R](2019/AoC_2019_01/AoC_2019_01_Code_R.R) |
| 2020 | 01 | [AoC_2020_01_Code_R.R](2020/AoC_2020_01/AoC_2020_01_Code_R.R) |
| 2022 | 01 | [AoC_2022_01_Code_R.R](2022/AoC_2022_01/AoC_2022_01_Code_R.R) |
| 2023 | 01 | [AoC_2023_01_Code_R.R](2023/AoC_2023_01/AoC_2023_01_Code_R.R) |
| 2024 | 01 | [AoC_2024_01_Code_R.R](2024/AoC_2024_01/AoC_2024_01_Code_R.R) |

### Library source files inspected

Definitions for the seven established functions were located in:

- [`Lib_LeadingZeroes.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_LeadingZeroes.R) — `Lib.LeadingZeros`.
- [`Lib_ListTrivials.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_ListTrivials.R) — `Lib.Take.Which`, `Lib.NumericNames`, `Lib.NA.To.Zero`, and related missing-value helpers.
- [`Lib_RowsToList.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_RowsToList.R) — `Lib.RowsToList`.
- [`Lib_SeqOn.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_SeqOn.R) — `Lib.GroupOn` and `Lib.SeqOn`.

Related definitions inspected:

- [`Lib_Tuple_Count.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_Tuple_Count.R) — `Lib.Tuple.Count`, `Lib.Tuple.Sum`.
- [`Lib_Tuple_Match.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_Tuple_Match.R) — `Lib.Tuple.Match`, used internally by `Lib.Tuple.Count`.
- [`Lib_VecToList.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_VecToList.R) — `Lib.VecToList`.
- [`Lib_Group.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_Group.R) — reviewed for grouped aggregate alternatives; not included as a separate entry because tuple aggregation is covered above.

Other library source candidates briefly inspected and excluded because they
were not sufficiently related to the AoC-used functions:

- [`Lib_AsNumeric.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_AsNumeric.R)
- [`Lib_GiveNames.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_GiveNames.R)
- [`Lib_GuessDelim.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_GuessDelim.R)
- [`Lib_NameByMap.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_NameByMap.R)
- [`Lib_RangeNames.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Lib_RangeNames.R)

Library setup and scope were checked in [`README.md`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/README.md), [`Start.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Start.R), and [`Start_List.R`](https://github.com/justinholland85/RLibrary/blob/28a8fc79285fc2bd542eecee02f1b5cdc85188e8/Start_List.R). No separate tests or function documentation were located or used.
