project_root <- "C:/Users/justi/OneDrive/Documents/GitHub/AoC_Copilot"
puzzle_directory <- file.path(project_root, "2025", "AoC_2025_01")
input_example <- file.path(puzzle_directory, "AoC_2025_01_Input_0.txt")
input_actual <- file.path(puzzle_directory, "AoC_2025_01_Input_1.txt")

read_rotations <- function(input_file) {
  rotations <- readLines(input_file, warn = FALSE)

  if (any(!grepl("^[LR][0-9]+$", rotations))) {
    stop("Input contains a rotation that is not formatted as L/R followed by digits.")
  }

  rotations
}

count_passwords <- function(rotations) {
  position <- 50
  zero_endings <- 0
  zero_clicks <- 0

  for (rotation in rotations) {
    direction <- substr(rotation, 1, 1)
    distance <- as.numeric(sub("^[LR]", "", rotation))

    first_zero <- if (direction == "R") {
      (100 - position) %% 100
    } else {
      position %% 100
    }
    if (first_zero == 0) {
      first_zero <- 100
    }

    if (distance >= first_zero) {
      zero_clicks <- zero_clicks + 1 + floor((distance - first_zero) / 100)
    }

    signed_distance <- if (direction == "R") distance else -distance
    position <- (position + signed_distance) %% 100

    if (position == 0) {
      zero_endings <- zero_endings + 1
    }
  }

  c(part_1 = zero_endings, part_2 = zero_clicks)
}

example_passwords <- count_passwords(read_rotations(input_example))
stopifnot(example_passwords[["part_1"]] == 3)
stopifnot(example_passwords[["part_2"]] == 6)
cat("Part 1 example:", example_passwords[["part_1"]], "\n")
cat("Part 2 example:", example_passwords[["part_2"]], "\n")

actual_passwords <- count_passwords(read_rotations(input_actual))
cat("Part 1 actual:", actual_passwords[["part_1"]], "\n")
cat("Part 2 actual:", actual_passwords[["part_2"]], "\n")
