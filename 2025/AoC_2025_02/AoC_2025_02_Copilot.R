project_root <- "C:/Users/justi/OneDrive/Documents/GitHub/AoC_Copilot"
puzzle_directory <- file.path(project_root, "2025", "AoC_2025_02")
input_example <- file.path(puzzle_directory, "AoC_2025_02_Input_0.txt")
input_actual <- file.path(puzzle_directory, "AoC_2025_02_Input_1.txt")

read_id_ranges <- function(input_file) {
  input <- paste(readLines(input_file, warn = FALSE), collapse = "")
  ranges <- strsplit(input, ",", fixed = TRUE)[[1]]
  bounds <- do.call(rbind, strsplit(ranges, "-", fixed = TRUE))

  data.frame(
    first = as.numeric(bounds[, 1]),
    last = as.numeric(bounds[, 2])
  )
}

find_invalid_ids <- function(ranges, part_1 = FALSE) {
  max_digits <- max(nchar(as.character(ranges$last)))
  candidates <- numeric(0)

  for (block_length in seq_len(floor(max_digits / 2))) {
    blocks <- as.character(seq.int(
      from = 10^(block_length - 1),
      to = 10^block_length - 1
    ))

    repeat_counts <- if (part_1) {
      2L
    } else {
      seq.int(2, floor(max_digits / block_length))
    }

    for (repeat_count in repeat_counts) {
      repeated <- do.call(paste0, rep(list(blocks), repeat_count))
      candidates <- c(candidates, as.numeric(repeated))
    }
  }

  candidates <- unique(candidates)
  in_ranges <- vapply(candidates, function(id) {
    any(id >= ranges$first & id <= ranges$last)
  }, logical(1))

  candidates[in_ranges]
}

example_ranges <- read_id_ranges(input_example)
actual_ranges <- read_id_ranges(input_actual)

# Part 1
example_invalid_ids_part_1 <- find_invalid_ids(example_ranges, part_1 = TRUE)
actual_invalid_ids_part_1 <- find_invalid_ids(actual_ranges, part_1 = TRUE)

cat("Part 1 example:", sum(example_invalid_ids_part_1), "\n")
cat("Part 1 actual:", sum(actual_invalid_ids_part_1), "\n")

# Part 2
example_invalid_ids_part_2 <- find_invalid_ids(example_ranges)
actual_invalid_ids_part_2 <- find_invalid_ids(actual_ranges)

cat("Part 2 example:", sum(example_invalid_ids_part_2), "\n")
cat("Part 2 actual:", sum(actual_invalid_ids_part_2), "\n")