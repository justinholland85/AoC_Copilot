# Justin's R Style Guide

This guide distils patterns found in the local Advent of Code R scripts. It is
an evidence-based reference, not a claim that every existing implementation is
an ideal template. Each topic separates what the code does, what that may
suggest, and how an agent should apply the evidence.

## Naming conventions: Upper Camel Case, periods, and underscores

**Observed practice.** Across the nine scripts, assigned object names generally
begin with a capital letter and use Upper Camel Case within name components:
`FirstBasement`, `VectorMap`, `BunnyAt`, `Sum.Top3`, and
`F.Recursive.FuelForMass`.
Periods are frequent in compound names. Examples include:

- `Elf.Calories` and `Elf.ID` in
  [AoC_2022_01_Code_R.R](2022/AoC_2022_01/AoC_2022_01_Code_R.R), where the
  prefix identifies the group and the suffix names its attribute or key.
- `CalibVal.Sum` and `Fuel.Tot` in
  [AoC_2023_01_Code_R.R](2023/AoC_2023_01/AoC_2023_01_Code_R.R) and
  [AoC_2019_01_Code_R.R](2019/AoC_2019_01/AoC_2019_01_Code_R.R), labeling
  aggregate/result variants.
- `Name.Data.1`, `Data.0a`, `Answer.p1`, and `F.Part.2.v1` in
  [AoC_2015_01_Code_R.R](2015/AoC_2015_01/AoC_2015_01_Code_R.R) and
  [AoC_2018_01_Code_R.R](2018/AoC_2018_01/AoC_2018_01_Code_R.R), where
  periods separate role labels, input/part identifiers, or version suffixes.
- `X.0` and `X.1` in
  [AoC_2017_01_Code_R.R](2017/AoC_2017_01/AoC_2017_01_Code_R.R), distinguishing
  aligned versions of the same vector.

An inventory of assigned identifiers found 97 unique names: 37 contain one or
more periods, none contain underscores, and 60 contain neither separator.
This is a corpus-specific count of assigned names, not a count of every
parameter or token in comments. Underscores are present in file names and
file-name strings, such as `AoC_2024_01_Code_R.R` and
`"_Input_1.txt"`, but those are file naming conventions rather than R object
identifiers.

The assigned-name inventory has two lowercase-leading exceptions, `i` and
`i.Mass`, both in
[AoC_2019_01_Code_R.R](2019/AoC_2019_01/AoC_2019_01_Code_R.R); `x` is also a
lowercase formal parameter of `F.Recursive.FuelForMass()`. Acronyms and short
labels such as `DF`, `N`, `X`, and the `p1` suffix in `Answer.p1` also appear.

**Inferred preference.** The scripts support Upper Camel Case as the general
object-name preference, while periods appear to divide meaningful name
segments and qualifiers. The uses of periods are varied—conceptual
components, part numbers, data indices, and versions—so they do not define a
strict grammar. Since no assigned object identifier uses `_`, this corpus
cannot establish an underscore-based object naming rule or a direct separator
contrast. The underscore pattern in file paths should not be generalized to
R objects.

**Instruction for the coding agent.** Prefer Upper Camel Case object names,
for example `FirstBasement` or `ElfCalories`. Where the surrounding code
already uses dotted names, use `.` to separate clear semantic components or
qualifiers, as in `Elf.Calories` or `F.Part.2.v1`; choose separators to make
the name easier to scan, not to encode an invented fixed hierarchy. There is
no object-name evidence for `_`; follow a host project's established
convention if one exists rather than claiming underscores are part of this
observed R style. Lowercase short loop variables or arguments are exceptions,
not the dominant pattern.

## 1. Solution functions and named stages

