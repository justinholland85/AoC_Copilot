project_root <- "C:/Users/justi/OneDrive/Documents/GitHub/AoC_Copilot"
puzzle_directory <- file.path(project_root, "2020", "AoC_2020_01")
input_example <- file.path(puzzle_directory, "AoC_2020_01_Input_0.txt")
input_actual <- file.path(puzzle_directory, "AoC_2020_01_Input_1.txt")


Time    <-  proc.time()

read_expenses <- function(path) {
  as.integer(readLines(path, warn = FALSE))
}

find_two_sum_product <- function(expenses, target = 2020L) {
  seen <- new.env(parent = emptyenv())

  for (value in expenses) {
    complement <- target - value
    if (exists(as.character(complement), envir = seen, inherits = FALSE)) {
      return(value * complement)
    }
    seen[[as.character(value)]] <- TRUE
  }

  stop("No pair sums to the target.")
}

find_three_sum_product <- function(expenses, target = 2020L) {
  seen <- new.env(parent = emptyenv())
  for (value in expenses) {
    seen[[as.character(value)]] <- TRUE
  }

  for (i in seq_along(expenses)) {
    for (j in seq_along(expenses)) {
      if (j <= i) {
        next
      }

      pair_sum <- expenses[i] + expenses[j]
      complement <- target - pair_sum
      if (exists(as.character(complement), envir = seen, inherits = FALSE) &&
          complement != expenses[i] && complement != expenses[j]) {
        return(expenses[i] * expenses[j] * complement)
      }
    }
  }

  stop("No triple sums to the target.")
}

example_expenses <- read_expenses(input_example)
example_two <- find_two_sum_product(example_expenses)
example_three <- find_three_sum_product(example_expenses)
stopifnot(example_two == 514579)
stopifnot(example_three == 241861950)
cat("Part 1 example:", example_two, "\n")
cat("Part 2 example:", example_three, "\n")

actual_expenses <- read_expenses(input_actual)
actual_two <- find_two_sum_product(actual_expenses)
actual_three <- find_three_sum_product(actual_expenses)
cat("Part 1 actual:", actual_two, "\n")
cat("Part 2 actual:", actual_three, "\n")

Time    -  proc.time()