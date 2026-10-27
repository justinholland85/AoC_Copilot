# R–Python Techniques from Advent of Code Solutions

This is a practical lookup from expressions in Justin's local R solutions to
the corresponding code in his paired Python solutions. Code labelled
**Existing R code** or **Existing Python translation** is taken from the
listed source; **Recommended equivalent** and **Illustrative adaptation**
identify newly written examples.

Python examples using `np` or `pd` assume the source file's NumPy or pandas
imports (respectively); snippets focus on the expression being translated.

## Quick index: find the R expression

| R expression | Look under |
|---|---|
| `strsplit()`, `trimws()`, `substr()`, `nchar()` | [Split and inspect strings](#strsplit-trimws-substr-and-nchar-split-and-inspect-strings) |
| `paste0()`, `seq()`, `gsub()` | [Build replacement strings; preserve overlaps](#paste0-seq-and-gsub-build-replacement-strings-and-preserve-overlaps) |
| `as.numeric()`, `as.character()` | [Convert values](#asnumeric-convert-values) |
| `cumsum()`, `which()` | [Cumulative values and positions](#named-vector-lookup-cumsum-and-which-map-characters-and-find-a-position) |
| `c(x[-1], x[1])`, logical masks | [Circular vector indexing](#circular-vector-indexing-and-logical-masks-cx-1-x1) |
| `ifelse()`, `cumsum() %%`, matrix row lookup | [Turn and direction lookup](#ifelse-cumsum-and-matrix-row-lookup-turn-and-direction-lookup) |
| `strsplit()`, `lapply()`, `unlist()`, `as.numeric()` | [Parse and assemble tabular data](#strsplit-lapply-unlist-docall-rbind-and-dataframe-parse-and-assemble-tabular-data) |
| `do.call()`, `rbind()`, `data.frame()` | [Parse and assemble tabular data](#strsplit-lapply-unlist-docall-rbind-and-dataframe-parse-and-assemble-tabular-data) |
| `pmin()`, `pmax()`, `apply()`, `rowSums()` | [Row-wise calculations](#pmin-pmax-apply-and-rowsums-row-wise-calculations) |
| `apply()`, `Lib.RowsToList()`, `rep()` | [Matrix moves and repeated steps](#docall-apply-and-rep-matrix-moves-and-cumulative-positions) |
| `table()`, `match()`, `Lib.NumericNames()` | [Frequency lookup](#table-match-and-libnumericnames-frequency-lookup) |
| `tapply()`, nested `table()` | [Group and frequency summaries](#tapply-and-nested-table-group-and-frequency-summaries) |
| `cbind()`, lag vectors, `rowSums()` | [Lagged values and rolling windows](#cbind-and-lag-vectors-rolling-window-sums) |
| `Lib.GroupOn()`, `Lib.SeqOn()` | [Find a repeated location](#libgroupon-and-libseqon-find-a-repeated-location) |
| `%in%`, `which()`, `prod()` | [Membership and candidate selection](#which-with-in-return-positions-of-matching-elements) |
| `unique()` | [Remove duplicate values](#unique-remove-duplicates-without-assuming-values-represent-positions) |
| `sort()`, `abs()`, `sum()` | [Sort, pair, and reduce](#sort-abs-and-sum-sort-pair-and-reduce) |
| `diff()`, `sign()`, `seq()`, `Report[-i]` | [Adjacent differences and deletion checks](#diff-sign-and-negative-indexing-adjacent-tests-and-deletion-checks) |
| `NA`, `is.na()`, `Lib.NA.To.Zero()` | [Missing values and group boundaries](#na-isna-and-libnatozero-missing-values-as-group-boundaries) |
| `repeat`, `while`, `break`, `rep()`, `unlist()`, `sapply()` | [Loops, state, and repeated work](#repeat-while-break-rep-and-unlist-loops-state-and-repeated-work) |
| `sapply()` and recursive functions | [Recursive scalar calculations](#sapply-and-recursive-functions-map-a-scalar-calculation) |
| `expand.grid()`, `rowSums()` | [Cartesian candidate grids](#expandgrid-and-rowsums-cartesian-candidate-grids) |
| `mapply()`, `expand.grid()`, logical character indexing | [Compare IDs by character position](#expandgrid-mapply-and-logical-character-indexing-compare-ids) |
| `for`, positional writes, opcode lookup | [A small mutable virtual machine](#for-loops-and-positional-writes-a-small-mutable-virtual-machine) |
| `do.call(paste0, ...)`, `nchar()` | [Generate repeated digit patterns](#docallpaste0-and-nchar-generate-repeated-digit-patterns) |
| `match()`, `%%`, `ifelse()` | [Code lookups and modular scoring](#match-modulo-and-ifelse-code-lookups-and-modular-scoring) |
| `Report[-i]`, `mapply()`, `strsplit()` | [Position policies](#strsplit-and-indexed-character-lookup-parse-position-policies) |
| `function()`, `return()` | [Functions and solution structure](#function-and-return-functions-and-solution-structure) |

## Input parsing and string operations

### `strsplit()`, `trimws()`, `substr()` and `nchar()`: split and inspect strings

**Existing R code** — [2016 Day 01, `AoC_2016_01_Code_R.R`](./2016/AoC_2016_01/AoC_2016_01_Code_R.R):

```r
Split <- trimws(strsplit(Data, ",")[[1]])
Turn  <- substr(Split, 1, 1)
Steps <- as.numeric(substr(Split, 2, nchar(Split)))
```

**Existing Python translation** — [2016 Day 01, `AoC_2016_01_Code_Py.py`](./2016/AoC_2016_01/AoC_2016_01_Code_Py.py):

```python
Split = [x.strip() for x in Data.split(",")]
Turn  = [x[0] for x in Split]
Steps = [int(x[1:]) for x in Split]
```

`strsplit(...)[[1]]` extracts the first list element from R's list result.
Python's `str.split()` directly returns a list. `trimws()` and `.strip()`
remove surrounding whitespace. R substring positions start at 1 and its end is
inclusive; Python slices start at 0 and exclude the end. R's `substr(Split,
2, nchar(Split))` therefore corresponds to Python `x[1:]`.

**Existing R code** — [2017 Day 01, `AoC_2017_01_Code_R.R`](./2017/AoC_2017_01/AoC_2017_01_Code_R.R):

```r
Split <- as.numeric(strsplit(Data, "")[[1]])
```

**Existing Python translation** — [2017 Day 01, `AoC_2017_01_Code_Py.py`](./2017/AoC_2017_01/AoC_2017_01_Code_Py.py):

```python
Split = np.array(list(Data)).astype(int)
```

The empty delimiter splits the text into characters in R; `list(Data)` does
the same for a Python string. Both examples then explicitly convert the digit
characters to numbers. For Python without NumPy, use
`[int(char) for char in Data]`.

### `paste0()`, `seq()` and `gsub()`: build replacement strings and preserve overlaps

**Existing R code** — [2023 Day 01 Part 2, `AoC_2023_01_Code_R.R`](./2023/AoC_2023_01/AoC_2023_01_Code_R.R):

```r
Numbers <- c("one", "two", "three", "four", "five",
             "six", "seven", "eight", "nine")
Nchar   <- nchar(Numbers)
Sub     <- paste0(substr(Numbers, 1, 1), seq(1, 9),
                  substr(Numbers, Nchar, Nchar))

for (i in 1:9) {
  X <- gsub(pattern = Numbers[i], replacement = Sub[i], x = X)
}
```

Replacing `eight` with `e8t` preserves its outer letters, allowing a following
replacement to detect overlaps such as `oneight`.

**Existing Python translation** — [2023 Day 01, `AoC_2023_01_Code_Py.py`](./2023/AoC_2023_01/AoC_2023_01_Code_Py.py):

```python
First_Letter = [x[0] for x in Numbers]
Last_Letter  = [x[-1] for x in Numbers]
Sub = np.array([
    f"{First}{N}{Last}"
    for First, N, Last in zip(First_Letter, range(1, 10), Last_Letter)
])

X = np.asarray(Data, dtype=str).copy()
for Number, Replacement in zip(Numbers, Sub):
    X = np.char.replace(X, Number, Replacement)

CalibVal_Sum = F_Part_1(X)
```

The Python implementation now uses NumPy's literal `np.char.replace()` over
the same boundary-letter substitutions. Both preserve overlaps such as
`oneight` by retaining the first and last letters when replacing `eight`.
The `.copy()` prevents edits from being made to a caller-owned array. R
`gsub()` interprets patterns as regular expressions by default; here the
fixed digit words contain no regex metacharacters, so the replacements act
literally.

### `gsub()`, `strsplit()`, `lapply()`, `mapply()` and `paste0()`: remove letters and select end digits

**Existing R code** — [2023 Day 01 Part 1, `AoC_2023_01_Code_R.R`](./2023/AoC_2023_01/AoC_2023_01_Code_R.R):

```r
Numbers <- Data
for (i in 1:26) {
  Numbers <- gsub(letters[i], replacement = "", x = Numbers)
}
Numbers <- strsplit(Numbers, "")
Count   <- lapply(Numbers, length)
First   <- unlist(lapply(Numbers, Lib.Take.Which, 1))
Last    <- mapply(Lib.Take.Which, Numbers, Count)
CalibVal <- as.numeric(paste0(First, Last))
```

**Existing Python translation** — [2023 Day 01, `AoC_2023_01_Code_Py.py`](./2023/AoC_2023_01/AoC_2023_01_Code_Py.py):

```python
Numbers = pd.Series(Data).str.replace(r"[a-z]", "", regex=True)
Numbers = Numbers.apply(list)
First   = [x[0] for x in Numbers]
Last    = [x[-1] for x in Numbers]
CalibVal = np.array([int(f + l) for f, l in zip(First, Last)])
```

Python uses a single regular expression for the 26 lowercase-letter
replacements. R's `lapply()` applies a function to each list element;
`mapply()` supplies corresponding elements from multiple inputs. Python's
list comprehensions and `zip()` perform those selections. R's
`Lib.Take.Which(A, B)` is just `A[B]`: in this example the first/last elements
are selected using R's 1-based indices. Python uses `[0]` and `[-1]`.

For literal concatenation, `paste0(First, Last)` is similar to Python
`f + l` when both values are strings. `as.numeric()` then parses the combined
digits; Python uses `int()`.

### `strsplit()` and indexed character lookup: parse position policies

**Existing R code** — [2020 Day 02, `AoC_2020_02_Code_R.R`](./2020/AoC_2020_02/AoC_2020_02_Code_R.R):

```r
Split    <- strsplit(Data, " ")
Positions <- unlist(lapply(Split, Lib.Take.One, 1))
Positions <- do.call(rbind, lapply(strsplit(Positions, "-"), as.numeric))
Letter   <- gsub(":", "", unlist(lapply(Split, Lib.Take.One, 2)))
Password <- strsplit(unlist(lapply(Split, Lib.Take.One, 3)), "")

Pos.A <- mapply(Lib.Take.A.From.B, as.list(Positions[, 1]), Password)
Pos.B <- mapply(Lib.Take.A.From.B, as.list(Positions[, 2]), Password)
Valid <- ((Pos.A == Letter) + (Pos.B == Letter)) == 1
```

**Existing Python translation** — [2020 Day 02, `AoC_2020_02_Code_Py.py`](./2020/AoC_2020_02/AoC_2020_02_Code_Py.py):

```python
Split     = [x.split(" ") for x in Data]
Positions = [x[0].split("-") for x in Split]
Positions = pd.DataFrame(Positions, columns=["A", "B"]).astype(int)
Letter    = [x[1].replace(":", "") for x in Split]
Password  = [list(x[2]) for x in Split]

Pos_A = [A[P] for A, P in zip(Password, Positions["A"] - 1)]
Pos_B = [B[P] for B, P in zip(Password, Positions["B"] - 1)]
Valid = [((A == L) + (B == L)) == 1
         for A, B, L in zip(Pos_A, Pos_B, Letter)]
```

Both split each policy line into fields, split the numeric range again, and
turn the password into characters. `Lib.Take.A.From.B()` selects a
one-based character position; Python subtracts one before indexing. The
Part 2 rule is exclusive OR: exactly one selected position must equal the
policy letter. Python `^` between booleans is another direct XOR expression.

The existing Python Part 2 is not runnable as written: it evaluates
`Count = [sum(x) for x in Match]`, but `Match` is undefined there. The
`Count` result is unused and can be removed; the shown `Valid` comprehension
then implements the position test. Use `line.split()` rather than
`line.split(" ")` if inputs may contain repeated whitespace.

## Conversion and data structures

### `as.numeric()`: convert values

**Existing R code** — [2018 Day 01, `AoC_2018_01_Code_R.R`](./2018/AoC_2018_01/AoC_2018_01_Code_R.R):

```r
Delta <- as.numeric(Data)
Freq  <- sum(Delta)
```

**Existing Python translations** — [2018 Day 01](./2018/AoC_2018_01/AoC_2018_01_Code_Py.py) and [2017 Day 01](./2017/AoC_2017_01/AoC_2017_01_Code_Py.py); input conversion differs by data source:

```python
# 2018: read the numeric text file directly into an integer array
Data_1 = np.loadtxt(Name_Data_1, dtype=int)

# 2017: convert digit characters after splitting
Split = np.array(list(Data)).astype(int)
```

`as.numeric()` converts a character vector to numeric values. Python's
`int()` converts one value; NumPy's `.astype(int)` converts an array. For
line-oriented numeric text, `np.loadtxt(..., dtype=int)` combines reading and
conversion. R's failed numeric conversions become `NA`; Python's `int()` raises
an error, while NumPy/pandas have their own missing-value handling.

`as.character()` is not used in the analysed R solution expressions, so it
has no demonstrated mapping here. Python's `str(value)` is the usual scalar
conversion, but it is not a translation observed in these pairs.

### `strsplit()`, `lapply()`, `unlist()`, `do.call()`, `rbind()` and `data.frame()`: parse and assemble tabular data

**Existing R code** — [2024 Day 01, `AoC_2024_01_Code_R.R`](./2024/AoC_2024_01/AoC_2024_01_Code_R.R):

```r
DF <- data.frame(do.call(rbind, strsplit(Data, "  ")))
DF <- lapply(DF, as.numeric)
```

**Existing Python translation** — [2024 Day 01, `AoC_2024_01_Code_Py.py`](./2024/AoC_2024_01/AoC_2024_01_Code_Py.py):

```python
DF = pd.DataFrame([x.split("  ") for x in Data], columns=["X1", "X2"])
DF = DF.apply(pd.to_numeric)
```

R `strsplit()` returns a list of split rows; `do.call(rbind, ...)` passes
those rows as arguments to `rbind()` to bind them into a matrix-like object.
`data.frame()` gives the result named columns (`X1`, `X2` here), and
`lapply(..., as.numeric)` converts each column. The Python list comprehension
builds rows directly, `DataFrame` assembles the table, and `.apply()` converts
its columns.

Both examples split on exactly two spaces. Replacing that delimiter with
generic whitespace splitting may alter the parsing rules for other inputs.
The code assumes every row yields exactly two fields.

### `pmin()`, `pmax()`, `apply()` and `rowSums()`: row-wise calculations

**Existing R code** — [2015 Day 02, `AoC_2015_02_Code_R.R`](./2015/AoC_2015_02/AoC_2015_02_Code_R.R):

```r
Dimensions <- data.frame(do.call(rbind, strsplit(Data, split = "x")))
names(Dimensions) <- c("L", "W", "H")
Dimensions <- data.frame(lapply(Dimensions, as.numeric))

Volume    <- apply(Dimensions, 1, prod)
LargeSide <- Lib.RowMax(Dimensions)
SmallFace <- 2 * (rowSums(Dimensions) - LargeSide)
```

**Existing Python translation** — [2015 Day 02, `AoC_2015_02_Code_Py.py`](./2015/AoC_2015_02/AoC_2015_02_Code_Py.py):

```python
Split      = [x.split("x") for x in Data]
Dimensions = pd.DataFrame(Split, columns=["L", "W", "H"]).astype(int)

Volume    = np.prod(Dimensions, axis=1)
LargeSide = np.max(Dimensions, axis=1)
SmallFace = 2 * (np.sum(Dimensions, axis=1) - LargeSide)
```

`apply(..., 1, ...)` applies a function across rows; `axis=1` is the
corresponding NumPy/pandas direction. In R, `rowSums()` is explicit; pandas
uses `.sum(axis=1)`, and NumPy uses `np.sum(..., axis=1)`. `Lib.RowMax()` is a
project helper rather than a base R function; `np.max(..., axis=1)` supplies
the row maximum. For Part 1, `pmin(LW, LH, WH)` takes the element-wise
minimum across corresponding vector elements, matching
`np.min([LW, LH, WH], axis=0)` in the Python solution, rather than reducing
the original dimension table by row.

**Existing R code** — [2017 Day 02 Part 1, `AoC_2017_02_Code_R.R`](./2017/AoC_2017_02/AoC_2017_02_Code_R.R):

```r
Split       <- strsplit(Data, "\t")
Spreadsheet <- lapply(Split, as.numeric)
Min         <- unlist(lapply(Spreadsheet, min))
Max         <- unlist(lapply(Spreadsheet, max))
Checksum    <- sum(Max - Min)
```

**Existing Python translation** — [2017 Day 02, `AoC_2017_02_Code_Py.py`](./2017/AoC_2017_02/AoC_2017_02_Code_Py.py):

```python
Split       = [x.split("\t") for x in Data]
Spreadsheet = np.array(Split, dtype=int)
Min         = np.min(Spreadsheet, axis=1)
Max         = np.max(Spreadsheet, axis=1)
Checksum    = sum(Max - Min)
```

`lapply()` processes each row independently, and `unlist()` combines the
scalar row results into vectors. The Python translation converts the
rectangular rows into one 2D array and reduces along `axis=1`. R's
`strsplit()` uses the tab delimiter here; do not substitute a different
delimiter if the input format requires literal tabs.

### `do.call()`, `apply()` and `rep()`: matrix moves and cumulative positions

**Existing R code** — [2016 Day 01 Part 1, `AoC_2016_01_Code_R.R`](./2016/AoC_2016_01/AoC_2016_01_Code_R.R):

```r
VectorMap <- do.call(rbind, list(
  "0" = c("x" = 0, "y" = 1),
  "1" = c("x" = 1, "y" = 0),
  "2" = c("x" = 0, "y" = -1),
  "3" = c("x" = -1, "y" = 0)
))
Vectors  <- VectorMap[Direction + 1, ]
Move     <- Vectors * Steps
Position <- apply(Move, 2, cumsum)
```

**Existing Python translation** — [2016 Day 01, `AoC_2016_01_Code_Py.py`](./2016/AoC_2016_01/AoC_2016_01_Code_Py.py):

```python
VectorMap = np.array([
    [ 0,  1],
    [ 1,  0],
    [ 0, -1],
    [-1,  0]
])
Vectors  = VectorMap[Direction, :]
Steps    = np.array(Steps)
Move     = Vectors * Steps[:, None]
Position = np.cumsum(Move, axis=0)
```

The R lookup adds one because `Direction` contains 0-based direction labels
but R indices start at 1. Python indexes the same rows directly. In R,
`apply(Move, 2, cumsum)` applies `cumsum` to each column; NumPy
`np.cumsum(..., axis=0)` accumulates down rows, independently per column.
`Steps[:, None]` reshapes the one-dimensional step array to a column so it
broadcasts across each x/y direction pair.

R `apply()` can coerce matrices to a common type; use it here only because
`Move` is numeric. For a matrix-shaped result, the axis argument and the
orientation of rows versus columns are essential.

**Existing R code** — [2016 Day 01 Part 2, `AoC_2016_01_Code_R.R`](./2016/AoC_2016_01/AoC_2016_01_Code_R.R):

```r
Vectors <- Lib.RowsToList(VectorMap[Direction + 1, ])
Move    <- do.call(rbind, c(list(c(0, 0)), rep(Vectors, Steps)))
Position <- data.frame(apply(Move, 2, cumsum))
```

**Existing Python translation** — [2016 Day 01, `AoC_2016_01_Code_Py.py`](./2016/AoC_2016_01/AoC_2016_01_Code_Py.py):

```python
Vectors         = [row for row in VectorMap[Direction, :]]
RepeatedVectors = np.repeat(Vectors, Steps, axis=0)
Move            = np.vstack(([0, 0], RepeatedVectors))
Position        = np.cumsum(Move, axis=0)
```

`rep(Vectors, Steps)` repeats each list element the requested number of times;
NumPy's `np.repeat(..., axis=0)` repeats rows of the direction array. Both
prepend the origin before calculating cumulative positions.

### `ifelse()`, `cumsum() %%` and matrix row lookup: turn and direction lookup

**Existing R code** — [2016 Day 01 Part 1, `AoC_2016_01_Code_R.R`](./2016/AoC_2016_01/AoC_2016_01_Code_R.R):

```r
Turn      <- ifelse(Turn == "L", -1, 1)
Direction <- cumsum(Turn) %% 4
VectorMap <- do.call(rbind, list(
  "0" = c("x" = 0, "y" = 1),
  "1" = c("x" = 1, "y" = 0),
  "2" = c("x" = 0, "y" = -1),
  "3" = c("x" = -1, "y" = 0)
))
Vectors <- VectorMap[Direction + 1, ]
```

**Existing Python translation** — [2016 Day 01, `AoC_2016_01_Code_Py.py`](./2016/AoC_2016_01/AoC_2016_01_Code_Py.py):

```python
Turn      = [-1 if x == "L" else 1 for x in Turn]
Direction = np.cumsum(Turn) % 4
VectorMap = np.array([
    [ 0,  1],
    [ 1,  0],
    [ 0, -1],
    [-1,  0]
])
Vectors = VectorMap[Direction, :]
```

`ifelse()` selects one value per element, like the Python conditional
expression in a comprehension. `cumsum()` tracks the facing after each turn;
modulo 4 wraps the direction around the four compass headings. The direction
values are zero-based labels, so R adds one when indexing the matrix row;
NumPy uses those labels directly. R's `%%` and Python's `%` are the
corresponding remainder operators for these non-negative direction values.

## Vectors, indexing and selection

### Named-vector lookup, `cumsum()` and `which()`: map characters and find a position

**Existing R code** — [2015 Day 01, `AoC_2015_01_Code_R.R`](./2015/AoC_2015_01/AoC_2015_01_Code_R.R):

```r
CharVal <- c("(" = 1, ")" = -1)
Split   <- strsplit(Data, "")[[1]]
Value   <- CharVal[Split]
Floor   <- sum(Value)

Position      <- cumsum(Value)
FirstBasement <- which(Position == -1)[[1]]
```

**Existing Python translation** — [2015 Day 01, `AoC_2015_01_Code_Py.Py`](./2015/AoC_2015_01/AoC_2015_01_Code_Py.Py):

```python
CharVal  = {"(": 1, ")": -1}
Split    = list(Data)
Value    = [CharVal[x] for x in Split]
Floor    = sum(Value)

Position      = np.cumsum(Value)
FirstBasement = np.where(Position == -1)[0][0]
```

R indexes a named vector by character keys; Python uses a dictionary lookup.
R `cumsum()` and NumPy `np.cumsum()` produce a running total. `which()` returns
matching positions, while `np.where(mask)[0]` returns 0-based array indices.
The R result is the character position (1-based); the existing Python
translation returns the 0-based index, so add 1 if the requested answer is a
position rather than an index. An unknown R name yields `NA`; an unknown
Python dictionary key raises `KeyError`.

### Circular vector indexing and logical masks (`c(x[-1], x[1])`)

**Existing R code** — [2017 Day 01 Part 1, `AoC_2017_01_Code_R.R`](./2017/AoC_2017_01/AoC_2017_01_Code_R.R):

```r
X.0     <- Split
X.1     <- c(Split[-1], Split[1])
Same    <- X.0 == X.1
Captcha <- sum(Same * X.0)
```

**Existing Python translation** — [2017 Day 01, `AoC_2017_01_Code_Py.py`](./2017/AoC_2017_01/AoC_2017_01_Code_Py.py):

```python
X0      = np.array(Split).astype(int)
X1      = np.concatenate((X0[1:], X0[:1]))
Same    = X0 == X1
Captcha = sum(Same * X0)
```

Both create a circular one-step shift, comparing the last element back to the
first. Python/NumPy slicing is zero-based and end-exclusive; `np.roll(X0, -1)`
is another NumPy expression for this left shift. The comparison creates a
boolean vector, and multiplying by the numeric vector makes non-matches
contribute zero before summation.

**Existing R code** — [2017 Day 01 Part 2, `AoC_2017_01_Code_R.R`](./2017/AoC_2017_01/AoC_2017_01_Code_R.R):

```r
N       <- length(Split)
X.0     <- Split[1:(N/2)]
X.1     <- Split[(N/2 + 1):N]
Same    <- X.0 == X.1
Captcha <- sum(Same * X.0) * 2
```

**Existing Python translation** — [2017 Day 01, `AoC_2017_01_Code_Py.py`](./2017/AoC_2017_01/AoC_2017_01_Code_Py.py):

```python
N       = len(Split)
X0      = Split[:(N // 2)]
X1      = Split[(N // 2):]
Same    = X0 == X1
Captcha = sum(Same * X0 * 2)
```

The puzzle guarantees an even length. R uses `/` and 1-based inclusive
indices; Python uses integer division `//` and 0-based, end-exclusive slices.
The R code doubles the first-half matches because each match has a
corresponding match in the other half.

### `cbind()` and lag vectors: rolling-window sums

**Existing R code** — [2021 Day 01, `AoC_2021_01_Code_R.R`](./2021/AoC_2021_01/AoC_2021_01_Code_R.R):

```r
N            <- length(Data)
Depth        <- as.numeric(Data)
Depth.Lag_1  <- c(NA, Depth[-N])
Depth.Lag_2  <- c(NA, NA, Depth[-c(N, N - 1)])

GroupSums <- rowSums(cbind(Depth, Depth.Lag_1, Depth.Lag_2))
Increased <- F.Part.1(Lib.NA.To.Val(GroupSums, Inf))
```

**Existing Python translation** — [2021 Day 01, `AoC_2021_01_Code_Py.py`](./2021/AoC_2021_01/AoC_2021_01_Code_Py.py):

```python
N            = len(Data)
Depth        = Data
Depth_Lag_1  = np.concatenate(([np.inf], Depth[0:(N - 1)]))
Depth_Lag_2  = np.concatenate(([np.inf], [np.inf], Depth[0:(N - 2)]))

Groups     = [Depth, Depth_Lag_1, Depth_Lag_2]
Group_Sums = np.sum(Groups, axis=0)
Increased  = F_Part_1(Group_Sums)
```

Each lag vector is shifted right and padded at the beginning. `cbind()`
forms columns and `rowSums()` adds each aligned window; NumPy stacks the
vectors in a list and sums along `axis=0`. R pads with `NA` and replaces
incomplete sums with `Inf` before comparison; Python uses `np.inf` directly.
Because every finite depth is less than infinity, the first incomplete
window is not counted as an increase.

For a width-three window, adjacent sums differ only by the newly entering
and leaving values. A direct `np.diff(Depth, n=3)` comparison can therefore
avoid materializing all window sums, but the paired source code explicitly
builds the lag columns.

### `which()` with `%in%`: return positions of matching elements

**Existing R code** — [2020 Day 01 Part 1, `AoC_2020_01_Code_R.R`](./2020/AoC_2020_01/AoC_2020_01_Code_R.R):

```r
Delta   <- Year - X
Which   <- which(Delta %in% X)
Product <- prod(X[Which])
```

**Existing Python translation** — [2020 Day 01, `AoC_2020_01_Code_Py.py`](./2020/AoC_2020_01/AoC_2020_01_Code_Py.py):

```python
Delta   = Year - X
Product = np.prod(X[np.isin(Delta, X)])
```

`%in%` and `np.isin()` answer membership for each element of the left-hand
array. R's `which()` turns the logical vector into 1-based positions; NumPy
boolean indexing applies the mask directly. Membership does not enforce
distinct source positions: repeated values or selecting an entry as its own
complement need separate handling if the problem does not rule them out.

### `sort()`, `abs()` and `sum()`: sort, pair and reduce

**Existing R code** — [2024 Day 01 Part 1, `AoC_2024_01_Code_R.R`](./2024/AoC_2024_01/AoC_2024_01_Code_R.R):

```r
X1      <- sort(DF$X1)
X2      <- sort(DF$X2)
Dist    <- abs(X1 - X2)
TotDist <- sum(Dist)
```

**Existing Python translation** — [2024 Day 01, `AoC_2024_01_Code_Py.py`](./2024/AoC_2024_01/AoC_2024_01_Code_Py.py):

```python
X1      = np.sort(DF["X1"])
X2      = np.sort(DF["X2"])
Dist    = np.abs(X1 - X2)
TotDist = sum(Dist)
```

Each column is independently sorted, then paired by rank. This is not
nearest-neighbor matching. `order()` is not used in these solutions; in R it
returns the permutation of positions that sorts a vector, analogous to
Python's `np.argsort()`. The existing example uses `sort()` / `np.sort()`.
R and NumPy return sorted values; pandas `Series.sort_values()` also sorts
values but typically preserves the original index unless reset.

### `diff()`, `sign()` and negative indexing: adjacent tests and deletion checks

**Existing R code** — [2024 Day 02, `AoC_2024_02_Code_R.R`](./2024/AoC_2024_02/AoC_2024_02_Code_R.R):

```r
Delta     <- Report[-1] - Report[-Length]
Test.Sign <- length(unique(sign(Delta))) == 1
Test.Diff <- prod(abs(Delta) %in% seq(1, 3))

for (i in 1:Length) {
  Safe <- F.Report.Safe(Report[-i])
  if (Safe == 1) { break }
}
```

**Existing Python translation** — [2024 Day 02, `AoC_2024_02_Code_Py.py`](./2024/AoC_2024_02/AoC_2024_02_Code_Py.py):

```python
Delta     = Report[1:] - Report[:(Length - 1)]
Test_Sign = len(np.unique(np.sign(Delta))) == 1
Test_Diff = np.prod(np.isin(np.abs(Delta), np.array([1, 2, 3])))
```

The adjacent subtraction is also expressible as `np.diff(Report)`. R's
`Report[-1]` excludes the first value, and `Report[-Length]` excludes the
last; NumPy uses the direct adjacent slices shown. R negative indexing
removes positions rather than selecting them, so `Report[-i]` deletes the
one-based position `i`; Python's corresponding operation is
`np.delete(report, i - 1)`. `sign()` maps differences to -1, 0, or 1, and
`unique()` verifies that all changes share one sign. `seq(1, 3)` includes
both endpoints; the Python array lists those integer magnitudes explicitly.

The R dampener tries each one-item deletion and stops at the first safe
result. The Python file contains the same `np.delete()` attempt inside
`F_Safe_Dampener`, but its Part 2 calls an undefined `F_Safe_Reports` and
never applies that helper, so the existing Part 2 is not a working
translation.

**Recommended equivalent** — make the removal check explicit and retain the
original-safe case:

```python
def is_safe(report):
    delta = np.diff(report)
    return (len(np.unique(np.sign(delta))) == 1
            and np.all(np.isin(np.abs(delta), [1, 2, 3])))

safe = is_safe(report) or any(
    is_safe(np.delete(report, i))
    for i in range(len(report))
)
```

This is a recommended equivalent, not code copied from the solution. For an
empty `delta`, decide the desired behavior explicitly; `np.unique([])` has
length zero, so this exact predicate treats reports with fewer than two
values as unsafe.

## Counting, matching and missing values

### `table()`, `match()` and `Lib.NumericNames()`: frequency lookup

**Existing R code** — [2024 Day 01 Part 2, `AoC_2024_01_Code_R.R`](./2024/AoC_2024_01/AoC_2024_01_Code_R.R):

```r
Table.X2   <- table(DF$X2)
Multiplier <- Lib.NA.To.Zero(
  as.numeric(Table.X2[match(DF$X1, Lib.NumericNames(Table.X2))])
)
Similarity <- sum(DF$X1 * Multiplier)
```

**Existing Python translation** — [2024 Day 01, `AoC_2024_01_Code_Py.py`](./2024/AoC_2024_01/AoC_2024_01_Code_Py.py):

```python
Table_X2   = DF["X2"].value_counts().sort_index()
Multiplier = DF["X1"].map(Table_X2).fillna(0).to_numpy()
Similarity = sum(DF["X1"] * Multiplier)
```

`table()` produces counts with character names. `Lib.NumericNames()` converts
those names to numbers so `match()` can align them with numeric `X1`.
`match(x, table)` returns the first matching position for each value, or
`NA` if no match; indexing the frequency table with those positions retrieves
the counts. In pandas, `value_counts()` gives a value-indexed count Series,
and `.map()` performs the lookup; `.fillna(0)` handles absent keys. This is
the same weighted-count calculation, but the lookup interfaces differ.

### `tapply()` and nested `table()`: group and frequency summaries

**Existing R code** — [2022 Day 01, `AoC_2022_01_Code_R.R`](./2022/AoC_2022_01/AoC_2022_01_Code_R.R):

```r
Elf.ID       <- cumsum(is.na(Calories))
Elf.Calories <- tapply(Lib.NA.To.Zero(Calories), Elf.ID, sum)
```

Separately, nested `table()` calls build a per-report histogram in
[2018 Day 02, `AoC_2018_02_Code_R.R`](./2018/AoC_2018_02/AoC_2018_02_Code_R.R):

```r
LetterCounts <- lapply(Split, table)
CountCounts  <- lapply(LetterCounts, table)
CountVals    <- lapply(CountCounts, Lib.NumericNames)
```

**Existing Python translations** — [2022 Day 01, `AoC_2022_01_Code_Py.py`](./2022/AoC_2022_01/AoC_2022_01_Code_Py.py) and [2018 Day 02, `AoC_2018_02_Code_Py.py`](./2018/AoC_2018_02/AoC_2018_02_Code_Py.py):

```python
Elf_ID       = np.cumsum(np.isnan(Calories))
Elf_Calories = pd.Series(Calories).fillna(0).groupby(Elf_ID).sum()

LetterCounts = [np.unique(x, return_counts=True)[1] for x in Split]
CountCounts  = [np.unique(x, return_counts=True)[0] for x in LetterCounts]
```

`tapply(values, group, sum)` aggregates values by group labels; pandas
`groupby(...).sum()` is a close counterpart. The nested `table()` counts
characters, then counts how often each frequency occurs. The Python translation
uses `np.unique(..., return_counts=True)` twice. `table()` includes named
levels and `Lib.NumericNames()` converts frequency names back to values; the
NumPy version obtains the frequency values directly. When checking whether a
row contains a count of 2 or 3, R's `Lib.B.in.A()` and Python's `np.isin()`
both implement membership tests.

**Existing R code** — [2023 Day 02, `AoC_2023_02_Code_R.R`](./2023/AoC_2023_02/AoC_2023_02_Code_R.R):

```r
Largest <- Lib.MapVecToSet(
  tapply(Counts$N, Counts$Colour, max),
  names(Max)
)
Valid <- prod(Largest <= Max)
```

**Existing Python translation** — [2023 Day 02, `AoC_2023_02_Code_Py.py`](./2023/AoC_2023_02/AoC_2023_02_Code_Py.py):

```python
Largest = Counts.groupby("Colour")["N"].max().reindex(Max.index).fillna(0)
Valid   = np.prod(Largest <= Max)
```

The explicit reindex aligns each colour with the required colour set and
fills colours absent from a game with zero. This alignment matters: comparing
unordered values without matching their labels could compare the wrong
colours. The R helper `Lib.MapVecToSet()` performs the analogous alignment.

### `NA`, `is.na()` and `Lib.NA.To.Zero()`: missing values as group boundaries

**Existing R code** — [2022 Day 01, `AoC_2022_01_Code_R.R`](./2022/AoC_2022_01/AoC_2022_01_Code_R.R):

```r
Calories     <- as.numeric(Data)
Elf.ID       <- cumsum(is.na(Calories))
Elf.Calories <- tapply(Lib.NA.To.Zero(Calories), Elf.ID, sum)
Max          <- max(Elf.Calories)
Sum.Top3     <- sum(sort(Elf.Calories, decreasing = TRUE)[1:3])
```

**Existing Python translation** — [2022 Day 01, `AoC_2022_01_Code_Py.py`](./2022/AoC_2022_01/AoC_2022_01_Code_Py.py):

```python
Elf_ID       = np.cumsum(np.isnan(Calories))
Elf_Calories = pd.Series(Calories).fillna(0).groupby(Elf_ID).sum()
Max          = np.max(Elf_Calories)
Sum_Top3     = Elf_Calories.nlargest(3).sum()
```

The missing value marks a boundary, and its zero contribution lets the
cumulative missing count group the preceding values. In Python, the CSV
reader is configured with `skip_blank_lines=False` so the separator is not
lost. R `is.na()` also returns true for `NaN`; the Python example uses
`np.isnan()` on numeric data. `Lib.NA.To.Zero()` replaces every missing value
with zero, so only use this when zero is the intended contribution.

There is a subtle difference for groups with fewer than three entries:
R's `[1:3]` can produce out-of-range `NA` values, while `.nlargest(3)` returns
only those available. The puzzle input has enough groups.

### `unique()`: remove duplicates without assuming values represent positions

**Existing R code** — [2020 Day 01 Part 2, `AoC_2020_01_Code_R.R`](./2020/AoC_2020_01/AoC_2020_01_Code_R.R):

```r
Which   <- which(Pairs$Sum %in% Delta)
Product <- prod(unique(Pairs$A[Which]))
```

**Existing Python translation** — [2020 Day 01, `AoC_2020_01_Code_Py.py`](./2020/AoC_2020_01/AoC_2020_01_Code_Py.py):

```python
X_Values = np.unique(Pairs["A"][np.isin(Pairs["Sum"], Delta)])
Product  = np.prod(X_Values)
```

Both retain distinct candidate *values*, not distinct input positions.
`np.unique()` returns sorted unique values; R `unique()` preserves the order
of first occurrence. This difference usually does not change a product or
sum, but can change output order. Deduplicating values is not sufficient when
the problem requires distinct entries or index combinations.

## Algorithms and reusable patterns

### `expand.grid()` and `rowSums()`: Cartesian candidate grids

**Existing R code** — [2020 Day 01 Part 2, `AoC_2020_01_Code_R.R`](./2020/AoC_2020_01/AoC_2020_01_Code_R.R):

```r
Pairs     <- expand.grid("A" = X, "B" = X)
Pairs$Sum <- rowSums(Pairs)
Which     <- which(Pairs$Sum %in% Delta)
```

**Existing Python translation** — [2020 Day 01, `AoC_2020_01_Code_Py.py`](./2020/AoC_2020_01/AoC_2020_01_Code_Py.py):

```python
Pairs        = Lib_ExpandGrid(A=X, B=X)
Pairs["Sum"] = Pairs["A"] + Pairs["B"]
X_Values     = np.unique(Pairs["A"][np.isin(Pairs["Sum"], Delta)])
```

`expand.grid()` creates all ordered combinations. The Python file uses the
project helper `Lib_ExpandGrid()` rather than a direct NumPy or pandas
operation. For two columns, `rowSums(Pairs)` adds across each row; the Python
translation adds the two columns. A NumPy alternative is
`np.add.outer(X, X)`, which makes the same pair-sum grid without first
building a table.

The grid has quadratic size. It includes pairs using the same input value
twice, and both pair orders. The source code comments that its final product
relies on the selected three values being distinct; do not reuse this pattern
without checking position/duplicate rules for a new puzzle.

**Existing R code** — [2017 Day 02 Part 2, `AoC_2017_02_Code_R.R`](./2017/AoC_2017_02/AoC_2017_02_Code_R.R):

```r
Grid <- expand.grid(x = X, y = X)
Grid <- Grid[Grid$x != Grid$y, ]
Grid$Remainder <- Grid$x %% Grid$y
Grid$Quotient  <- Grid$x / Grid$y
Grid$Quotient[Grid$Remainder == 0]
```

**Existing Python translation** — [2017 Day 02, `AoC_2017_02_Code_Py.py`](./2017/AoC_2017_02/AoC_2017_02_Code_Py.py):

```python
Grid              = Lib_ExpandGrid(x=X, y=X)
Grid              = Grid[Grid.x != Grid.y]
Grid["Remainder"] = Grid.x % Grid.y
Grid["Quotient"]  = Grid.x / Grid.y
Quotient          = Grid.Quotient[Grid.Remainder == 0]
```

This tests ordered value pairs and retains quotients where the divisor
divides evenly. The example removes equal *values*, not equal positions; if
the input contains duplicates, `x != y` can discard a pair made from two
different positions with the same value. The puzzle's rows are small enough
for a Cartesian grid, but its size is quadratic in the row length.

### `expand.grid()`, `mapply()` and logical character indexing: compare IDs

**Existing R code** — [2018 Day 02 Part 2, `AoC_2018_02_Code_R.R`](./2018/AoC_2018_02/AoC_2018_02_Code_R.R):

```r
Grid <- expand.grid("x" = Data, "y" = Data,
                    stringsAsFactors = FALSE)

F.Same <- function(x, y) {
  X <- strsplit(x, "")[[1]]
  Y <- strsplit(y, "")[[1]]
  X[X == Y]
}

Same       <- mapply(F.Same, as.list(Grid$x), as.list(Grid$y),
                     SIMPLIFY = FALSE)
Count.Same <- unlist(lapply(Same, length))
Box        <- which(Count.Same == (Nchar - 1))[[1]]
ID         <- paste(Same[Box][[1]], collapse = "")
```

**Existing Python translation** — [2018 Day 02, `AoC_2018_02_Code_Py.py`](./2018/AoC_2018_02/AoC_2018_02_Code_Py.py):

```python
Grid = Lib_ExpandGrid(x=Data, y=Data)

def F_Same(x, y):
    X = np.array(list(x))
    Y = np.array(list(y))
    return X[X == Y]

Same      = [F_Same(x, y) for x, y in zip(Grid.x, Grid.y)]
CountSame = np.array([len(x) for x in Same])
Box       = [x for x, Count in zip(Same, CountSame)
            if Count == (Nchar - 1)][0]
ID        = "".join(Box)
```

The logical mask `X == Y` selects matching characters at corresponding
positions, and `paste(..., collapse="")` / `"".join(...)` rebuilds the
common ID. `mapply()` passes paired inputs to a function; the Python list
comprehension with `zip()` does the same. The Cartesian grid includes each
ID paired with itself, but the exact `Nchar - 1` match-count condition
excludes those. This direct all-pairs search is quadratic in the number of
IDs.

### `for` loops and positional writes: a small mutable virtual machine

**Existing R code** — [2019 Day 02, `AoC_2019_02_Code_R.R`](./2019/AoC_2019_02/AoC_2019_02_Code_R.R):

```r
p.1 <- X[p.0 + 1] + 1
p.2 <- X[p.0 + 2] + 1
p.3 <- X[p.0 + 3] + 1
x.0 <- X[p.0]
x.1 <- X[p.1]
x.2 <- X[p.2]

if (x.0 %in% c(1, 2)) { X[p.3] <- Val }
p.0 <- p.0 + 4
```

**Existing Python translation** — [2019 Day 02, `AoC_2019_02_Code_Py.py`](./2019/AoC_2019_02/AoC_2019_02_Code_Py.py):

```python
p_1 = X[p_0 + 1]
p_2 = X[p_0 + 2]
p_3 = X[p_0 + 3]
x_0 = X[p_0]
x_1 = X[p_1]
x_2 = X[p_2]

if np.isin(x_0, [1, 2]):
    X[p_3] = Val
p_0 += 4
```

The instruction pointer advances four positions each step; the operands
contain zero-based addresses. The R implementation starts its pointer at 1
and adds one to each address before indexing, whereas Python indexes those
addresses directly. The write `X[p.3] <- Val` / `X[p_3] = Val` mutates the
program memory, so a later instruction sees the updated value.

Within one Python call, `X = Base` aliases the same NumPy array, so writes
through `X` also change `Base`. In this solution `Base` is parsed afresh
inside `F_Part_1`, so each noun/verb trial starts from the original text and
does not contaminate the next call. If the parsed array is moved outside the
function and reused, use `X = Base.copy()` for each run. R's ordinary vector
assignment uses copy-on-modify semantics, so `X <- Base` does not normally
mutate `Base` in place.

Part 2 searches all noun/verb pairs using `expand.grid()` in R and the
project's `Lib_ExpandGrid()` in Python, calling the interpreter until the
target output is found. This is exhaustive search; the working memory must be
reset for each trial.

### `do.call(paste0, ...)` and `nchar()`: generate repeated digit patterns

**Existing R code** — [2025 Day 02, `AoC_2025_02_Code_R.R`](./2025/AoC_2025_02/AoC_2025_02_Code_R.R):

```r
Grid    <- expand.grid(rep(list(Digits), Factor))
ConCat  <- apply(Grid, 1, paste, collapse = "")
Repeat  <- do.call(paste0, rep(list(ConCat), Complement))
Numbers <- sort(unique(as.numeric(Repeat)))
Invalids[[Counter]] <- Numbers[which(nchar(Numbers) == Digs)]
```

**Existing Python translation** — [2025 Day 02, `AoC_2025_02_Code_Py.py`](./2025/AoC_2025_02/AoC_2025_02_Code_Py.py):

```python
Grid    = Lib_ExpandGrid(**Grid_Inputs)
ConCat  = Grid.astype(str).agg("".join, axis=1)
Repeat  = ConCat.str.repeat(Complement)
Numbers = np.sort(pd.to_numeric(Repeat).unique())
Invalids.append(
    Numbers[np.char.str_len(Numbers.astype(str)) == Digs]
)
```

`expand.grid()` creates every digit prefix of the selected width.
`apply(..., 1, paste, collapse="")` concatenates each row into a prefix;
the Python DataFrame uses `.agg("".join, axis=1)`. `do.call(paste0, ...)`
passes repeated vectors as arguments to `paste0()`, concatenating matching
positions; pandas string `.str.repeat()` applies the repetition to each
prefix. `nchar()` filters by the resulting decimal width.

The integer conversion removes leading zeroes, which is why the code checks
the string length after conversion before accepting a candidate. This is a
specific candidate-generation strategy: it builds repeated-pattern numbers
first and then tests whether they fall in any supplied interval. The
Cartesian prefix grid can grow rapidly as the width increases.

**Existing R range test** — the same 2025 Day 02 solution:

```r
RangeMarker <- rep(FALSE, length(Invalids))
for (i in 1:N.Pairs) {
  RangeMarker <- RangeMarker |
    (Pairs$From[[i]] <= Invalids & Invalids <= Pairs$To[[i]])
}
Sum.RangeInvalids <- sum(Invalids * RangeMarker)
```

**Existing Python translation**:

```python
RangeMarker = np.zeros(len(Invalid_Values), dtype=bool)
for i in range(N_Pairs):
    RangeMarker |= (
        (Pairs["From"].iloc[i] <= Invalid_Values) &
        (Invalid_Values <= Pairs["To"].iloc[i])
    )
Sum_RangeInvalids = np.sum(Invalid_Values[RangeMarker])
```

Each loop iteration builds an element-wise inclusive interval mask and
combines it with the accumulated mask using logical OR. Python uses `&` and
parentheses because bitwise operators bind differently from comparison
operators; use `and` only for scalar booleans. The final R multiplication by
a logical vector and Python's boolean indexing both sum the matching values.

### `match()`, modulo and `ifelse()`: code lookups and modular scoring

**Existing R code** — [2022 Day 02, `AoC_2022_02_Code_R.R`](./2022/AoC_2022_02/AoC_2022_02_Code_R.R):

```r
Game <- data.frame(
  "Opp" = match(Split$Opp, LETTERS[1:3]),
  "Play" = match(Split$Play, LETTERS[24:26])
)
Game$Result <- c(3, 6, 0)[(Game$Play - Game$Opp) %% 3 + 1]
```

**Existing Python translation** — [2022 Day 02, `AoC_2022_02_Code_Py.py`](./2022/AoC_2022_02/AoC_2022_02_Code_Py.py):

```python
Game = pd.DataFrame({
    "Opp":  Split["Opp"].map({"A": 1, "B": 2, "C": 3}),
    "Play": Split["Play"].map({"X": 1, "Y": 2, "Z": 3})
})
Game["Result"] = [
    [3, 6, 0][int(x)]
    for x in (Game["Play"] - Game["Opp"]) % 3
]
```

`match(values, lookup)` returns the first matching position, numbered from
1; dictionary `.map()` returns the supplied code directly. R adds one to the
modulo result because its vector indices start at 1. Python's nested list
lookup uses the zero-based remainder directly. Both use a modulo-3 cycle to
classify outcomes; the numeric encoding and lookup order must agree.

Part 2 maps the desired outcome to an offset and computes the required play.
R uses `ifelse(Game$Play == 0, 3, Game$Play)` to map remainder zero back to
the third play; Python's `np.where(condition, 3, value)` is the element-wise
counterpart.

### Dictionaries and loop updates: keep explicit navigation state

**Existing R code** — [2021 Day 02, `AoC_2021_02_Code_R.R`](./2021/AoC_2021_02/AoC_2021_02_Code_R.R):

```r
P <- list("aim" = 0, "horz" = 0, "depth" = 0)

F.Move <- function(P, D, X) {
  if (D == "up")      { P$aim <- P$aim + X }
  if (D == "down")    { P$aim <- P$aim - X }
  if (D == "forward") {
    P$horz  <- P$horz + X
    P$depth <- P$depth - abs(P$aim) * X
  }
  return(P)
}
```

**Existing Python translation** — [2021 Day 02, `AoC_2021_02_Code_Py.py`](./2021/AoC_2021_02/AoC_2021_02_Code_Py.py):

```python
P = {"aim": 0, "horz": 0, "depth": 0}

def F_Move(P, D, X):
    if D == "up":
        P["aim"] = P["aim"] + X
    if D == "down":
        P["aim"] = P["aim"] - X
    if D == "forward":
        P["horz"] = P["horz"] + X
        P["depth"] = P["depth"] - np.abs(P["aim"]) * X
    return P

for i in range(len(Move)):
    P = F_Move(P, Direction[i], Move[i])
```

R's named list fields (`P$aim`) map naturally to dictionary keys
(`P["aim"]`). The loop carries updated state from one command to the next.
The R source defines `F.Move` but calls `F.Mov` in the loop, so its Part 2
fails unless that typo is corrected. The Python translation calls its
function consistently. Both use a negative depth convention here and take
the absolute final product; do not silently change the sign convention when
adapting just one part of the calculation.

### `repeat`, `while`, `break`, `rep()` and `unlist()`: loops, state and repeated work

**Existing R code** — [2018 Day 01, `AoC_2018_01_Code_R.R`](./2018/AoC_2018_01/AoC_2018_01_Code_R.R), initial repeated-frequency approach:

```r
Delta   <- as.numeric(Data)
Stop    <- 0
List    <- numeric(0)
Counter <- 0

while (Stop == 0) {
  Counter <- Counter + 1
  List    <- c(List, Delta)
  CumSum  <- cumsum(List)
  Seq     <- Lib.SeqOn(CumSum)
  if (max(Seq) > 1) { Stop <- 1 }
}

Which <- which(Seq == 2)[1]
Freq  <- CumSum[Which]
```

**Existing Python translation** — [2018 Day 01, `AoC_2018_01_Code_Py.py`](./2018/AoC_2018_01/AoC_2018_01_Code_Py.py):

```python
Stop = 0
List = []
while Stop == 0:
    List   = np.append(List, Data)
    CumSum = np.cumsum(List)
    Seq    = Lib_SeqOn(CumSum)
    if max(Seq) > 1:
        Stop = 1

Freq = CumSum[Seq == 2][0]
```

Both repeatedly append a cycle, recompute all cumulative sums, and search for
the first repeated frequency. This is a direct translation of the algorithm,
not an efficient way to grow a large numeric history: Python `np.append()`
allocates a new array, and the cumulative sum and duplicate search are
repeated over prior data.

The R file also includes a cycle-at-a-time version: precompute
`Delta.Cum <- cumsum(Delta)`, form `New <- Base + Delta.Cum`, test
`New %in% CumSum`, and advance the cycle base. The Python `F_Part_2_v2`
similarly uses `np.cumsum()`, `np.isin()`, and `CumSum.extend(New)`. This
reuses the within-cycle work but still stores and scans the history.

**Illustrative standard-Python alternative** — incremental states with a set:

```python
from itertools import cycle

seen = {0}
frequency = 0
for change in cycle(changes):
    frequency += change
    if frequency in seen:
        break
    seen.add(frequency)
```

This avoids rescanning the full history for every new value, but assumes a
repeat will eventually occur. A set tests membership by value and does not
preserve occurrence order; keep the generated sequence separately if order is
also needed.

**Existing R code** — [2019 Day 01 Part 2, `AoC_2019_01_Code_R.R`](./2019/AoC_2019_01/AoC_2019_01_Code_R.R):

```r
Fuel   <- list()
i.Mass <- Mass.0
i      <- 1

repeat {
  Fuel[[i]] <- pmax(floor(i.Mass / 3) - 2, 0)
  if (sum(Fuel[[i]]) == 0) { break } else { i.Mass <- Fuel[[i]] }
  i <- i + 1
}

Fuel.Tot <- sum(unlist(Fuel))
```

**Existing Python translation** — [2019 Day 01, `AoC_2019_01_Code_Py.py`](./2019/AoC_2019_01/AoC_2019_01_Code_Py.py):

```python
Fuel   = []
i_Mass = Mass_0
i      = 0
while True:
    Fuel.append(np.maximum(i_Mass // 3 - 2, 0))
    if sum(Fuel[i]) == 0:
        break
    i_Mass = Fuel[i]
    i += 1

Fuel_Tot = np.sum(np.concatenate(Fuel))
```

R `repeat` has no condition in its header, so `break` ends it explicitly.
Python's `while True` is the direct counterpart. `rep(Vectors, Steps)` in
2016 Day 01 is a separate use of R's `rep()` to repeat direction rows by
step-count; the Python translation uses `np.repeat(Vectors, Steps, axis=0)`.
`unlist(Fuel)` flattens a list of vectors; the Python code concatenates its
arrays with `np.concatenate()`.

Both Part 2 implementations clamp fuel at zero with `pmax()` /
`np.maximum()`. R Part 1 does not clamp; the Python Part 1 does. For small
masses that difference changes results. The Python recursive alternative in
2019 Day 01 references `Mass` instead of its `Data` argument when creating
the result list, so it is not self-contained as written.

The R file also uses `sapply(Mass, F.Recursive.FuelForMass)` to apply the
recursive scalar function to each mass. Its Python counterpart uses a list
comprehension, `[F_Recursive_FuelForMass(x) for x in Mass]`, but the
undefined `Mass` name makes that implementation fail unless an unrelated
global happens to exist.

### `sapply()` and recursive functions: map a scalar calculation

**Existing R code** — [2019 Day 01 Part 2 v1, `AoC_2019_01_Code_R.R`](./2019/AoC_2019_01/AoC_2019_01_Code_R.R):

```r
F.Recursive.FuelForMass <- function(x, Fuel) {
  if (missing(Fuel)) {
    Fuel <- 0
  }
  Add <- max(floor(x / 3) - 2, 0)
  if (Add == 0) {
    return(Fuel)
  } else {
    return(F.Recursive.FuelForMass(Add, Fuel + Add))
  }
}

Fuel <- sapply(Mass, F.Recursive.FuelForMass)
```

**Existing Python translation** — [2019 Day 01, `AoC_2019_01_Code_Py.py`](./2019/AoC_2019_01/AoC_2019_01_Code_Py.py):

```python
def F_Recursive_FuelForMass(x, Fuel=0):
    Add = np.maximum(x // 3 - 2, 0)
    if Add == 0:
        return Fuel
    else:
        return F_Recursive_FuelForMass(Add, Fuel + Add)

Fuel = [F_Recursive_FuelForMass(x) for x in Mass]
```

`sapply()` calls the scalar function once for each item and simplifies the
results to a vector when possible. A Python list comprehension returns one
result per item. These excerpts are the existing code; the Python caller uses
`Mass`, which is not defined in its function or the shown file scope. To apply
the recursion to the function argument, use
`[F_Recursive_FuelForMass(x) for x in Data]`. R's `missing(Fuel)` default is
represented by Python's `Fuel=0` default argument.

### `Lib.GroupOn()` and `Lib.SeqOn()`: find a repeated location

**Existing R code** — [2016 Day 01 Part 2, `AoC_2016_01_Code_R.R`](./2016/AoC_2016_01/AoC_2016_01_Code_R.R):

```r
Group    <- Lib.GroupOn(Position$x, Position$y)
Seq      <- Lib.SeqOn(Group)
BunnyRef <- which(Seq == 2)[1]
BunnyAt  <- Position[BunnyRef, ]
```

**Existing Python translation** — [2016 Day 01 Part 2, `AoC_2016_01_Code_Py.py`](./2016/AoC_2016_01/AoC_2016_01_Code_Py.py):

```python
Group    = Lib_GroupOn(Position)
Seq      = Lib_SeqOn(Group)
BunnyRef = np.where(Seq == 2)[0][0]
BunnyAt  = Position[BunnyRef]
```

The helpers assign the same group ID to equal coordinate rows, then count
each group's occurrences in visit order. `which(Seq == 2)[1]` selects the
first second-visit row in R; `np.where(...)[0][0]` selects its 0-based row
index in Python. These `Lib_` helpers come from the existing Python setup,
not NumPy or pandas.

**Recommended standard-Python alternative** — use a set of coordinate tuples
when processing one unit move at a time:

```python
seen = {(0, 0)}
x = y = 0

for dx, dy in unit_moves:
    x += dx
    y += dy
    if (x, y) in seen:
        break
    seen.add((x, y))
```

This tests each point during traversal and avoids building a group ID and
occurrence vector for every row. Keep `(x, y)` as the result if the repeated
coordinate is needed; its distance from the origin is `abs(x) + abs(y)`.

### `function()` and `return()`: functions and solution structure

**Existing R code** — [2015 Day 01, `AoC_2015_01_Code_R.R`](./2015/AoC_2015_01/AoC_2015_01_Code_R.R):

```r
F.Part.1 <- function(Data) {
 CharVal <- c("(" = 1, ")" = -1)
 Split   <- strsplit(Data, "")[[1]]
 Value   <- CharVal[Split]
 Floor <- sum(Value)
 return(Floor)
}
```

**Existing Python translation** — [2015 Day 01, `AoC_2015_01_Code_Py.Py`](./2015/AoC_2015_01/AoC_2015_01_Code_Py.Py):

```python
CharVal = {"(": 1, ")": -1}

def F_Part_1(Data):
   Split = list(Data)
   Value = [CharVal[x] for x in Split]
   Floor = sum(Value)
   return Floor
```

R uses `function(arguments) { ... }`; Python uses `def name(arguments):` and
indentation to delimit the body. Both can return a calculated result. Python
also returns `None` if execution reaches the end without a `return`; R returns
the last evaluated expression if an explicit return is omitted.

## Input loading conventions in the paired scripts

These are examples of the existing local project setup, not universal
standalone-project recommendations.

- **R:** `readLines()` reads text as a character vector; `setwd(Dir)` is used
  by the solutions before reading their named input files.
- **Python:** Some scripts use `np.loadtxt(..., dtype=int)` for numeric rows;
  others use `open(...).read().strip()` for a single text string, or
  `pd.read_csv(..., header=None, skip_blank_lines=False)` for rows where blank
  lines matter.
- **Paths:** Python examples use `pathlib.Path` and some change the working
  directory with `os.chdir()`. The paired R scripts use `Root`, `Year`, `Day`,
  `Lib.LeadingZeros()`, and `setwd()`.

Always choose the reader to preserve the input's meaningful structure. For
example, skipping blank lines breaks the 2022 group-boundary approach.

## Source files analysed

All 21 complete canonical R/Python pairs discovered locally were read in
full for this update. The inventory includes pairs from 2015–2025; the
latest available pair is 2025 Day 02.

| Year | Day | Exact R filename | Exact Python filename |
|---:|---:|---|---|
| 2015 | 01 | `AoC_2015_01_Code_R.R` | `AoC_2015_01_Code_Py.Py` |
| 2015 | 02 | `AoC_2015_02_Code_R.R` | `AoC_2015_02_Code_Py.py` |
| 2016 | 01 | `AoC_2016_01_Code_R.R` | `AoC_2016_01_Code_Py.py` |
| 2016 | 02 | `AoC_2016_02_Code_R.R` | `AoC_2016_02_Code_Py.py` |
| 2017 | 01 | `AoC_2017_01_Code_R.R` | `AoC_2017_01_Code_Py.py` |
| 2017 | 02 | `AoC_2017_02_Code_R.R` | `AoC_2017_02_Code_Py.py` |
| 2018 | 01 | `AoC_2018_01_Code_R.R` | `AoC_2018_01_Code_Py.py` |
| 2018 | 02 | `AoC_2018_02_Code_R.R` | `AoC_2018_02_Code_Py.py` |
| 2019 | 01 | `AoC_2019_01_Code_R.R` | `AoC_2019_01_Code_Py.py` |
| 2019 | 02 | `AoC_2019_02_Code_R.R` | `AoC_2019_02_Code_Py.py` |
| 2020 | 01 | `AoC_2020_01_Code_R.R` | `AoC_2020_01_Code_Py.py` |
| 2020 | 02 | `AoC_2020_02_Code_R.R` | `AoC_2020_02_Code_Py.py` |
| 2021 | 01 | `AoC_2021_01_Code_R.R` | `AoC_2021_01_Code_Py.py` |
| 2021 | 02 | `AoC_2021_02_Code_R.R` | `AoC_2021_02_Code_Py.py` |
| 2022 | 01 | `AoC_2022_01_Code_R.R` | `AoC_2022_01_Code_Py.py` |
| 2022 | 02 | `AoC_2022_02_Code_R.R` | `AoC_2022_02_Code_Py.py` |
| 2023 | 01 | `AoC_2023_01_Code_R.R` | `AoC_2023_01_Code_Py.py` |
| 2023 | 02 | `AoC_2023_02_Code_R.R` | `AoC_2023_02_Code_Py.py` |
| 2024 | 01 | `AoC_2024_01_Code_R.R` | `AoC_2024_01_Code_Py.py` |
| 2024 | 02 | `AoC_2024_02_Code_R.R` | `AoC_2024_02_Code_Py.py` |
| 2025 | 02 | `AoC_2025_02_Code_R.R` | `AoC_2025_02_Code_Py.py` |

### Incomplete solution pairs

None. Every locally discovered R solution matching
`AoC_<Year>_<Day>_Code_R.R` has its corresponding Python file. The 2015 Day
01 Python file uses the `.Py` extension capitalization shown in the inventory.