**Observed practice.** All nine scripts define separate `F.Part.1` and
`F.Part.2` functions that accept `Data`, then call them on the input. Their
calculations commonly use intermediate objects with role-revealing names:
`Split`, `Value`, `Position`, and `FirstBasement` in
[AoC_2015_01_Code_R.R](2015/AoC_2015_01/AoC_2015_01_Code_R.R);
`Mass`, `Fuel`, and `Fuel.Tot` in
[AoC_2019_01_Code_R.R](2019/AoC_2019_01/AoC_2019_01_Code_R.R);
`Elf.ID`, `Elf.Calories`, and `Sum.Top3` in
[AoC_2022_01_Code_R.R](2022/AoC_2022_01/AoC_2022_01_Code_R.R). The functions
usually finish with an explicit `return(...)`.

**Inferred preference.** The repeated part-specific functions and staged
calculations across the collection (9/9 scripts) support a preference for
separating puzzle work into named units and making transformations visible.
The exact naming punctuation and explicit `return()` are common habits here,
but the evidence does not establish them as mandatory conventions.

**Instruction for the coding agent.** For multi-part problems, write a
separate function for each independently testable part. Name intermediate
values after their role in the algorithm; retain separate stages when they
clarify parsing, transformation, aggregation, or answer selection. Use an
explicit `return()` when it improves clarity, but do not add variables or
returns that merely restate an obvious expression.

## 2. Base-R transformations and vectorized calculations

**Observed practice.** Several solutions express elementwise work and
reductions as operations on whole vectors:

- [AoC_2015_01_Code_R.R](2015/AoC_2015_01/AoC_2015_01_Code_R.R) maps
  characters to values with a named vector, `CharVal[Split]`, and reduces them
  with `sum()`. Part 2 uses `cumsum()` and `which()` to locate the first
  position at floor -1.
- [AoC_2017_01_Code_R.R](2017/AoC_2017_01/AoC_2017_01_Code_R.R) makes a
  circular next-digit vector with `c(Split[-1], Split[1])`, compares the two
  vectors, and sums matching digit values. For the halfway comparison it
  splits at `N / 2`, compares the two halves, and doubles the sum because each
  match represents both corresponding positions.
- [AoC_2019_01_Code_R.R](2019/AoC_2019_01/AoC_2019_01_Code_R.R) calculates
  `floor(Mass / 3) - 2` for every mass before summing the fuel.
- [AoC_2024_01_Code_R.R](2024/AoC_2024_01/AoC_2024_01_Code_R.R) sorts both
  columns, calculates `abs(X1 - X2)`, then sums the distances.

**Inferred preference.** These independent examples in four solutions suggest
that direct vector operations are a familiar and preferred way to express
elementwise calculations and reductions when the problem permits them.
However, [AoC_2016_01_Code_R.R](2016/AoC_2016_01/AoC_2016_01_Code_R.R) uses a
coordinate lookup matrix and `apply()` for path positions, so no one vector
idiom is universal.

**Instruction for the coding agent.** Use ordinary R vector operations such
as arithmetic, comparisons, `cumsum()`, `sum()`, `abs()`, and indexing for
independent elementwise work. Keep vector lengths and alignment explicit,
especially for circular comparisons or paired data. Prefer a matrix or
iteration when that better represents the problem instead of forcing a
vectorized expression.

## 3. Parsing and transforming input

**Observed practice.** Parsing is performed inside or near the solution
functions and is made explicit before calculation. The techniques vary with
the input:

- [AoC_2016_01_Code_R.R](2016/AoC_2016_01/AoC_2016_01_Code_R.R) splits the
  single comma-separated instruction string, trims whitespace, extracts turns
  and step counts with `substr()`, and converts counts with `as.numeric()`.
- [AoC_2017_01_Code_R.R](2017/AoC_2017_01/AoC_2017_01_Code_R.R) splits a
  digit string into characters and converts them to numeric values.
- [AoC_2023_01_Code_R.R](2023/AoC_2023_01/AoC_2023_01_Code_R.R) transforms
  each line of text, splits it into characters, derives lengths, and combines
  selected first/last digits into calibration values.
- [AoC_2024_01_Code_R.R](2024/AoC_2024_01/AoC_2024_01_Code_R.R) splits
  records on the input's repeated-space delimiter, binds the results into
  columns, then converts each column to numeric.

