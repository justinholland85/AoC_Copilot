# R–Python Techniques from Advent of Code Solutions

This reference consolidates reusable patterns demonstrated by the paired local
solutions listed in [Source files analysed](#source-files-analysed). The R and
Python sections describe the checked-in implementations; alternatives are
labelled as illustrative when they are not used by those scripts.

## Input parsing and character strings

### Map characters to values

**Purpose:** Turn a small alphabet into numeric contributions, then aggregate
them.

- **R:** A named vector acts as a lookup table, e.g. `c("(" = 1, ")" = -1)`,
  followed by `CharVal[Split]` and `sum(Value)`.
- **Python shown:** A dictionary (`{"(": 1, ")": -1}`), a character list and a
  list comprehension (`[CharVal[x] for x in Split]`), followed by `sum`.
- **Alternatives:** NumPy can hold the contributions in an array and use
  `np.sum`; for a one-pass standard-Python version, use
  `sum(CharVal[ch] for ch in text)` without materializing intermediate lists.

R named-vector indexing returns `NA` for an unknown name by default; Python
dictionary indexing raises `KeyError`. The latter makes unexpected characters
fail explicitly, while R code should check for missing lookup results if the
input alphabet is not guaranteed. Examples: [2015 Day 01 R](./2015/AoC_2015_01/AoC_2015_01_Code_R.R)
and [2015 Day 01 Python](./2015/AoC_2015_01/AoC_2015_01_Code_Py.Py).

### Remove or replace substrings; preserve overlapping word matches

**Purpose:** Extract digits from noisy calibration strings, including numbers
written as words.

- **R shown:** Repeated `gsub` calls remove letters for numeric-only input.
  For word digits, the solution replaces each word with its first letter, digit,
  and last letter (for example, `eight` becomes `e8t`) before reusing the
  numeric extraction logic.
- **Python shown:** `Series.str.replace(..., regex=True)` removes lowercase
  letters, then list conversion and first/last indexing select digit
  characters. Part 2 attempts elementwise string replacement with NumPy.
- **Illustrative alternative:** `re.sub(r"[a-z]", "", line)` removes lowercase
  letters in standard Python. To handle overlapping words reliably, scan each
  input position for digit words instead of replacing a word with a single
  digit; overlapping input such as `oneight` contains both `one` and `eight`.

Important translation caveat: the checked-in Python Part 2 is not a working
equivalent of the R method. It refers to `X`, `First`, and `Last` without
defining them in that function, passes integers where the spelled-out words
would be needed for replacement, and its execution cell calls Part 1 again.
Treat the R boundary-preserving replacement as the demonstrated algorithm;
the Python code needs correction before it can be used for Part 2.
Examples: [2023 Day 01 R](./2023/AoC_2023_01/AoC_2023_01_Code_R.R)
and [2023 Day 01 Python](./2023/AoC_2023_01/AoC_2023_01_Code_Py.py).

## Vectors, arrays and indexing

### Shift, wrap and compare neighbouring values

**Purpose:** Compare each element with the next element in a circular sequence,
or with the element halfway around it.

- **R shown:** Construct a shifted vector with `c(x[-1], x[1])`-style indexing
  for a circular neighbour; for the halfway comparison, slice the first and
  second halves and compare corresponding entries.
- **NumPy shown:** Use `np.concatenate((x[1:], x[:1]))` for a one-step circular
  shift. For halfway comparisons, use `x[:n//2]` and `x[n//2:]`.
- **Illustrative alternatives:** `np.roll(x, -1)` performs a circular shift.
  Standard Python can compare with index arithmetic, such as
  `x[(i + 1) % len(x)]`, or use `zip(x, x[1:] + x[:1])` for a list.

For a circular comparison, the final value must be paired back to the first;
an ordinary adjacent slice omits this wraparound. The halfway solution assumes
an even-length input. In R, indices start at 1; in Python/NumPy, indices start
at 0. Examples: [2017 Day 01 R](./2017/AoC_2017_01/AoC_2017_01_Code_R.R)
and [2017 Day 01 Python](./2017/AoC_2017_01/AoC_2017_01_Code_Py.py).

### Cumulative sums as a running state

**Purpose:** Turn incremental changes into each successive state, then count,
compare, or search those states.

- **R shown:** `cumsum` produces running positions/frequencies; `which` or
  helper functions locate the first event or repeated value.
- **NumPy shown:** `np.cumsum` and `np.where`/boolean masks provide the
  corresponding array operations.
- **Standard Python alternative:** `itertools.accumulate(changes)` yields
  running totals lazily; use `enumerate` to retain each position.

R's first position is 1-based, whereas NumPy's `where(...)[0]` returns 0-based
indices. In the 2015 Day 01 pair, R returns `which(Position == -1)[[1]]`, the
1-based character position, while Python returns `np.where(...)[0][0]`, a
0-based index. Add one if the desired result is a character position rather
than an array index. Examples: [2015 Day 01 R](./2015/AoC_2015_01/AoC_2015_01_Code_R.R),
[2015 Day 01 Python](./2015/AoC_2015_01/AoC_2015_01_Code_Py.Py),
[2018 Day 01 R](./2018/AoC_2018_01/AoC_2018_01_Code_R.R),
and [2018 Day 01 Python](./2018/AoC_2018_01/AoC_2018_01_Code_Py.py).

### Vectorized movement on a grid

**Purpose:** Convert turns into directions, scale unit direction vectors by
step counts, and derive positions.

- **R shown:** A row-bound vector map is indexed by direction (`Direction + 1`);
  `apply(Move, 2, cumsum)` cumulatively sums each coordinate column.
- **NumPy shown:** A two-column `VectorMap` is indexed directly by
  zero-based direction values. `Steps[:, None]` adds a column axis so
  `Vectors * Steps[:, None]` broadcasts each step count across its x/y pair;
  `np.cumsum(Move, axis=0)` accumulates rows.
- **Python alternative:** A small direction tuple/map and a loop over
  `(turn, steps)` updates x and y without building arrays.

The NumPy `[:, None]` shape matters: multiplying an `(n, 2)` array by an
`(n,)` array does not mean “scale each row” and usually fails or broadcasts on
the wrong axis. The Part 2 implementations expand each instruction into unit
steps and store every visited coordinate so they can detect the first
revisited location. This costs O(total steps) memory and time; it is simple,
but long moves create many intermediate rows. Examples:
[2016 Day 01 R](./2016/AoC_2016_01/AoC_2016_01_Code_R.R)
and [2016 Day 01 Python](./2016/AoC_2016_01/AoC_2016_01_Code_Py.py).

## Counting, grouping and lookup

### Split rows, aggregate groups and select top values

**Purpose:** Use blank lines as separators, sum values within each group, then
find the largest group or the top few.

- **R shown:** Convert blank lines to `NA`, use `cumsum(is.na(...))` as a group
  identifier, replace separator values with zero, and aggregate with
  `tapply(..., sum)`. Sort descending and select the first three.
- **Python shown:** pandas reads blank lines as `NaN`; `np.cumsum(np.isnan(x))`
  creates group IDs. `pd.Series(x).fillna(0).groupby(group_id).sum()` computes
  the group totals, and `.nlargest(3).sum()` gets the top-three sum.
- **Illustrative standard-Python alternative:** Iterate over lines, accumulate
  a running group total, and flush it when a blank line is encountered; then
  use `max(totals)` or `sum(sorted(totals, reverse=True)[:3])`.

The separator is assigned to the preceding group by the cumulative missing
value count, and replacing its `NA`/`NaN` with zero makes that group end
correctly. Preserve blank lines while parsing; readers that skip them lose the
group boundaries. R's `[1:3]` can request three positions even when fewer than
three groups exist, while pandas `.nlargest(3)` returns only existing rows.
Examples: [2022 Day 01 R](./2022/AoC_2022_01/AoC_2022_01_Code_R.R)
and [2022 Day 01 Python](./2022/AoC_2022_01/AoC_2022_01_Code_Py.py).

### Frequency tables and weighted matching

**Purpose:** Count occurrences of values in one column, then multiply each
value in another column by the matching count.

- **R shown:** `table(X2)` builds the frequency table; `match` aligns counts
  with `X1`; a helper converts missing matches to zero.
- **pandas shown:** `value_counts()` builds counts; `Series.map(counts)` maps
  them to the left column; `fillna(0)` handles values absent from the table.
- **Illustrative alternatives:** A Python `Counter` from `collections` can
  store counts and drive a weighted `sum`. NumPy's `np.unique(...,
  return_counts=True)` can build a count array, but mapping arbitrary values
  back to those counts is less direct than a dictionary or pandas Series.

Missing lookups need explicit handling: R table subscripts can produce `NA`,
and pandas `map` produces `NaN`; neither should silently become a meaningful
multiplier. These solutions use numeric names/keys, so be careful about string
versus numeric representations when matching. Examples:
[2024 Day 01 R](./2024/AoC_2024_01/AoC_2024_01_Code_R.R)
and [2024 Day 01 Python](./2024/AoC_2024_01/AoC_2024_01_Code_Py.py).

### Sort-and-pair distance

**Purpose:** Match two lists by rank after independently sorting them, then
aggregate pairwise absolute differences.

- **R shown:** Parse each row into two numeric columns, `sort` each column, and
  sum `abs(X1 - X2)`.
- **NumPy/pandas shown:** Split each input line into a two-column DataFrame,
  convert with `pd.to_numeric`, sort each column with `np.sort`, subtract
  elementwise, take `np.abs`, and sum.

This is rank-wise pairing, not nearest-neighbour matching. Both columns must
have the same length. Sorting dominates the cost at O(n log n); the subsequent
vector subtraction and sum are O(n). Examples:
[2024 Day 01 R](./2024/AoC_2024_01/AoC_2024_01_Code_R.R)
and [2024 Day 01 Python](./2024/AoC_2024_01/AoC_2024_01_Code_Py.py).

## Algorithms and problem-solving patterns

### Complement lookup for target sums

**Purpose:** Find values that sum to a target, and use the selected values to
form a product.

- **R shown, two values:** Compute `target - X`, test membership with `%in%`,
  select matching values and call `prod`.
- **Python shown, two values:** Compute `Delta = target - X` and use
  `np.isin(Delta, X)` as a vectorized membership mask.
- **R and Python shown, three values:** Construct all ordered pairs
  (`expand.grid` / project helper `Lib_ExpandGrid`), calculate pair sums,
  compare sums against target complements, deduplicate selected first values,
  and multiply.
- **Illustrative standard-Python alternatives:** For two values, keep
  previously seen values in a set/dictionary and check each complement in
  expected O(n) time. For three values, fix one value and use a two-pointer
  search over a sorted copy, for O(n²) time after sorting.

The pair-grid approach uses O(n²) memory and work and includes ordered and
self-pairs. The 2020 solutions rely on the puzzle answer being formed from
distinct relevant entries and use `unique`/`np.unique` after filtering; that
deduplication is not a general way to enforce distinct input positions.
When duplicate values or repeated use of the same entry are possible, track
indices or use a search designed to enforce position constraints. `np.isin`
and `%in%` are membership tests, not joins that preserve multiplicity.
Examples: [2020 Day 01 R](./2020/AoC_2020_01/AoC_2020_01_Code_R.R)
and [2020 Day 01 Python](./2020/AoC_2020_01/AoC_2020_01_Code_Py.py).

### Repeated state detection in a cyclic process

**Purpose:** Apply a sequence of changes repeatedly until a cumulative state
appears for a second time.

- **R shown:** The initial version appends another cycle, recomputes `cumsum`
  over all changes, and uses `Lib.SeqOn` to detect duplicates. Later versions
  retain cumulative history and test each new state (`%in%`), or precompute
  one cycle's cumulative changes and add a cycle base before testing a whole
  batch.
- **Python shown:** The initial version repeatedly grows a NumPy array with
  `np.append`, recomputes `np.cumsum`, and calls `Lib_SeqOn`. A later version
  appends one state at a time and checks list membership; another precomputes
  a cycle's prefix sums and uses `np.isin` against prior-cycle values.
- **Illustrative alternative:** A Python `set` of frequencies gives expected
  O(1) membership per newly generated state and avoids scanning the entire
  history for every step:

  ```python
  import itertools

  seen = {0}
  frequency = 0
  for change in itertools.cycle(changes):
      frequency += change
      if frequency in seen:
          break
      seen.add(frequency)
  ```

The repeated-concatenation versions rebuild growing arrays and cumulative
sums, causing substantial repeated work and allocation. Incremental
per-frequency scans avoid recomputing the prefix sum but list/vector membership
is still linear in the number of prior states. Cycle-at-a-time versions
amortize computation by precomputing prefix sums, but retain all prior values
and compare each new batch against that growing history. The set-based
alternative is often the most direct for this task. The puzzle is assumed to
eventually repeat; without that guarantee, unbounded iteration needs a
termination strategy. Examples: [2018 Day 01 R](./2018/AoC_2018_01/AoC_2018_01_Code_R.R)
and [2018 Day 01 Python](./2018/AoC_2018_01/AoC_2018_01_Code_Py.py).

### Iterative versus recursive transformations

**Purpose:** Repeatedly transform a value until the next result is zero, while
accumulating all positive intermediate values.

- **R shown:** Part 2 repeatedly applies `pmax(floor(x / 3) - 2, 0)` to a
  vector of masses, stores each round in a list, then `unlist`s and sums. A
  second version uses recursive `sapply` over each mass.
- **Python shown:** Integer floor division (`//`) and `np.maximum` transform
  all masses at once; a loop stores each round and concatenates the results.
  A recursive alternative is also included.
