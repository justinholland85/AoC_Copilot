project_root <- "C:/Users/justi/OneDrive/Documents/GitHub/AoC_Copilot"
puzzle_directory <- file.path(project_root, "2025", "AoC_2025_01")
input_file <- file.path(puzzle_directory, "AoC_Input_2025_01_1.txt")
rotations <- readLines(input_file, warn = FALSE)
directions <- ifelse(substr(rotations, 1, 1) == "R", 1, -1)
distances <- as.numeric(sub("^[LR]", "", rotations))

# Part 1
position <- 50
password_part_1 <- 0

for (i in seq_along(rotations)) {
  position <- (position + directions[i] * distances[i]) %% 100
  if (position == 0) {
    password_part_1 <- password_part_1 + 1
  }
}

cat("Part 1:", password_part_1, "\n")

# Part 2
position <- 50
password_part_2 <- 0

for (i in seq_along(rotations)) {
  first_zero <- if (directions[i] == 1) {
    (100 - position) %% 100
  } else {
    position %% 100
  }

  if (first_zero == 0) {
    first_zero <- 100
  }

  if (distances[i] >= first_zero) {
    password_part_2 <- password_part_2 +
      1 + floor((distances[i] - first_zero) / 100)
  }

  position <- (position + directions[i] * distances[i]) %% 100
}

cat("Part 2:", password_part_2, "\n")