**Inferred preference.** The examples show adaptation to the data's actual
shape rather than reliance on one universal parser. Explicit conversion and
intermediate parsed objects recur, but the collection does not establish a
single preferred parsing function.

**Instruction for the coding agent.** Choose parsing operations that match
the documented input format. Make delimiter handling, trimming, character
extraction, and numeric conversion visible enough to review. Do not assume
that whitespace, row lengths, or the number of fields are uniform unless the
input or problem guarantees it.

## 4. Lookup, matching, grouping, and counting

**Observed practice.** Several scripts use base-R lookup or aggregation
operations rather than manually scanning each item:

- [AoC_2015_01_Code_R.R](2015/AoC_2015_01/AoC_2015_01_Code_R.R) indexes the
  named lookup vector `CharVal` by each input character.
- [AoC_2020_01_Code_R.R](2020/AoC_2020_01/AoC_2020_01_Code_R.R) calculates
  complements (`Delta <- Year - X`) and tests membership with `%in%`. Part 2
  builds a two-column candidate grid with `expand.grid()`, computes row sums,
  and filters candidates by membership.
- [AoC_2022_01_Code_R.R](2022/AoC_2022_01/AoC_2022_01_Code_R.R) treats blank
  lines as `NA`, creates group IDs with `cumsum(is.na(Calories))`, and
  aggregates values using `tapply()`. It then uses `max()` or descending
  `sort()` to select totals.
- [AoC_2024_01_Code_R.R](2024/AoC_2024_01/AoC_2024_01_Code_R.R) counts the
  right-column values with `table()`, uses `match()` to look up counts for
  left-column values, then multiplies and sums.

**Inferred preference.** These examples (four different years) show comfort
with direct indexing, membership, matching, and base-R grouping primitives.
The chosen operation depends on the task: a lookup table for character
translation, `%in%` for complement membership, `tapply()` for group totals,
and `table()` plus `match()` for frequencies.

**Instruction for the coding agent.** Use named-vector indexing for a
small fixed mapping, `%in%` for set membership, `match()` for position
lookups, and `table()` or `tapply()` for counts and grouped summaries when
their semantics fit. Check unmatched lookups and missing values explicitly;
for example, `match()` can return `NA`, and a frequency table's names are
character strings.

## 5. Explicit iteration and state

**Observed practice.** Iteration appears when the answer depends on evolving
state, repetition, or stopping:

- In [AoC_2016_01_Code_R.R](2016/AoC_2016_01/AoC_2016_01_Code_R.R), Part 1
  converts turns into directions with `cumsum(Turn) %% 4` and computes the
  endpoint. Part 2 instead expands each instruction into unit moves using
  `rep(Vectors, Steps)`, includes the origin, calculates every position, and
  calls `Lib.GroupOn()` / `Lib.SeqOn()` to find the first repeated location.
- [AoC_2018_01_Code_R.R](2018/AoC_2018_01/AoC_2018_01_Code_R.R) has several
  versions of the repeated-frequency search: an initial `while` loop appends
  another change-list and recomputes cumulative sums; `F.Part.2.v1` checks
  each new frequency against stored history; `v2` precomputes one cycle's
  cumulative changes and applies them as a batch; `v3` stores batches in a
  list.
- [AoC_2019_01_Code_R.R](2019/AoC_2019_01/AoC_2019_01_Code_R.R) repeatedly
  calculates fuel for the previous fuel amount with `repeat` and `break`.
  It also preserves a recursive alternative using an inner
  `F.Recursive.FuelForMass()` helper and `sapply()`.

**Inferred preference.** The examples distinguish naturally vectorizable
work from stateful work, but they also show experimentation rather than one
settled loop style. The 2018 variants explicitly compare approaches, while
the 2016 path problem represents every visited coordinate because the
question asks for the first location visited twice.

