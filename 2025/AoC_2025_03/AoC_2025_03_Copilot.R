project_root <- "C:/Users/justi/OneDrive/Documents/GitHub/AoC_Copilot"
puzzle_directory <- file.path(project_root, "2025", "AoC_2025_03")
input_example <- file.path(puzzle_directory, "AoC_2025_03_Input_0.txt")
input_actual <- file.path(puzzle_directory, "AoC_2025_03_Input_1.txt")

best_subsequence <- function(bank_digits, output_length) {
  chars <- strsplit(bank_digits, "", fixed = TRUE)[[1]]
  n <- length(chars)
  output_length <- min(output_length, n)

  result <- character(output_length)
  start_index <- 1L
  remaining <- output_length
  result_position <- 1L

  while (remaining > 0L) {
    max_end <- n - remaining + 1L

    if (start_index > max_end) {
      for (pos in start_index:n) {
        result[result_position] <- chars[pos]
        result_position <- result_position + 1L
        remaining <- remaining - 1L
        if (remaining == 0L) {
          break
        }
      }
      break
    }

    max_index <- start_index
    for (pos in start_index:max_end) {
      if (chars[pos] > chars[max_index]) {
        max_index <- pos
      }
    }

    result[result_position] <- chars[max_index]
    start_index <- max_index + 1L
    result_position <- result_position + 1L
    remaining <- remaining - 1L
  }

  paste(result, collapse = "")
}

max_joltage_for_bank <- function(bank_digits, output_length) {
  best_digits <- best_subsequence(bank_digits, output_length)
  if (nchar(best_digits) == 0L) {
    return(0)
  }

  as.numeric(best_digits)
}

sum_max_joltages <- function(input_file, output_length) {
  banks <- readLines(input_file, warn = FALSE)
  total <- 0

  for (bank in banks) {
    total <- total + max_joltage_for_bank(bank, output_length)
  }

  total
}

part_1_example <- sum_max_joltages(input_example, 2)
part_1_actual <- sum_max_joltages(input_actual, 2)
part_2_example <- sum_max_joltages(input_example, 12)
part_2_actual <- sum_max_joltages(input_actual, 12)

cat("Part 1 example:", sprintf("%.0f", part_1_example), "\n")
cat("Part 1 actual:", sprintf("%.0f", part_1_actual), "\n")
cat("Part 2 example:", sprintf("%.0f", part_2_example), "\n")
cat("Part 2 actual:", sprintf("%.0f", part_2_actual), "\n")