- **Illustrative standard-Python alternative:** A scalar `while` loop can
  calculate each mass's fuel and accumulate it without keeping all rounds.

The vectorized loop processes all masses in parallel until every fuel value is
zero; the recursive approach follows each mass's chain independently. Both
terminate quickly because the values shrink. Python recursion can hit the
interpreter recursion limit for unusually long chains; iteration avoids that
risk. `//` performs floor division, matching `floor(x / 3)` for nonnegative
integer masses. The checked-in Python recursive version references `Mass`
instead of its `Data` argument when building the result list, so that
alternative is not self-contained as written. Part 1 in R omits the
nonnegative clamp used in Python; for small masses this can produce negative
R fuel values. Examples: [2019 Day 01 R](./2019/AoC_2019_01/AoC_2019_01_Code_R.R)
and [2019 Day 01 Python](./2019/AoC_2019_01/AoC_2019_01_Code_Py.py).

## Source files analysed

All complete canonical pairs currently available in the local project were
read for this run. The extension casing shown below matches the actual
filenames.

| Year | Day | R file | Python file |
|---:|---:|---|---|
| 2015 | 01 | `AoC_2015_01_Code_R.R` | `AoC_2015_01_Code_Py.Py` |
| 2016 | 01 | `AoC_2016_01_Code_R.R` | `AoC_2016_01_Code_Py.py` |
| 2017 | 01 | `AoC_2017_01_Code_R.R` | `AoC_2017_01_Code_Py.py` |
| 2018 | 01 | `AoC_2018_01_Code_R.R` | `AoC_2018_01_Code_Py.py` |
| 2019 | 01 | `AoC_2019_01_Code_R.R` | `AoC_2019_01_Code_Py.py` |
| 2020 | 01 | `AoC_2020_01_Code_R.R` | `AoC_2020_01_Code_Py.py` |
| 2022 | 01 | `AoC_2022_01_Code_R.R` | `AoC_2022_01_Code_Py.py` |
| 2023 | 01 | `AoC_2023_01_Code_R.R` | `AoC_2023_01_Code_Py.py` |
| 2024 | 01 | `AoC_2024_01_Code_R.R` | `AoC_2024_01_Code_Py.py` |

### Incomplete solution pairs

None among the local files matching the canonical `AoC_<Year>_<Day>_Code_R`
and `AoC_<Year>_<Day>_Code_Py` naming convention.