**Instruction for the coding agent.** Use vectorized calculations for
independent values; use a loop when the next state or termination condition
depends on prior work. For stateful algorithms, identify the state, update,
and stopping test explicitly. Avoid rebuilding accumulated history or
recomputing invariant work in a loop when the workload makes that cost
material.

## 6. Data structures and assumptions

**Observed practice.** Data structures vary with the intermediate result:

- [AoC_2016_01_Code_R.R](2016/AoC_2016_01/AoC_2016_01_Code_R.R) constructs a
  four-row, two-column `VectorMap` for cardinal directions, indexes rows by
  direction, and scales the resulting vectors by step counts. Its Part 2
  binds unit moves into a matrix and wraps cumulative coordinates in a
  data frame.
- [AoC_2019_01_Code_R.R](2019/AoC_2019_01/AoC_2019_01_Code_R.R) saves each
  round of fuel values as an element of a list, then uses `unlist()` and
  `sum()` for the total.
- [AoC_2020_01_Code_R.R](2020/AoC_2020_01/AoC_2020_01_Code_R.R) uses
  `expand.grid()` for candidate pairs and applies `unique()` to candidate
  values. A comment records the assumption that the three selected numbers
  must be distinct.
- [AoC_2023_01_Code_R.R](2023/AoC_2023_01/AoC_2023_01_Code_R.R) uses lists
  of per-line digit characters and combines `lapply()` with `mapply()` to
  select first and last characters.

**Inferred preference.** These are useful examples of choosing vectors,
matrices, lists, and data frames for different tasks, not evidence of a
general preference for one structure. The 2020 comment is a problem-specific
correctness assumption, not a general guarantee that duplicate candidates
can be ignored.

**Instruction for the coding agent.** Choose the simplest structure that
represents the data and operations clearly. Document assumptions that affect
which values are selected. Validate them if the function must work beyond the
specific puzzle input. Do not copy a matrix, list, or Cartesian product
pattern without checking whether its dimensions and semantics fit the new
problem.

## 7. Missing values, boundaries, and assumptions

**Observed practice.** The scripts handle exceptional values in ways tied to
their input semantics:

- [AoC_2022_01_Code_R.R](2022/AoC_2022_01/AoC_2022_01_Code_R.R) parses blank
  separators as `NA`, uses `is.na()` to increment group IDs, and passes the
  values to `Lib.NA.To.Zero()` for aggregation. Here a blank marks a boundary,
  while its numeric contribution is treated as zero.
- [AoC_2019_01_Code_R.R](2019/AoC_2019_01/AoC_2019_01_Code_R.R) uses
  `pmax(floor(i.Mass / 3) - 2, 0)` to ensure recursively calculated fuel
  requirements do not become negative.
- [AoC_2017_01_Code_R.R](2017/AoC_2017_01/AoC_2017_01_Code_R.R) indexes
  halfway through the digit vector using `N / 2`; the instructions specify
  that the list has an even number of elements.
- [AoC_2020_01_Code_R.R](2020/AoC_2020_01/AoC_2020_01_Code_R.R) comments
  that its product calculation relies on the three selected numbers being
  distinct, then uses `unique()` on candidate values.

**Inferred preference.** The examples show that the author makes some
problem-specific boundaries and assumptions explicit, but do not show
consistent general-purpose input validation. The 2022 and 2019 cases also
distinguish missing separator values from values that should contribute to a
sum.

**Instruction for the coding agent.** Preserve the semantic role of missing
values and boundaries instead of replacing all `NA`s indiscriminately. Use
problem guarantees when they are explicit; otherwise check assumptions that
affect indexing, duplicate handling, or termination. Prefer a clear,
intentional failure over an invalid index or silently plausible result.

## 8. String replacement and overlap handling

**Observed practice.** [AoC_2023_01_Code_R.R](2023/AoC_2023_01/AoC_2023_01_Code_R.R)
handles part 1 by repeatedly removing letters with 26 calls through a `for`
loop and `gsub()`. For part 2 it builds replacement strings from each number
word's first letter, digit, and last letter using `substr()` and `paste0()`,
then applies nine `gsub()` replacements before reusing `F.Part.1()`. Retaining
the word's boundary letters is visible in the code and permits adjacent or
overlapping spelled-out digits to remain detectable.

**Inferred preference.** This is a distinctive, problem-specific string
transformation, not a repeated general convention. Reusing `F.Part.1()` does
provide one concrete example of factoring shared work between parts.

**Instruction for the coding agent.** When replacing tokens that can overlap,
check whether plain replacement destroys the start or end of a neighboring
token. Preserve the necessary context or use a matching approach that
recognizes overlaps. Reuse a part-one helper for part two only when its input
and output semantics still match.

## 9. Input scale and performance evidence

**Observed practice.** The inspected inputs have materially different shapes:
7,000 characters in [AoC_2015_01_Input_1.txt](2015/AoC_2015_01/AoC_2015_01_Input_1.txt);
151 comma-separated instructions in
[AoC_2016_01_Input_1.txt](2016/AoC_2016_01/AoC_2016_01_Input_1.txt);
2,040 digits in [AoC_2017_01_Input_1.txt](2017/AoC_2017_01/AoC_2017_01_Input_1.txt);
1,029 frequency changes in
[AoC_2018_01_Input_1.txt](2018/AoC_2018_01/AoC_2018_01_Input_1.txt);
100 masses in [AoC_2019_01_Input_1.txt](2019/AoC_2019_01/AoC_2019_01_Input_1.txt);
200 expense entries in [AoC_2020_01_Input_1.txt](2020/AoC_2020_01/AoC_2020_01_Input_1.txt);
249 blank-line-separated groups in
[AoC_2022_01_Input_1.txt](2022/AoC_2022_01/AoC_2022_01_Input_1.txt);
1,000 calibration lines in
[AoC_2023_01_Input_1.txt](2023/AoC_2023_01/AoC_2023_01_Input_1.txt);
and 1,000 pairs in
[AoC_2024_01_Input_1.txt](2024/AoC_2024_01/AoC_2024_01_Input_1.txt).

The 2020 part-two `expand.grid()` therefore creates 40,000 candidate pairs
from its 200 entries. In 2018 the script includes timings and versions of the
repeated-frequency algorithm; its embedded note reports approximately
5 seconds for v0, 28 seconds for v1, and 0.2 seconds for v2 on the recorded
test, and benchmarks a repeated input with `rep(Data.1, 10000)`. These are
recorded script results, not independently reproduced benchmarks.
In 2019 the script likewise times its fuel algorithm on the input and on a
10,000-fold repeated input.

**Inferred preference.** The 2018 script is direct evidence of interest in
how algorithm choice and repeated work affect performance. It also records
multiple alternatives rather than replacing them all with the most
complicated version. Other puzzles use simple vectorized solutions at their
observed input sizes. This supports a cautious inference that understandable
solutions are acceptable when their workload is modest, but it does not prove
that performance is never a priority.

**Instruction for the coding agent.** Estimate both input size and work per
item. Keep a direct method when it is clear and comfortably adequate; choose
a more efficient algorithm when repeated scans, history growth, or
combinatorial intermediates make the workload significant. Benchmark
representative equivalent work when the result is uncertain, and label
measurements as machine- and run-dependent rather than treating old timings
as guarantees.

## 10. Project scaffolding: observed, not a style requirement

**Observed practice.** The scripts share a project-specific header, source
`C:/Users/justi/OneDrive/Documents/GitHub/RLibrary/Start.R`, define `Root`,
`Year`, and `Day`, build a puzzle directory using `Lib.LeadingZeros()`, call
`setwd()`, and read files with `readLines()`. Several use `Data.0` example
files as well as `Data.1`; some end with answer and timing metadata.

**Inferred preference.** These repeated details show the execution environment
of this solution collection. Because they rely on a personal library and
absolute paths, they do not establish that new standalone R code should use
the same scaffolding.

**Instruction for the coding agent.** Follow the host project's actual input,
package, and execution conventions. Do not copy the hard-coded personal
paths, `setwd()` calls, or `RLibrary` dependency into a new project unless
they are explicitly required and available there.

## Source material analysed

Discovery found nine canonical R scripts. All nine were read in full; all nine
corresponding local instructions were read; all nine `Input_1` files were
inspected for structure and scale. No Python solution was used as evidence.
The table marks what was read or inspected, rather than only what was found:

| Year | Day | R solution read | Instructions read | Input inspected |
|---|---:|---|---|---|
| 2015 | 01 | [AoC_2015_01_Code_R.R](2015/AoC_2015_01/AoC_2015_01_Code_R.R) | [AoC_2015_01_Instructions.txt](2015/AoC_2015_01/AoC_2015_01_Instructions.txt) | [AoC_2015_01_Input_1.txt](2015/AoC_2015_01/AoC_2015_01_Input_1.txt) |
| 2016 | 01 | [AoC_2016_01_Code_R.R](2016/AoC_2016_01/AoC_2016_01_Code_R.R) | [AoC_2016_01_Instructions.txt](2016/AoC_2016_01/AoC_2016_01_Instructions.txt) | [AoC_2016_01_Input_1.txt](2016/AoC_2016_01/AoC_2016_01_Input_1.txt) |
| 2017 | 01 | [AoC_2017_01_Code_R.R](2017/AoC_2017_01/AoC_2017_01_Code_R.R) | [AoC_2017_01_Instructions.txt](2017/AoC_2017_01/AoC_2017_01_Instructions.txt) | [AoC_2017_01_Input_1.txt](2017/AoC_2017_01/AoC_2017_01_Input_1.txt) |
| 2018 | 01 | [AoC_2018_01_Code_R.R](2018/AoC_2018_01/AoC_2018_01_Code_R.R) | [AoC_2018_01_Instructions.txt](2018/AoC_2018_01/AoC_2018_01_Instructions.txt) | [AoC_2018_01_Input_1.txt](2018/AoC_2018_01/AoC_2018_01_Input_1.txt) |
| 2019 | 01 | [AoC_2019_01_Code_R.R](2019/AoC_2019_01/AoC_2019_01_Code_R.R) | [AoC_2019_01_Instructions.txt](2019/AoC_2019_01/AoC_2019_01_Instructions.txt) | [AoC_2019_01_Input_1.txt](2019/AoC_2019_01/AoC_2019_01_Input_1.txt) |
| 2020 | 01 | [AoC_2020_01_Code_R.R](2020/AoC_2020_01/AoC_2020_01_Code_R.R) | [AoC_2020_01_Instructions.txt](2020/AoC_2020_01/AoC_2020_01_Instructions.txt) | [AoC_2020_01_Input_1.txt](2020/AoC_2020_01/AoC_2020_01_Input_1.txt) |
| 2022 | 01 | [AoC_2022_01_Code_R.R](2022/AoC_2022_01/AoC_2022_01_Code_R.R) | [AoC_2022_01_Instructions.txt](2022/AoC_2022_01/AoC_2022_01_Instructions.txt) | [AoC_2022_01_Input_1.txt](2022/AoC_2022_01/AoC_2022_01_Input_1.txt) |
| 2023 | 01 | [AoC_2023_01_Code_R.R](2023/AoC_2023_01/AoC_2023_01_Code_R.R) | [AoC_2023_01_Instructions.txt](2023/AoC_2023_01/AoC_2023_01_Instructions.txt) | [AoC_2023_01_Input_1.txt](2023/AoC_2023_01/AoC_2023_01_Input_1.txt) |
| 2024 | 01 | [AoC_2024_01_Code_R.R](2024/AoC_2024_01/AoC_2024_01_Code_R.R) | [AoC_2024_01_Instructions.txt](2024/AoC_2024_01/AoC_2024_01_Instructions.txt) | [AoC_2024_01_Input_1.txt](2024/AoC_2024_01/AoC_2024_01_Input_1.txt) |
